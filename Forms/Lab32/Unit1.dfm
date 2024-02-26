object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '351005 '#1043#1072#1083#1091#1093#1072' '#1055#1072#1074#1077#1083' Lab32'
  ClientHeight = 430
  ClientWidth = 1029
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = Tabs
  Position = poScreenCenter
  OnCloseQuery = ExitOnCloseQuery
  OnCreate = MainFormOnCreate
  TextHeight = 23
  object TaskLabel: TLabel
    Left = 16
    Top = 16
    Width = 734
    Height = 40
    Caption = 
      #1044#1072#1085#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072' '#1092#1086#1088#1084#1080#1088#1091#1077#1090' '#1084#1085#1086#1078#1077#1089#1090#1074#1086' Y={X1 U X2 U X3} '#1080' '#1074#1099#1076#1077#1083#1103#1077#1090 +
      ' '#1080#1079' '#1085#1077#1075#1086' '#1087#1086#1076#1084#1085#1086#1078#1077#1089#1090#1074#1086' Y1, '#1082#1086#1090#1086#1088#1086#1077' '#1087#1088#1077#1076#1089#1090#1072#1074#1083#1103#1077#1090' '#1074#1089#1077' '#1094#1080#1092#1088#1099', '#1074#1093#1086#1076#1103#1097 +
      #1080#1077' '#1074' Y.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object X1SetLabel: TLabel
    Left = 16
    Top = 163
    Width = 184
    Height = 23
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1084#1085#1086#1078#1077#1089#1090#1074#1086' X1:'
    Enabled = False
    Visible = False
  end
  object X2SetLabel: TLabel
    Left = 352
    Top = 163
    Width = 184
    Height = 23
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1084#1085#1086#1078#1077#1089#1090#1074#1086' X2:'
    Enabled = False
    Visible = False
  end
  object X3SetLabel: TLabel
    Left = 693
    Top = 163
    Width = 184
    Height = 23
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1084#1085#1086#1078#1077#1089#1090#1074#1086' X3:'
    Enabled = False
    Visible = False
  end
  object YSetLabel: TLabel
    Left = 16
    Top = 331
    Width = 109
    Height = 23
    Caption = #1052#1085#1086#1078#1077#1089#1090#1074#1086' Y:'
  end
  object Y1SetLabel: TLabel
    Left = 352
    Top = 331
    Width = 146
    Height = 23
    Caption = #1055#1086#1076#1084#1085#1086#1078#1077#1089#1090#1074#1086' Y1:'
  end
  object X1SetLenLabel: TLabel
    Left = 16
    Top = 80
    Width = 234
    Height = 23
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1083#1080#1085#1091' '#1084#1085#1086#1078#1077#1089#1090#1074#1072' X1:'
  end
  object X2SetLenLabel: TLabel
    Left = 352
    Top = 80
    Width = 234
    Height = 23
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1083#1080#1085#1091' '#1084#1085#1086#1078#1077#1089#1090#1074#1072' X2:'
  end
  object X3SetLenLabel: TLabel
    Left = 693
    Top = 80
    Width = 234
    Height = 23
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1083#1080#1085#1091' '#1084#1085#1086#1078#1077#1089#1090#1074#1072' X3:'
  end
  object ResultButton: TButton
    Left = 16
    Top = 284
    Width = 145
    Height = 25
    Caption = #1053#1072#1081#1090#1080
    CommandLinkHint = #1053#1072#1081#1090#1080
    Enabled = False
    TabOrder = 0
    OnClick = ResultButtonOnClick
  end
  object X1SetStringGrid: TStringGrid
    Left = 16
    Top = 208
    Width = 320
    Height = 49
    DefaultRowHeight = 28
    Enabled = False
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs, goFixedRowDefAlign]
    ScrollBars = ssHorizontal
    TabOrder = 1
    Visible = False
    OnKeyDown = X1SetStringGridOnKeyDown
    OnKeyPress = X1SetStringGridOnKeyPress
    OnKeyUp = OnKeyUp
    OnSetEditText = SetOnSetEditText
  end
  object X2SetStringGrid: TStringGrid
    Left = 352
    Top = 208
    Width = 320
    Height = 49
    DefaultRowHeight = 28
    Enabled = False
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs, goFixedRowDefAlign]
    ScrollBars = ssHorizontal
    TabOrder = 2
    Visible = False
    OnKeyDown = X2SetStringGridOnKeyDown
    OnKeyPress = X2SetStringGridOnKeyPress
    OnKeyUp = OnKeyUp
    OnSetEditText = SetOnSetEditText
  end
  object X3SetStringGrid: TStringGrid
    Left = 693
    Top = 208
    Width = 320
    Height = 49
    DefaultRowHeight = 28
    Enabled = False
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs, goFixedRowDefAlign]
    ScrollBars = ssHorizontal
    TabOrder = 3
    Visible = False
    OnKeyDown = X3SetStringGridOnKeyDown
    OnKeyPress = X3SetStringGridOnKeyPress
    OnKeyUp = OnKeyUp
    OnSetEditText = SetOnSetEditText
  end
  object YSetStringGrid: TStringGrid
    Left = 8
    Top = 368
    Width = 325
    Height = 49
    DefaultRowHeight = 28
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goTabs, goFixedRowDefAlign]
    ScrollBars = ssHorizontal
    TabOrder = 4
  end
  object Y1SetStringGrid: TStringGrid
    Left = 352
    Top = 368
    Width = 325
    Height = 49
    DefaultRowHeight = 28
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goTabs, goFixedRowDefAlign]
    ScrollBars = ssHorizontal
    TabOrder = 5
  end
  object X1SetLenEdit: TEdit
    Left = 16
    Top = 115
    Width = 121
    Height = 31
    TabOrder = 6
    TextHint = #1044#1083#1080#1085#1072' X1'
    OnChange = X1SetEditOnChange
    OnContextPopup = X1SetEditOnContextPopup
    OnKeyDown = X1SetEditOnKeyDown
    OnKeyPress = X1SetEditOnKeyPress
    OnKeyUp = X1SetEditOnKeyUp
  end
  object X2SetLenEdit: TEdit
    Left = 352
    Top = 115
    Width = 121
    Height = 31
    TabOrder = 7
    TextHint = #1044#1083#1080#1085#1072' X2'
    OnChange = X2SetEditOnChange
    OnContextPopup = X2SetEditOnContextPopup
    OnKeyDown = X2SetEditOnKeyDown
    OnKeyPress = X2SetEditOnKeyPress
    OnKeyUp = X2SetEditOnKeyUp
  end
  object X3SetLenEdit: TEdit
    Left = 693
    Top = 115
    Width = 121
    Height = 31
    TabOrder = 8
    TextHint = #1044#1083#1080#1085#1072' X3'
    OnChange = X3SetEditOnChange
    OnContextPopup = X3SetEditOnContextPopup
    OnKeyDown = X3SetEditOnKeyDown
    OnKeyPress = X3SetEditOnKeyPress
    OnKeyUp = X3SetEditOnKeyUp
  end
  object Tabs: TMainMenu
    Left = 688
    Top = 368
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
    Left = 736
    Top = 368
  end
  object SaveFile: TSaveTextFileDialog
    DefaultExt = 'txt'
    Filter = '(*.txt)|*.txt'
    Left = 784
    Top = 368
  end
end
