object Lab: TLab
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '351005 '#1043#1072#1083#1091#1093#1072' '#1055#1072#1074#1077#1083' Lab13'
  ClientHeight = 451
  ClientWidth = 607
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
    Top = 8
    Width = 489
    Height = 60
    Caption = 
      #1044#1072#1085#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072' '#1089#1095#1080#1090#1072#1077#1090' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1092#1091#1085#1082#1094#1080#1080' sin^2(x) '#1074' '#1090#1086#1095#1082#1077' x '#1089' '#1087 +
      #1086#1084#1086#1097#1100#1102' '#1088#1103#1076#1072' '#1052#1072#1082#1083#1086#1088#1077#1085#1072', '#1087#1086#1082#1072' '#1095#1083#1077#1085' '#1088#1103#1076#1072' '#1085#1077' '#1076#1086#1089#1090#1080#1075#1085#1077#1090' EPS. '#1040' '#1090#1072#1082#1078#1077' ' +
      #1089#1095#1080#1090#1072#1077#1090' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1095#1083#1077#1085#1086#1074' '#1088#1103#1076#1072' n.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object EPSLabel: TLabel
    Left = 16
    Top = 88
    Width = 157
    Height = 20
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' EPS:'
  end
  object XLabel: TLabel
    Left = 16
    Top = 184
    Width = 140
    Height = 20
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' x:'
  end
  object ResultLabel: TLabel
    Left = 16
    Top = 328
    Width = 73
    Height = 20
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090': '
  end
  object ResultSinLabel: TLabel
    Left = 16
    Top = 366
    Width = 23
    Height = 20
    Caption = 'Sin:'
  end
  object ResultNLabel: TLabel
    Left = 200
    Top = 366
    Width = 11
    Height = 20
    Caption = 'n:'
  end
  object EPSEdit: TEdit
    Left = 16
    Top = 128
    Width = 157
    Height = 28
    MaxLength = 33
    TabOrder = 0
    TextHint = 'EPS'
    OnChange = EPSOnChange
    OnClick = EPSOnClick
    OnContextPopup = EPSOnContextPopup
    OnExit = EPSOnExit
    OnKeyDown = EPSOnKeyDown
    OnKeyPress = EPSOnKeyPress
    OnKeyUp = EPSOnKeyUp
  end
  object XEdit: TEdit
    Left = 16
    Top = 224
    Width = 157
    Height = 28
    TabOrder = 1
    TextHint = 'x'
    OnChange = XOnChange
    OnClick = XOnClick
    OnContextPopup = XOnContextPopup
    OnExit = XOnExit
    OnKeyDown = XOnKeyDown
    OnKeyPress = XOnKeyPress
    OnKeyUp = XOnKeyUp
  end
  object ResultButton: TButton
    Left = 16
    Top = 280
    Width = 97
    Height = 25
    Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100
    Enabled = False
    TabOrder = 2
    OnClick = ResultButtonOnClick
  end
  object ResultSinEdit: TEdit
    Left = 16
    Top = 406
    Width = 157
    Height = 28
    Enabled = False
    ReadOnly = True
    TabOrder = 3
    OnChange = ResultSinEditOnChange
    OnKeyDown = ResultSinOnKeyDown
  end
  object ResultNEdit: TEdit
    Left = 200
    Top = 406
    Width = 153
    Height = 28
    Enabled = False
    ReadOnly = True
    TabOrder = 4
    OnClick = ResultButtonOnClick
    OnKeyDown = ResultNOnKeyDown
  end
  object Tabs: TMainMenu
    Left = 512
    Top = 320
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
  object SaveFile: TSaveTextFileDialog
    DefaultExt = 'txt'
    Filter = 'Text files (*.txt)|*.txt'
    Left = 552
    Top = 272
  end
  object OpenFile: TOpenTextFileDialog
    DefaultExt = 'txt'
    Filter = 'Text files (*.txt)|*.txt'
    Left = 552
    Top = 320
  end
end
