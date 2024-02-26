object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '351005 '#1043#1072#1083#1091#1093#1072' '#1055#1072#1074#1077#1083' Lab31'
  ClientHeight = 507
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = Tabs
  Position = poScreenCenter
  OnCloseQuery = ExitOnCloseQuery
  TextHeight = 23
  object TaskLabel: TLabel
    Left = 16
    Top = 16
    Width = 391
    Height = 40
    Caption = 
      #1044#1072#1085#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072' '#1085#1072#1093#1086#1076#1080#1090' '#1101#1083#1077#1084#1077#1085#1090#1099' '#1074' '#1076#1074#1091#1093' '#1089#1090#1088#1086#1082#1072#1093' '#1087#1086' '#1086#1076#1085#1086#1084#1091' '#1080#1079' '#1082#1088 +
      #1080#1090#1077#1088#1080#1077#1074'.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object String1Label: TLabel
    Left = 24
    Top = 203
    Width = 166
    Height = 23
    Caption = #1042#1074#1077#1076#1080#1090#1077' 1-'#1091#1102' '#1089#1090#1088#1086#1082#1091':'
  end
  object String2Label: TLabel
    Left = 24
    Top = 291
    Width = 166
    Height = 23
    Caption = #1042#1074#1077#1076#1080#1090#1077' 2-'#1091#1102' '#1089#1090#1088#1086#1082#1091':'
  end
  object ResultLabel: TLabel
    Left = 24
    Top = 427
    Width = 80
    Height = 23
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
  end
  object ResultButton: TButton
    Left = 24
    Top = 387
    Width = 145
    Height = 25
    Caption = #1053#1072#1081#1090#1080
    CommandLinkHint = #1053#1072#1081#1090#1080
    Enabled = False
    TabOrder = 0
    OnClick = ResultButtonOnClick
  end
  object Action1RadioButton: TRadioButton
    Left = 24
    Top = 73
    Width = 337
    Height = 17
    Caption = #1054#1076#1080#1085#1072#1082#1086#1074#1099#1077' '#1089#1080#1084#1074#1086#1083#1099' '#1074' '#1086#1073#1077#1080#1093' '#1089#1090#1088#1086#1082#1072#1093
    TabOrder = 1
    OnClick = Action1RadioButtonOnClick
  end
  object Action2RadioButton: TRadioButton
    Left = 24
    Top = 112
    Width = 337
    Height = 17
    Caption = #1059#1085#1080#1082#1072#1083#1100#1085#1099#1077' '#1089#1080#1084#1074#1086#1083#1099' '#1074' 1-'#1086#1081' '#1089#1090#1088#1086#1082#1077
    TabOrder = 2
    OnClick = Action2RadioButtonOnClick
  end
  object Action3RadioButton: TRadioButton
    Left = 24
    Top = 152
    Width = 337
    Height = 17
    Caption = #1059#1085#1080#1082#1072#1083#1100#1085#1099#1077' '#1089#1080#1084#1074#1086#1083#1099' '#1074#1086' 2-'#1086#1081' '#1089#1090#1088#1086#1082#1077
    TabOrder = 3
    OnClick = Action3RadioButtonOnClick
  end
  object String1Edit: TEdit
    Left = 24
    Top = 243
    Width = 337
    Height = 31
    MaxLength = 100
    TabOrder = 4
    TextHint = #1055#1077#1088#1074#1072#1103' '#1089#1090#1088#1086#1082#1072
    OnChange = FieldsOnChange
  end
  object String2Edit: TEdit
    Left = 24
    Top = 331
    Width = 337
    Height = 31
    MaxLength = 100
    TabOrder = 5
    TextHint = #1042#1090#1086#1088#1072#1103' '#1089#1090#1088#1086#1082#1072
    OnChange = FieldsOnChange
  end
  object ResultEdit: TEdit
    Left = 24
    Top = 467
    Width = 383
    Height = 31
    Enabled = False
    ReadOnly = True
    TabOrder = 6
    OnChange = ResultEditOnChange
  end
  object Tabs: TMainMenu
    Left = 440
    Top = 24
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
      object SepLine: TMenuItem
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
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 440
    Top = 80
  end
  object SaveFile: TSaveTextFileDialog
    DefaultExt = 'txt'
    Filter = '(*.txt)|*.txt'
    Left = 440
    Top = 136
  end
end
