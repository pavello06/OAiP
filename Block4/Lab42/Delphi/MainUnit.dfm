object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '351005 '#1043#1072#1083#1091#1093#1072' '#1055#1072#1074#1077#1083' Lab4.2'
  ClientHeight = 548
  ClientWidth = 589
  Color = clBtnFace
  Constraints.MaxHeight = 620
  Constraints.MaxWidth = 620
  Constraints.MinHeight = 620
  Constraints.MinWidth = 607
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Menu = TabsMainMenu
  Position = poScreenCenter
  OnCloseQuery = MainFormCloseQuery
  OnHelp = MainFormHelp
  TextHeight = 25
  object TaskLabel: TLabel
    Left = 24
    Top = 24
    Width = 523
    Height = 93
    Caption = 
      #1044#1072#1085#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072' '#1089#1086#1089#1090#1072#1074#1083#1103#1077#1090' '#1074#1089#1077#1074#1086#1079#1084#1086#1078#1085#1099#1077' '#1087#1077#1088#1077#1089#1090#1072#1085#1086#1074#1082#1080' '#1088#1072#1079#1083#1080#1095#1085#1099#1093' ' +
      #1085#1072#1090#1091#1088#1072#1083#1100#1085#1099#1093' '#1095#1080#1089#1077#1083' '#1089' '#1087#1086#1084#1086#1097#1100#1102' '#1088#1077#1082#1091#1088#1089#1080#1080'.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object NumsLabel: TLabel
    Left = 24
    Top = 240
    Width = 324
    Height = 25
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1088#1072#1079#1083#1080#1095#1085#1099#1077' '#1085#1072#1090#1091#1088#1072#1083#1100#1085#1099#1077' '#1095#1080#1089#1083#1072':'
    Enabled = False
    Visible = False
  end
  object NumsAmountLabel: TLabel
    Left = 24
    Top = 144
    Width = 273
    Height = 25
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1094#1077#1083#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1095#1080#1089#1077#1083':'
  end
  object NumsStringGrid: TStringGrid
    Left = 24
    Top = 280
    Width = 68
    Height = 65
    ColCount = 1
    DefaultRowHeight = 30
    Enabled = False
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor, goFixedRowDefAlign]
    ScrollBars = ssHorizontal
    TabOrder = 0
    Visible = False
    OnExit = NumsStringGridExit
    OnKeyDown = NumsStringGridKeyDown
    OnKeyPress = NumsStringGridKeyPress
    OnKeyUp = NumsStringGridKeyUp
    OnSelectCell = NumsStringGridSelectCell
    OnSetEditText = NumsStringGridSetEditText
    ColWidths = (
      64)
  end
  object ResultButton: TButton
    Left = 24
    Top = 376
    Width = 233
    Height = 33
    Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090
    Enabled = False
    TabOrder = 1
    OnClick = ResultButtonClick
  end
  object ResultStringGrid: TStringGrid
    Left = 24
    Top = 431
    Width = 68
    Height = 66
    ColCount = 1
    DefaultRowHeight = 30
    Enabled = False
    FixedCols = 0
    RowCount = 2
    TabOrder = 2
    Visible = False
    ColWidths = (
      64)
  end
  object NumsAmountEdit: TEdit
    Left = 24
    Top = 184
    Width = 169
    Height = 33
    TabOrder = 3
    TextHint = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1095#1080#1089#1077#1083
    OnChange = NumsAmountEditChange
    OnContextPopup = NumsAmountEditContextPopup
    OnKeyDown = NumsAmountEditKeyDown
    OnKeyPress = NumsAmountEditKeyPress
    OnKeyUp = NumsAmountEditKeyUp
  end
  object TabsMainMenu: TMainMenu
    Left = 576
    Top = 24
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
  object OpenTextFileDialog1: TOpenTextFileDialog
    DefaultExt = 'txt'
    Filter = '(*.txt)|*.txt'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 576
    Top = 88
  end
  object SaveTextFileDialog1: TSaveTextFileDialog
    DefaultExt = 'txt'
    Filter = '(*.txt)|*.txt'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 576
    Top = 152
  end
end
