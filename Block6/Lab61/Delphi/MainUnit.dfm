object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '351005 '#1043#1072#1083#1091#1093#1072' '#1055#1072#1074#1077#1083' Lab61'
  ClientHeight = 482
  ClientWidth = 438
  Color = clBtnFace
  Constraints.MaxHeight = 520
  Constraints.MaxWidth = 450
  Constraints.MinHeight = 520
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = MainFormCreate
  OnHelp = MainFormHelp
  TextHeight = 15
  object WatchImage: TImage
    Left = 0
    Top = 0
    Width = 438
    Height = 385
    Align = alTop
    ExplicitWidth = 432
  end
  object StartButton: TButton
    Left = 32
    Top = 416
    Width = 377
    Height = 49
    Caption = 'Start'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -37
    Font.Name = 'Small Fonts'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = StartButtonClick
  end
  object WatchTimer: TTimer
    Interval = 200
    OnTimer = WatchTimerTimer
  end
end
