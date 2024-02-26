object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '351005 '#1043#1072#1083#1091#1093#1072' '#1055#1072#1074#1077#1083' Lab21'
  ClientHeight = 451
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = Tabs
  Position = poScreenCenter
  OnCloseQuery = ExitOnCloseQuery
  TextHeight = 20
  object TaskLabel: TLabel
    Left = 16
    Top = 16
    Width = 456
    Height = 60
    Caption = 
      #1044#1072#1085' '#1095#1080#1089#1083#1086#1074#1086#1081' '#1084#1072#1089#1089#1080#1074' '#1040', '#1089#1086#1089#1090#1086#1103#1097#1080#1081' '#1080#1079' n-'#1085#1072#1090#1091#1088#1072#1083#1100#1085#1099#1093' '#1095#1080#1089#1077#1083'. '#1054#1087#1088#1077#1076#1077#1083 +
      #1080#1090#1100' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1101#1083#1077#1084#1077#1085#1090#1086#1074' '#1084#1072#1089#1089#1080#1074#1072',  '#1080#1084#1077#1102#1097#1080#1093'   '#1095#1077#1090#1085#1099#1077'  '#1087#1086#1088#1103#1076#1082#1086#1074#1099#1077' ' +
      ' '#1085#1086#1084#1077#1088#1072'  '#1080'  '#1103#1074#1083#1103#1102#1097#1080#1093#1089#1103' '#1085#1077#1095#1077#1090#1085#1099#1084#1080' '#1095#1080#1089#1083#1072#1084#1080'.'
    WordWrap = True
  end
  object ArrLenLabel: TLabel
    Left = 16
    Top = 104
    Width = 178
    Height = 20
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1083#1080#1085#1091' '#1084#1072#1089#1089#1080#1074#1072' n:'
  end
  object ArrLabel: TLabel
    Left = 16
    Top = 192
    Width = 127
    Height = 20
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1084#1072#1089#1089#1080#1074' A:'
    Visible = False
  end
  object ResultLabel: TLabel
    Left = 16
    Top = 368
    Width = 69
    Height = 20
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
  end
  object ResultButton: TButton
    Left = 16
    Top = 321
    Width = 178
    Height = 25
    Caption = #1055#1086#1089#1095#1080#1090#1072#1090#1100
    Enabled = False
    TabOrder = 2
    OnClick = ResultButtonOnClick
  end
  object ArrLenEdit: TEdit
    Left = 16
    Top = 144
    Width = 178
    Height = 28
    TabOrder = 0
    TextHint = 'n'
    OnChange = ArrLenEditOnChange
    OnContextPopup = ArrLenEditOnContextPopup
    OnKeyDown = ArrLenEditOnKeyDown
    OnKeyPress = ArrLenEditOnKeyPress
    OnKeyUp = ArrLenEditOnKeyUp
  end
  object ArrStringGrid: TStringGrid
    Left = 8
    Top = 232
    Width = 329
    Height = 49
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goFixedRowDefAlign]
    ScrollBars = ssHorizontal
    TabOrder = 1
    Visible = False
    OnContextPopup = ArrStringGridOnContextPopup
    OnKeyDown = ArrStringGridOnKeyDown
    OnKeyPress = ArrStringGridOnKeyPress
    OnKeyUp = ArrLenEditOnKeyUp
  end
  object ResultEdit: TEdit
    Left = 16
    Top = 407
    Width = 178
    Height = 28
    Enabled = False
    ReadOnly = True
    TabOrder = 3
    OnChange = ResultEditOnChange
  end
  object Tabs: TMainMenu
    Left = 512
    Top = 328
    object FileTab: TMenuItem
      Caption = #1060#1072#1081#1083
      object OpenOption: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        ShortCut = 16463
        OnClick = OpenOptionOnClick
      end
      object SaveOption: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Enabled = False
        ShortCut = 16467
        OnClick = SaveOptionOnClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object ExitOption: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = ExitOptionOnClick
      end
    end
    object InstructionTab: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
      OnClick = InstructionTabOnClick
    end
    object DeveloperTab: TMenuItem
      Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
      OnClick = DeveloperTabOnClick
    end
  end
  object OpenFile: TOpenTextFileDialog
    DefaultExt = 'txt'
    Filter = '(*.txt)|*.txt'
    Left = 512
    Top = 280
  end
  object SaveFile: TSaveTextFileDialog
    Filter = '(*.txt)|*.txt'
    Left = 512
    Top = 240
  end
end
