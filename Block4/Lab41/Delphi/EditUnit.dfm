object EditForm: TEditForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1089#1087#1077#1082#1090#1072#1082#1083#1103
  ClientHeight = 330
  ClientWidth = 344
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = EditFormCreate
  OnKeyDown = EditFormKeyDown
  TextHeight = 25
  object NameLabel: TLabel
    Left = 23
    Top = 27
    Width = 78
    Height = 25
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077
  end
  object AuthorLabel: TLabel
    Left = 23
    Top = 75
    Width = 51
    Height = 25
    Caption = #1040#1074#1090#1086#1088
  end
  object DirectorLabel: TLabel
    Left = 23
    Top = 123
    Width = 78
    Height = 25
    Caption = #1056#1077#1078#1080#1089#1089#1105#1088
  end
  object DateLabel: TLabel
    Left = 23
    Top = 174
    Width = 37
    Height = 25
    Caption = #1044#1072#1090#1072
  end
  object TimeLabel: TLabel
    Left = 23
    Top = 224
    Width = 52
    Height = 25
    Caption = #1042#1088#1077#1084#1103
  end
  object NameEdit: TEdit
    Left = 144
    Top = 27
    Width = 186
    Height = 33
    MaxLength = 30
    TabOrder = 0
    TextHint = '1..30 '#1089#1080#1084#1074#1086#1083#1086#1074
    OnChange = ComponentChange
    OnKeyDown = ComponentKeyDown
  end
  object AuthorEdit: TEdit
    Left = 144
    Top = 75
    Width = 186
    Height = 33
    MaxLength = 30
    TabOrder = 1
    TextHint = '1..30 '#1089#1080#1084#1074#1086#1083#1086#1074
    OnChange = ComponentChange
    OnKeyDown = ComponentKeyDown
  end
  object DirectorEdit: TEdit
    Left = 144
    Top = 120
    Width = 186
    Height = 33
    MaxLength = 30
    TabOrder = 2
    TextHint = '1..30 '#1089#1080#1084#1074#1086#1083#1086#1074
    OnChange = ComponentChange
    OnKeyDown = ComponentKeyDown
  end
  object DatePicker: TDateTimePicker
    Left = 144
    Top = 174
    Width = 186
    Height = 33
    Date = 45327.000000000000000000
    Format = 'dd.MM.yyyy'
    Time = 45327.000000000000000000
    TabOrder = 3
    OnChange = ComponentChange
    OnKeyDown = ComponentKeyDown
  end
  object TimePicker: TDateTimePicker
    Left = 144
    Top = 224
    Width = 186
    Height = 33
    Date = 45322.000000000000000000
    Format = 'HH:mm'
    Time = 0.795833333329937900
    Kind = dtkTime
    TabOrder = 4
    OnChange = ComponentChange
    OnKeyDown = ComponentKeyDown
  end
  object OkButton: TButton
    Left = 23
    Top = 280
    Width = 130
    Height = 39
    Caption = #1054#1050
    TabOrder = 5
    OnClick = OkButtonClick
    OnKeyDown = ComponentKeyDown
  end
  object CancelButton: TButton
    Left = 200
    Top = 280
    Width = 130
    Height = 39
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 6
    OnClick = CloseButtonClick
    OnKeyDown = ComponentKeyDown
  end
end
