object Lab: TLab
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '351005 '#1043#1072#1083#1091#1093#1072' '#1055#1072#1074#1077#1083' Lab14'
  ClientHeight = 440
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = Tabs
  Position = poScreenCenter
  OnCloseQuery = ExitOnCloseQuery
  OnCreate = FormOnCreate
  TextHeight = 20
  object TaskLabel: TLabel
    Left = 16
    Top = 8
    Width = 550
    Height = 40
    Caption = 
      #1044#1072#1085#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072' '#1074#1099#1095#1080#1089#1083#1103#1077#1090' '#1090#1072#1073#1083#1080#1094#1091' '#1079#1085#1072#1095#1077#1085#1080#1081' '#1092#1091#1085#1082#1094#1080#1080' '#1091'=ax^2 + bx ' +
      '+ c '#1076#1083#1103' '#1079#1085#1072#1095#1077#1085#1080#1081' x, '#1080#1079#1084#1077#1085#1103#1102#1097#1080#1093#1089#1103' '#1086#1090' x0 '#1076#1086' xn, '#1089' '#1096#1072#1075#1086#1084' h  (x0 < x' +
      'n). '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object CoofALabel: TLabel
    Left = 16
    Top = 80
    Width = 141
    Height = 20
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' a:'
  end
  object CoofBLabel: TLabel
    Left = 192
    Top = 80
    Width = 146
    Height = 20
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' b: '
  end
  object CoofCLabel: TLabel
    Left = 376
    Top = 80
    Width = 140
    Height = 20
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1089':'
  end
  object StartXLabel: TLabel
    Left = 16
    Top = 168
    Width = 148
    Height = 20
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' x0:'
  end
  object EndXLabel: TLabel
    Left = 192
    Top = 168
    Width = 148
    Height = 20
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' xn:'
  end
  object StepLabel: TLabel
    Left = 376
    Top = 168
    Width = 141
    Height = 20
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' h:'
  end
  object ResultButton: TButton
    Left = 16
    Top = 275
    Width = 145
    Height = 25
    Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100
    Enabled = False
    TabOrder = 6
    OnClick = ResultButtonOnClick
  end
  object CoofAEdit: TEdit
    Left = 16
    Top = 120
    Width = 148
    Height = 28
    MaxLength = 20
    TabOrder = 0
    TextHint = 'a'
    OnChange = CoofAOnChange
    OnClick = CoofAOnClick
    OnContextPopup = CoofAOnContextPopup
    OnExit = CoofAOnExit
    OnKeyDown = CoofAOnKeyDown
    OnKeyPress = CoofAOnKeyPress
    OnKeyUp = CoofAOnKeyUp
  end
  object CoofBEdit: TEdit
    Left = 192
    Top = 120
    Width = 148
    Height = 28
    MaxLength = 20
    TabOrder = 1
    TextHint = 'b'
    OnChange = CoofBOnChange
    OnClick = CoofBOnClick
    OnContextPopup = CoofBOnContextPopup
    OnExit = CoofBOnExit
    OnKeyDown = CoofBOnKeyDown
    OnKeyPress = CoofBOnKeyPress
    OnKeyUp = CoofBOnKeyUp
  end
  object CoofCEdit: TEdit
    Left = 376
    Top = 120
    Width = 141
    Height = 28
    MaxLength = 20
    TabOrder = 2
    TextHint = #1089
    OnChange = CoofCOnChange
    OnClick = CoofCOnClick
    OnContextPopup = CoofCOnContextPopup
    OnExit = CoofCOnExit
    OnKeyDown = CoofCOnKeyDown
    OnKeyPress = CoofCOnKeyPress
    OnKeyUp = CoofCOnKeyUp
  end
  object StartXEdit: TEdit
    Left = 16
    Top = 208
    Width = 148
    Height = 28
    MaxLength = 20
    TabOrder = 3
    TextHint = 'x0'
    OnChange = StartXOnChange
    OnClick = StartXOnClick
    OnContextPopup = StartXOnContextPopup
    OnExit = StartXOnExit
    OnKeyDown = StartXOnKeyDown
    OnKeyPress = StartXOnKeyPress
    OnKeyUp = StartXOnKeyUp
  end
  object EndXEdit: TEdit
    Left = 192
    Top = 208
    Width = 148
    Height = 28
    MaxLength = 20
    TabOrder = 4
    TextHint = 'xn'
    OnChange = EndXOnChange
    OnClick = EndXOnClick
    OnContextPopup = EndXOnContextPopup
    OnExit = EndXOnExit
    OnKeyDown = EndXOnKeyDown
    OnKeyPress = EndXOnKeyPress
    OnKeyUp = EndXOnKeyUp
  end
  object StepEdit: TEdit
    Left = 376
    Top = 208
    Width = 141
    Height = 28
    MaxLength = 20
    TabOrder = 5
    TextHint = 'h'
    OnChange = StepOnChange
    OnClick = StepOnClick
    OnContextPopup = StepOnContextPopup
    OnExit = StepOnExit
    OnKeyDown = StepOnKeyDown
    OnKeyPress = StepOnKeyPress
    OnKeyUp = StepOnKeyUp
  end
  object ArrsXYStringGrid: TStringGrid
    Left = 16
    Top = 352
    Width = 521
    Height = 51
    Color = clBlack
    ColCount = 8
    Enabled = False
    RowCount = 2
    FixedRows = 0
    ScrollBars = ssHorizontal
    TabOrder = 7
  end
  object Tabs: TMainMenu
    Left = 568
    Top = 88
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
      object SeparatedLine: TMenuItem
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
    Left = 568
    Top = 216
  end
  object SaveFile: TSaveTextFileDialog
    DefaultExt = 'txt'
    Filter = '(*.txt)|*.txt'
    Left = 568
    Top = 152
  end
end
