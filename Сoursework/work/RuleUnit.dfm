object RuleForm: TRuleForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1088#1072#1074#1080#1083#1072
  ClientHeight = 562
  ClientWidth = 888
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -33
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = RuleFormCreate
  OnDestroy = RuleFormDestroy
  OnResize = RuleFormResize
  TextHeight = 45
  inline MenuFrame: TMenuFrame
    Left = 0
    Top = 0
    Width = 888
    Height = 562
    Align = alClient
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 882
    ExplicitHeight = 553
    inherited BackGroundImage: TImage
      Width = 888
      Height = 562
      ExplicitLeft = 0
      ExplicitWidth = 888
      ExplicitHeight = 562
    end
    inherited TitleLabel: TLabel
      Left = 224
      ExplicitLeft = 224
    end
    inherited MediaPlayer: TMediaPlayer
      Left = 608
      Top = 512
      ExplicitLeft = 608
      ExplicitTop = 512
    end
  end
  object BackPanel: TPanel
    Left = 320
    Top = 355
    Width = 217
    Height = 47
    Cursor = crHandPoint
    Caption = #1053#1072#1079#1072#1076
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold, fsItalic]
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    OnClick = BackPanelClick
    OnMouseEnter = PanelMouseEnter
    OnMouseLeave = PanelMouseLeave
  end
end
