unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FileCtrl, StdCtrls, Grids;

type
  TForm1 = class(TForm)
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
Var i,rc:integer;
begin
for i:=0 to FileListBox1.Items.Count-1 do
 begin
  rc:=StringGrid1.RowCount-1;
  StringGrid1.Cells[0,i]:=DirectoryListBox1.Directory;
  StringGrid1.Cells[1,i]:=FileListBox1.Items[i];
  if i=rc then StringGrid1.RowCount:=StringGrid1.RowCount+1;
 end;
end;

procedure TForm1.Button2Click(Sender: TObject);
Var i,rc:integer;
begin
for i:=0 to FileListBox1.Items.Count-1 do
 begin
  rc:=StringGrid1.RowCount-1;
  StringGrid1.Cells[2,i]:=DirectoryListBox1.Directory;
  StringGrid1.Cells[3,i]:=FileListBox1.Items[i];
  if i=rc then StringGrid1.RowCount:=StringGrid1.RowCount+1;
 end;
end;

procedure TForm1.Button3Click(Sender: TObject);
Var i,j,k:integer;
    s:string;
begin
k:=0;
for i:=0 to StringGrid1.RowCount-1 do
 begin
  s:=StringGrid1.Cells[1,i];
  for j:=0 to StringGrid1.RowCount-1 do
   begin
    if s=StringGrid1.Cells[3,j] then
     begin
      StringGrid1.Cells[4,k]:=s;
      k:=k+1;
     end;
   end;
 end;
end;

function ExecAndWait(const FileName, Params: ShortString; const WinState: Word): boolean; export;
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CmdLine: ShortString;
begin
  { Помещаем имя файла между кавычками, с соблюдением всех пробелов в именах Win9x }
  CmdLine := '"' + Filename + '" ' + Params;
  FillChar(StartInfo, SizeOf(StartInfo), #0);
  with StartInfo do
  begin
    cb := SizeOf(StartInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WinState;
  end;
  Result := CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,
                          CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
                          PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo);
  { Ожидаем завершения приложения }
  if Result then
  begin
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);
    { Free the Handles }
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
Var f:TextFile;
    d1,d2,s,d:string;
    i:integer;
begin
d:=DriveComboBox1.Drive+':\';
AssignFile(f,d+'1.bat');
Rewrite(f);
WriteLn(f,'mkdir 111');
d1:=d+'111\222';
d2:=d+'111\333';
WriteLn(f,'mkdir '+d1);
WriteLn(f,'mkdir '+d2);
CloseFile(f);
AssignFile(f,d+'2.bat');
Rewrite(f);
for i:=0 to StringGrid1.RowCount-1 do
 begin
  s:=StringGrid1.Cells[4,i];
  if s<>'' then
   begin
    WriteLn(f,'copy '+s+' '+d1+'\'+s);
   end;
 end;
CloseFile(f);
AssignFile(f,d+'3.bat');
Rewrite(f);
for i:=0 to StringGrid1.RowCount-1 do
 begin
  s:=StringGrid1.Cells[4,i];
  if s<>'' then
   begin
    WriteLn(f,'copy '+s+' '+d2+'\'+s);
   end;
 end;
CloseFile(f);
d1:=StringGrid1.Cells[0,0]+'\2.bat';
d2:=StringGrid1.Cells[2,0]+'\3.bat';
CopyFile(PAnsiChar(d+'2.bat'),PAnsiChar(d1),false);
CopyFile(PAnsiChar(d+'3.bat'),PAnsiChar(d2),false);
DeleteFile(d+'2.bat');
DeleteFile(d+'3.bat');
ExecAndWait(d+'1.bat','',SW_SHOWNORMAL);
ExecAndWait(d1,'',SW_SHOWNORMAL);
ExecAndWait(d2,'',SW_SHOWNORMAL);
AssignFile(f,d+'4.bat');
Rewrite(f);
WriteLn(f,'fc /b '+d+'111\222\*.* '+d+'111\333\*.*');
WriteLn(f,'comp '+d+'111\222\*.* '+d+'111\333\*.*');
CloseFile(f);
AssignFile(f,d+'5.bat');
Rewrite(f);
WriteLn(f,'4.bat>1.txt');
CloseFile(f);
ExecAndWait(d+'5.bat','',SW_SHOWNORMAL);
end;

Function MyRemoveDir(sDir:String):Boolean;
Var iIndex:Integer;
    SearchRec:TSearchRec;
    sFileName:String;
begin
Result:=False;
sDir:=sDir+'\*.*';
iIndex:=FindFirst(sDir, faAnyFile, SearchRec);
while iIndex = 0 do
 begin
  sFileName:=ExtractFileDir(sDir)+'\'+SearchRec.Name;
	if SearchRec.Attr = faDirectory then
	 begin
    if (SearchRec.Name <> '')and(SearchRec.Name <> '.')and(SearchRec.Name <> '..')then
     MyRemoveDir(sFileName);
   end
  else
   begin
    if SearchRec.Attr <> faArchive then FileSetAttr(sFileName, faArchive);
    if NOT DeleteFile(sFileName) then ShowMessage('Could NOT delete ' + sFileName);
   end;
	iIndex := FindNext(SearchRec);
 end;
FindClose(SearchRec);
RemoveDir(ExtractFileDir(sDir));
Result := True;
end;

procedure TForm1.Button5Click(Sender: TObject);
Var i:integer;
    d:string;
begin
d:=DriveComboBox1.Drive+':\';
if MyRemoveDir(d+'111') then
 begin
  DeleteFile(d+'1.bat');
  DeleteFile(d+'4.bat');
  DeleteFile(StringGrid1.Cells[0,0]+'\2.bat');
  DeleteFile(StringGrid1.Cells[2,0]+'\3.bat');
  for i:=0 to StringGrid1.RowCount-1 do
   begin
    StringGrid1.Cells[0,i]:='';
    StringGrid1.Cells[1,i]:='';
    StringGrid1.Cells[2,i]:='';
    StringGrid1.Cells[3,i]:='';
    StringGrid1.Cells[4,i]:='';
   end;
  StringGrid1.RowCount:=0;
 end;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
Form2.Show;
end;

end.
