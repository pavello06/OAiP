object ActionForm: TActionForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1042#1089#1090#1072#1074#1082#1072'/'#1059#1076#1072#1083#1077#1085#1080#1077' '#1091#1079#1083#1072
  ClientHeight = 117
  ClientWidth = 252
  Color = clBtnFace
  Constraints.MaxHeight = 162
  Constraints.MaxWidth = 264
  Constraints.MinHeight = 155
  Constraints.MinWidth = 264
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnKeyDown = AddFormKeyDown
  TextHeight = 25
  object NumberEdit: TEdit
    Left = 8
    Top = 27
    Width = 236
    Height = 33
    MaxLength = 9
    TabOrder = 0
    TextHint = '1..999'
    OnChange = NumberEditChange
    OnContextPopup = NumberEditContextPopup
    OnKeyDown = NumberEditKeyDown
    OnKeyPress = NumberEditKeyPress
    OnKeyUp = NumberEditKeyUp
  end
  object ActionButton: TButton
    Left = 8
    Top = 66
    Width = 89
    Height = 39
    Caption = #1044#1077#1081#1089#1090#1074#1080#1077
    Enabled = False
    TabOrder = 2
    OnClick = ActionButtonClick
  end
  object CancelButton: TButton
    Left = 155
    Top = 66
    Width = 89
    Height = 39
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = CloseButtonClick
  end
end
