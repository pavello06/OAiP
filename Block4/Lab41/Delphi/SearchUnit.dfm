object SearchForm: TSearchForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1053#1072#1081#1090#1080' '#1089#1087#1077#1082#1090#1072#1082#1083#1100
  ClientHeight = 209
  ClientWidth = 324
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = SearchFormCreate
  OnKeyDown = SearchFormKeyDown
  TextHeight = 25
  object SearchLabel: TLabel
    Left = 8
    Top = 24
    Width = 292
    Height = 62
    Caption = #1059#1082#1072#1078#1080#1090#1077' '#1076#1072#1090#1091', '#1082' '#1082#1086#1090#1086#1088#1086#1081' '#1074#1099' '#1093#1086#1090#1080#1090#1077' '#1085#1072#1081#1090#1080' '#1089#1087#1077#1082#1090#1072#1082#1083#1100':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object SearchDateTimePicker: TDateTimePicker
    Left = 8
    Top = 112
    Width = 314
    Height = 33
    Date = 45327.000000000000000000
    Format = 'dd.MM.yyyy HH:mm'
    Time = 0.795833333329937900
    DateFormat = dfLong
    DoubleBuffered = False
    Kind = dtkDateTime
    ParentDoubleBuffered = False
    TabOrder = 0
    OnKeyDown = ComponentKeyDown
  end
  object SearchButton: TButton
    Left = 8
    Top = 161
    Width = 129
    Height = 40
    Caption = #1053#1072#1081#1090#1080
    TabOrder = 1
    OnClick = SearchButtonClick
  end
  object CancelButton: TButton
    Left = 192
    Top = 161
    Width = 130
    Height = 39
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = CloseButtonClick
  end
end
