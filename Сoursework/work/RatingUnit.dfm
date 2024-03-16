object RatingForm: TRatingForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1056#1077#1081#1090#1080#1085#1075
  ClientHeight = 562
  ClientWidth = 888
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  WindowState = wsMaximized
  OnResize = RatingFormResize
  TextHeight = 15
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
      Left = 228
      ExplicitLeft = 228
    end
    inherited MediaPlayer: TMediaPlayer
      Left = 608
      Top = 496
      ExplicitLeft = 608
      ExplicitTop = 496
    end
  end
  object BackPanel: TPanel
    Left = 328
    Top = 323
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
  object RatingStringGrid: TStringGrid
    Left = 272
    Top = 176
    Width = 320
    Height = 120
    Color = clHotLight
    ColCount = 2
    DefaultColWidth = 250
    DefaultRowHeight = 40
    FixedCols = 0
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goFixedRowDefAlign]
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
