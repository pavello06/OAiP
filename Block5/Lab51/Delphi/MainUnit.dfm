object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1043#1072#1083#1091#1093#1072' '#1055#1072#1074#1077#1083' 351005 Lab51'
  ClientHeight = 228
  ClientWidth = 527
  Color = clBtnFace
  Constraints.MaxHeight = 304
  Constraints.MaxWidth = 545
  Constraints.MinHeight = 300
  Constraints.MinWidth = 545
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Menu = TabsMainMenu
  Position = poScreenCenter
  OnCloseQuery = MainFormCloseQuery
  OnCreate = MainFormCreate
  OnHelp = MainFormHelp
  TextHeight = 25
  object AddButton: TButton
    Left = 8
    Top = 16
    Width = 121
    Height = 41
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 0
    OnClick = AddButtonClick
  end
  object DeleteButton: TButton
    Left = 8
    Top = 96
    Width = 121
    Height = 41
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 1
    OnClick = DeleteButtonClick
  end
  object ReverseButton: TButton
    Left = 8
    Top = 173
    Width = 121
    Height = 41
    Caption = #1055#1077#1088#1077#1074#1077#1088#1085#1091#1090#1100
    TabOrder = 2
    OnClick = ReverseButtonClick
  end
  object NumberStringGrid: TStringGrid
    Left = 147
    Top = 16
    Width = 361
    Height = 26
    ColCount = 1
    DefaultColWidth = 361
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goFixedRowDefAlign]
    ScrollBars = ssNone
    TabOrder = 3
  end
  object TabsMainMenu: TMainMenu
    Left = 152
    Top = 56
    object FileMenuItem: TMenuItem
      Caption = #1060#1072#1081#1083
      object OpenMenuItem: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        ShortCut = 16463
        OnClick = OpenMenuItemClick
      end
      object SaveMenuItem: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Enabled = False
        ShortCut = 16467
        OnClick = SaveMenuItemClick
      end
      object SeparatorMenuItem: TMenuItem
        Caption = '-'
      end
      object ExitMenuItem: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        ShortCut = 16465
        OnClick = ExitMenuItemClick
      end
    end
    object InstructionMenuItem: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
      ShortCut = 112
      OnClick = InstructionMenuItemClick
    end
    object DeveloperMenuItem: TMenuItem
      Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
      OnClick = DeveloperMenuItemClick
    end
  end
  object SaveDialog: TSaveTextFileDialog
    DefaultExt = 'txt'
    Filter = '(*.txt)|*.txt'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 319
    Top = 56
  end
  object OpenDialog: TOpenTextFileDialog
    Filter = '(*.txt)|*.txt'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 240
    Top = 56
  end
end
