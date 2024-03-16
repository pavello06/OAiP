object StartForm: TStartForm
  Left = 0
  Top = 0
  HelpContext = 1
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1089#1090#1088#1080#1095#1082#1080
  ClientHeight = 562
  ClientWidth = 888
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -25
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  WindowState = wsMaximized
  OnResize = StartFormResize
  TextHeight = 35
  inline MenuFrame: TMenuFrame
    Left = 0
    Top = 0
    Width = 888
    Height = 562
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 882
    ExplicitHeight = 553
    inherited BackGroundImage: TImage
      Width = 888
      Height = 562
      ExplicitWidth = 888
      ExplicitHeight = 562
    end
    inherited TitleLabel: TLabel
      Left = 248
      Top = 16
      ExplicitLeft = 248
      ExplicitTop = 16
    end
    inherited MediaPlayer: TMediaPlayer
      Left = 592
      Top = 488
      ExplicitLeft = 592
      ExplicitTop = 488
    end
  end
  object PlayPanel: TPanel
    Left = 336
    Top = 144
    Width = 217
    Height = 50
    Cursor = crHandPoint
    Caption = #1048#1075#1088#1072#1090#1100
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold, fsItalic]
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    OnMouseEnter = PanelMouseEnter
    OnMouseLeave = PanelMouseLeave
  end
  object RatingPanel: TPanel
    Left = 336
    Top = 286
    Width = 217
    Height = 44
    Cursor = crHandPoint
    Caption = #1056#1077#1081#1090#1080#1085#1075
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold, fsItalic]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    OnClick = RatingPanelClick
    OnMouseEnter = PanelMouseEnter
    OnMouseLeave = PanelMouseLeave
  end
  object RulePanel: TPanel
    Left = 336
    Top = 215
    Width = 217
    Height = 50
    Cursor = crHandPoint
    Caption = #1055#1088#1072#1074#1080#1083#1072
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold, fsItalic]
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    OnClick = RulePanelClick
    OnMouseEnter = PanelMouseEnter
    OnMouseLeave = PanelMouseLeave
  end
  object SettingsPanel: TPanel
    Left = 336
    Top = 352
    Width = 217
    Height = 50
    Cursor = crHandPoint
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold, fsItalic]
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
    OnClick = SettingsPanelClick
    OnMouseEnter = PanelMouseEnter
    OnMouseLeave = PanelMouseLeave
  end
  object ExitPanel: TPanel
    Left = 336
    Top = 426
    Width = 217
    Height = 47
    Cursor = crHandPoint
    Caption = #1042#1099#1081#1090#1080
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold, fsItalic]
    ParentBackground = False
    ParentFont = False
    TabOrder = 5
    OnMouseEnter = PanelMouseEnter
    OnMouseLeave = PanelMouseLeave
  end
end
