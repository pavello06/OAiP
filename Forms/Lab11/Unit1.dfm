object Lab11: TLab11
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '351005 '#1043#1072#1083#1091#1093#1072' '#1055#1072#1074#1077#1083' Lab11'
  ClientHeight = 485
  ClientWidth = 509
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
  object Task: TLabel
    Left = 8
    Top = 8
    Width = 469
    Height = 60
    Caption = 
      #1044#1072#1085#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072' '#1087#1088#1086#1074#1077#1088#1103#1077#1090' '#1087#1086#1087#1072#1076#1072#1077#1090' '#1083#1080' '#1090#1086#1095#1082#1072' '#1089' '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1072#1084#1080' ('#1093', ' +
      #1091') '#1085#1072' '#1086#1082#1088#1091#1078#1085#1086#1089#1090#1100' '#1089' '#1094#1077#1085#1090#1088#1086#1084' (0, 0) '#1089' '#1088#1072#1076#1080#1091#1089#1086#1084' R. ('#1074#1089#1077' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1086#1082 +
      #1088#1091#1075#1083#1103#1102#1090#1089#1103' '#1076#1086' '#1090#1088#1105#1093' '#1079#1085#1072#1082#1086#1074' '#1087#1086#1089#1083#1077' '#1079#1072#1087#1103#1090#1086#1081')'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object EnterXLabel: TLabel
    Left = 8
    Top = 94
    Width = 230
    Height = 20
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1088#1086#1073#1085#1091#1102' '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1091'  '#1093': '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object EnterYLabel: TLabel
    Left = 8
    Top = 176
    Width = 230
    Height = 20
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1088#1086#1073#1085#1091#1102' '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1091'  y: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object EnterRLabel: TLabel
    Left = 8
    Top = 257
    Width = 314
    Height = 20
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1088#1086#1073#1085#1099#1081' '#1087#1086#1083#1086#1078#1080#1090#1077#1083#1100#1085#1099#1081' '#1088#1072#1076#1080#1091#1089' R: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object ResultLabel: TLabel
    Left = 8
    Top = 392
    Width = 69
    Height = 20
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object ResultButton: TButton
    Left = 8
    Top = 344
    Width = 164
    Height = 25
    Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = ResultButtonOnClick
  end
  object EnterXEdit: TEdit
    Left = 8
    Top = 129
    Width = 200
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 11
    ParentFont = False
    TabOrder = 0
    TextHint = 'x'
    OnChange = XOnChange
    OnClick = XOnClick
    OnContextPopup = XOnContextPopup
    OnExit = XOnExit
    OnKeyDown = XOnKeyDown
    OnKeyPress = XOnKeyPress
  end
  object EnterYEdit: TEdit
    Left = 8
    Top = 216
    Width = 200
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 11
    ParentFont = False
    TabOrder = 1
    TextHint = 'y'
    OnChange = YOnChange
    OnClick = YOnClick
    OnContextPopup = YOnContextPopup
    OnExit = YOnExit
    OnKeyDown = YOnKeyDown
    OnKeyPress = YOnKeyPress
  end
  object EnterREdit: TEdit
    Left = 8
    Top = 289
    Width = 200
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 11
    ParentFont = False
    TabOrder = 2
    TextHint = 'R'
    OnChange = ROnChange
    OnClick = ROnClick
    OnContextPopup = ROnContextPopup
    OnExit = ROnExit
    OnKeyDown = ROnKeyDown
    OnKeyPress = ROnKeyPress
  end
  object ResultEdit: TEdit
    Left = 8
    Top = 432
    Width = 314
    Height = 28
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlightText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    OnChange = ResultOnChange
    OnKeyDown = ResultOnKeyDown
  end
  object Tabs: TMainMenu
    Left = 392
    Top = 216
    object FileTab: TMenuItem
      Caption = #1060#1072#1081#1083
      object OpenOption: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        ShortCut = 16463
        OnClick = OpenOnClick
      end
      object SaveOption: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Enabled = False
        ShortCut = 16467
        OnClick = SaveOnClick
      end
      object ExitOption: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = ExitOnClick
      end
    end
    object InstructionTab: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
      OnClick = InstructionOnClick
    end
    object DeveloperTab: TMenuItem
      Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
      OnClick = DeveloperOnClick
    end
  end
  object OpenFile: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Text files (*.txt)|*.txt'
    Left = 360
    Top = 216
  end
end
