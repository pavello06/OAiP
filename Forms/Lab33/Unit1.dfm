object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '351005 '#1043#1072#1083#1091#1093#1072' '#1055#1072#1074#1077#1083' Lab33'
  ClientHeight = 592
  ClientWidth = 710
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = Tabs
  Position = poScreenCenter
  OnCloseQuery = ExitOnCloseQuery
  TextHeight = 25
  object TaskLabel: TLabel
    Left = 8
    Top = 8
    Width = 377
    Height = 50
    Caption = 
      #1044#1072#1085#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072' '#1088#1077#1072#1083#1080#1079#1091#1077#1090' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1091' "'#1052#1077#1090#1086#1076' '#1076#1074#1091#1093#1087#1091#1090#1077#1074#1099#1093' '#1074#1089#1090#1072#1074#1086#1082 +
      '".'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object ArrLenLabel: TLabel
    Left = 8
    Top = 88
    Width = 194
    Height = 25
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1083#1080#1085#1091' '#1084#1072#1089#1089#1080#1074#1072':'
  end
  object ArrLabel: TLabel
    Left = 8
    Top = 176
    Width = 132
    Height = 25
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1084#1072#1089#1089#1080#1074':'
    Visible = False
  end
  object ProcessLabel: TLabel
    Left = 8
    Top = 368
    Width = 52
    Height = 25
    Caption = #1064#1072#1075' 0:'
    Enabled = False
    Visible = False
  end
  object ResultLabel: TLabel
    Left = 368
    Top = 368
    Width = 86
    Height = 25
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090': '
    Enabled = False
    Visible = False
  end
  object ResultButton: TButton
    Left = 8
    Top = 321
    Width = 178
    Height = 25
    Caption = #1055#1086#1089#1095#1080#1090#1072#1090#1100
    Enabled = False
    TabOrder = 2
    OnClick = ResultButtonOnClick
  end
  object ArrLenEdit: TEdit
    Left = 8
    Top = 128
    Width = 194
    Height = 33
    TabOrder = 0
    TextHint = #1044#1083#1080#1085#1072' '#1084#1072#1089#1089#1080#1074#1072
    OnChange = ArrLenEditOnChange
    OnContextPopup = ArrLenEditOnContextPopup
    OnKeyDown = ArrLenEditOnKeyDown
    OnKeyPress = ArrLenEditOnKeyPress
    OnKeyUp = ArrLenEditOnKeyUp
  end
  object ArrStringGrid: TStringGrid
    Left = 8
    Top = 215
    Width = 329
    Height = 66
    DefaultRowHeight = 28
    DoubleBuffered = False
    DrawingStyle = gdsGradient
    FixedCols = 0
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Segoe UI'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs, goFixedRowDefAlign]
    ParentDoubleBuffered = False
    ParentFont = False
    ScrollBars = ssHorizontal
    TabOrder = 1
    Visible = False
    OnContextPopup = ArrStringGridOnContextPopup
    OnKeyDown = ArrStringGridOnKeyDown
    OnKeyPress = ArrStringGridOnKeyPress
    OnKeyUp = ArrStringGridOnKeyUp
    OnSetEditText = ArrStringGridOnSetEditText
    ColWidths = (
      64
      64
      64
      64
      64)
  end
  object ProcessStringGrid: TStringGrid
    Left = 8
    Top = 399
    Width = 329
    Height = 90
    DefaultRowHeight = 28
    Enabled = False
    FixedCols = 0
    RowCount = 3
    TabOrder = 3
    Visible = False
    ColWidths = (
      64
      64
      64
      64
      64)
  end
  object ResultStringGrid: TStringGrid
    Left = 368
    Top = 399
    Width = 329
    Height = 57
    DefaultRowHeight = 28
    Enabled = False
    FixedCols = 0
    RowCount = 2
    ScrollBars = ssHorizontal
    TabOrder = 4
    Visible = False
    ColWidths = (
      64
      64
      64
      64
      64)
  end
  object Tabs: TMainMenu
    Left = 464
    Top = 40
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
    Left = 464
    Top = 88
  end
  object SaveFile: TSaveTextFileDialog
    DefaultExt = 'txt'
    Filter = '(*.txt)|*.txt'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 464
    Top = 152
  end
end
