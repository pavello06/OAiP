object Lab: TLab
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '351005 '#1043#1072#1083#1091#1093#1072' '#1055#1072#1074#1077#1083' Lab22'
  ClientHeight = 292
  ClientWidth = 434
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
    Width = 369
    Height = 20
    Caption = #1044#1072#1085#1086' '#1085#1072#1090#1091#1088#1072#1083#1100#1085#1086#1077' P.  '#1053#1072#1081#1090#1080' '#1089#1091#1084#1084#1091' '#1094#1080#1092#1088' '#1095#1080#1089#1083#1072' P.'
    WordWrap = True
  end
  object PNumLabel: TLabel
    Left = 16
    Top = 62
    Width = 141
    Height = 20
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' P:'
  end
  object ResultLabel: TLabel
    Left = 16
    Top = 208
    Width = 69
    Height = 20
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
  end
  object ResultButton: TButton
    Left = 16
    Top = 160
    Width = 145
    Height = 25
    Caption = #1055#1086#1089#1095#1080#1090#1072#1090#1100
    Enabled = False
    TabOrder = 0
    OnClick = ResultButtonOnClick
  end
  object PNumEdit: TEdit
    Left = 16
    Top = 104
    Width = 141
    Height = 28
    MaxLength = 6
    TabOrder = 1
    OnChange = PNumEditOnChange
    OnContextPopup = PNumEditOnContextPopup
    OnKeyDown = PNumEditOnKeyDown
    OnKeyPress = PNumEditOnKeyPress
    OnKeyUp = PNumEditOnKeyUp
  end
  object ResultEdit: TEdit
    Left = 16
    Top = 248
    Width = 141
    Height = 28
    Enabled = False
    ReadOnly = True
    TabOrder = 2
    OnChange = ResultEditOnChange
  end
  object Tabs: TMainMenu
    Left = 360
    Top = 56
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
    Left = 360
    Top = 112
  end
  object SaveFile: TSaveTextFileDialog
    DefaultExt = 'txt'
    Filter = '(*.txt)|*.txt'
    Left = 360
    Top = 176
  end
end
