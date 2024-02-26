object Lab: TLab
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '351005 '#1043#1072#1083#1091#1093#1072' '#1055#1072#1074#1077#1083' Lab12'
  ClientHeight = 310
  ClientWidth = 562
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
    Width = 479
    Height = 40
    Caption = 
      #1044#1072#1085#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072' '#1087#1088#1086#1074#1077#1088#1103#1077#1090' '#1092#1086#1088#1084#1091#1083#1091' '#1089#1091#1084#1084#1099' '#1072#1088#1080#1092#1084#1077#1090#1080#1095#1077#1089#1082#1086#1081' '#1087#1088#1086#1075#1088#1077#1089#1080 +
      #1080': 1 + 2 + 3 +'#8230'+ n = n(n + 1)/2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object NLabel: TLabel
    Left = 16
    Top = 80
    Width = 209
    Height = 20
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1085#1072#1090#1091#1088#1072#1083#1100#1085#1086#1077' '#1095#1080#1089#1083#1086' n:'
  end
  object ResultLabel: TLabel
    Left = 16
    Top = 224
    Width = 76
    Height = 20
    Caption = #1056#1077#1091#1079#1091#1083#1100#1090#1072#1090':'
  end
  object NEdit: TEdit
    Left = 16
    Top = 120
    Width = 209
    Height = 28
    MaxLength = 6
    TabOrder = 0
    TextHint = 'n'
    OnChange = NOnChange
    OnClick = NOnClick
    OnContextPopup = NOnContextPopup
    OnKeyDown = NEditOnKeyDown
    OnKeyPress = NEditOnKeyPress
    OnKeyUp = NEditOnKeyUp
  end
  object ResultButton: TButton
    Left = 16
    Top = 176
    Width = 97
    Height = 25
    Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
    Enabled = False
    TabOrder = 1
    OnClick = ResultButtonOnClick
  end
  object ResultEdit: TEdit
    Left = 16
    Top = 264
    Width = 209
    Height = 28
    Enabled = False
    ReadOnly = True
    TabOrder = 2
    OnChange = ResultEditOnChange
    OnKeyDown = ResultOnKeyDown
  end
  object Tabs: TMainMenu
    Left = 520
    Top = 264
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
  object OpenFile: TOpenDialog
    DefaultExt = 'txt'
    Filter = '(*.txt)|*.txt'
    Left = 472
    Top = 264
  end
end
