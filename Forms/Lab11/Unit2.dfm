object InstructionForm: TInstructionForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
  ClientHeight = 212
  ClientWidth = 461
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clInfoText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 20
  object InstructionLabel1: TLabel
    Left = 8
    Top = 8
    Width = 361
    Height = 40
    Caption = 
      '1. '#1050#1086#1086#1088#1076#1080#1085#1072#1090#1099' '#1090#1086#1095#1082#1080' '#1093' '#1080' '#1091' '#1076#1086#1083#1078#1085#1099' '#1073#1099#1090#1100' '#1076#1088#1086#1073#1085#1099#1084#1080' '#1095#1080#1089#1083#1072#1084#1080' '#1074' '#1076#1080#1072#1087#1072#1079#1086 +
      #1085#1077' [-30000; 30000]. '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object InstructionLabel2: TLabel
    Left = 8
    Top = 48
    Width = 335
    Height = 40
    Caption = 
      '2. '#1056#1072#1076#1080#1091#1089' '#1086#1082#1088#1091#1078#1085#1086#1089#1090#1080' R '#1076#1086#1083#1078#1077#1085' '#1073#1099#1090#1100' '#1076#1088#1086#1073#1085#1099#1084' '#1087#1086#1083#1086#1078#1080#1090#1077#1083#1100#1085#1099#1084' '#1095#1080#1089#1083#1086#1084' ' +
      #1074' '#1076#1080#1072#1087#1072#1079#1086#1085#1077' (0; 50000].'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object InstructionLabel3: TLabel
    Left = 8
    Top = 88
    Width = 402
    Height = 60
    Caption = 
      '3. '#1060#1072#1081#1083' '#1076#1086#1083#1078#1077#1085' '#1089#1086#1076#1077#1088#1078#1072#1090#1100' '#1090#1088#1080' '#1089#1090#1088#1086#1082#1080': '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1072' '#1093', '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1072' '#1091' ' +
      #1088#1072#1076#1080#1091#1089' R. '#1047#1085#1072#1095#1077#1085#1080#1103' '#1076#1086#1083#1078#1085#1099' '#1091#1076#1086#1074#1083#1077#1090#1074#1086#1088#1103#1090#1100' '#1074#1099#1096#1077#1087#1077#1088#1077#1095#1080#1089#1086#1077#1085#1085#1099#1084' '#1091#1089#1083#1086#1074#1080 +
      #1103#1084'.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object InstructionCloseButton: TButton
    Left = 192
    Top = 165
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = InstructionCloseButtonOnClick
  end
end
