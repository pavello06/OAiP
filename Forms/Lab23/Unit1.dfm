object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '351005 '#1043#1072#1083#1091#1093#1072' '#1055#1072#1074#1077#1083' Lab23'
  ClientHeight = 555
  ClientWidth = 577
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
    Width = 482
    Height = 69
    Caption = 
      #1044#1072#1085#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072' '#1087#1086#1076#1089#1095#1080#1090#1099#1074#1072#1077#1090' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1090#1088#1086#1082' '#1084#1072#1090#1088#1080#1094#1099' A '#1087#1086#1088#1103#1076#1082#1072 +
      ' n, '#1101#1083#1077#1084#1077#1085#1090#1099' '#1082#1086#1090#1086#1088#1099#1093' '#1087#1088#1077#1076#1089#1090#1072#1074#1083#1103#1102#1090' '#1087#1077#1088#1077#1089#1090#1072#1085#1086#1074#1082#1080' '#1095#1080#1089#1077#1083' '#1086#1090' 1 '#1076#1086' n.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object MatrixOrderLabel: TLabel
    Left = 16
    Top = 112
    Width = 241
    Height = 23
    Caption = #1042#1099#1073#1077#1088#1077#1090#1077' '#1087#1086#1088#1103#1076#1086#1082' '#1084#1072#1090#1088#1080#1094#1099' n:'
  end
  object MatrixLabel: TLabel
    Left = 16
    Top = 200
    Width = 154
    Height = 23
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1084#1072#1090#1088#1080#1094#1091' A:'
    Enabled = False
    Visible = False
  end
  object ResultLabel: TLabel
    Left = 16
    Top = 483
    Width = 80
    Height = 23
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
  end
  object MatrixOrderComboBox: TComboBox
    Left = 16
    Top = 152
    Width = 241
    Height = 31
    Style = csDropDownList
    TabOrder = 0
    TextHint = #1055#1086#1088#1103#1076#1086#1082' '#1084#1072#1090#1088#1080#1094#1099' n'
    OnChange = MatrixOrderOnChange
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10')
  end
  object ResultButton: TButton
    Left = 16
    Top = 440
    Width = 154
    Height = 25
    Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100
    Enabled = False
    TabOrder = 1
    OnClick = ResultButtonOnClick
  end
  object ResultEdit: TEdit
    Left = 16
    Top = 520
    Width = 154
    Height = 31
    Enabled = False
    ReadOnly = True
    TabOrder = 2
    OnChange = ResultEditOnChange
  end
  object MatrixStringGrid: TStringGrid
    Left = 16
    Top = 240
    Width = 393
    Height = 169
    ColCount = 6
    DefaultRowHeight = 27
    RowCount = 6
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs, goFixedRowDefAlign]
    TabOrder = 3
    Visible = False
    OnKeyDown = MatrixStringGridOnKeyDown
    OnKeyPress = MatrixStringGridOnKeyPress
    OnKeyUp = MatrixStringGridOnKeyUp
    OnSetEditText = MatrixOnSetEditText
  end
  object Tabs: TMainMenu
    Left = 536
    Top = 16
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
    Left = 536
    Top = 72
  end
  object SaveFile: TSaveTextFileDialog
    DefaultExt = 'txt'
    Filter = '(*.txt)|*.txt'
    Left = 536
    Top = 128
  end
end
