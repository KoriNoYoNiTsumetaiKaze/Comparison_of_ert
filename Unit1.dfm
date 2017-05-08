object Form1: TForm1
  Left = 192
  Top = 124
  Width = 928
  Height = 480
  Caption = #1057#1088#1072#1074#1085#1077#1085#1080#1077' ert'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DriveComboBox1: TDriveComboBox
    Left = 8
    Top = 16
    Width = 145
    Height = 19
    DirList = DirectoryListBox1
    TabOrder = 0
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 8
    Top = 48
    Width = 177
    Height = 377
    FileList = FileListBox1
    ItemHeight = 16
    TabOrder = 1
  end
  object FileListBox1: TFileListBox
    Left = 192
    Top = 48
    Width = 153
    Height = 361
    ItemHeight = 13
    Mask = '*.ert'
    TabOrder = 2
  end
  object StringGrid1: TStringGrid
    Left = 352
    Top = 48
    Width = 385
    Height = 361
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 3
  end
  object Button1: TButton
    Left = 360
    Top = 16
    Width = 75
    Height = 25
    Caption = #1055#1077#1088#1074#1099#1081
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 496
    Top = 16
    Width = 75
    Height = 25
    Caption = #1042#1090#1086#1088#1086#1081
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 624
    Top = 16
    Width = 75
    Height = 25
    Caption = #1057#1088#1072#1074#1085#1080#1090#1100
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 736
    Top = 16
    Width = 75
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100
    TabOrder = 7
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 256
    Top = 16
    Width = 75
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 8
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 800
    Top = 400
    Width = 75
    Height = 25
    Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
    TabOrder = 9
    OnClick = Button6Click
  end
end
