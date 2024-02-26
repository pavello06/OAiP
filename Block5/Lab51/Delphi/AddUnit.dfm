object AddForm: TAddForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1085#1086#1084#1077#1088#1072
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
  object NumberLabel: TLabel
    Left = 8
    Top = 27
    Width = 61
    Height = 25
    Caption = #1053#1086#1084#1077#1088':'
  end
  object NumberEdit: TEdit
    Left = 91
    Top = 27
    Width = 153
    Height = 33
    MaxLength = 9
    TabOrder = 2
    TextHint = '9 '#1094#1080#1092#1088
    OnChange = NumberEditChange
    OnContextPopup = NumberEditContextPopup
    OnKeyDown = NumberEditKeyDown
    OnKeyPress = NumberEditKeyPress
    OnKeyUp = NumberEditKeyUp
  end
  object AddButton: TButton
    Left = 8
    Top = 66
    Width = 89
    Height = 39
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Enabled = False
    TabOrder = 1
    OnClick = AddButtonClick
    OnKeyDown = ComponentKeyDown
  end
  object CancelButton: TButton
    Left = 155
    Top = 66
    Width = 89
    Height = 39
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 0
    OnClick = CloseButtonClick
    OnKeyDown = ComponentKeyDown
  end
end
