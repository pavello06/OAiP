object DeveloperForm: TDeveloperForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
  ClientHeight = 152
  ClientWidth = 454
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = DeveloperFormOnCreate
  TextHeight = 20
  object DeveloperLabel: TLabel
    Left = 178
    Top = 32
    Width = 105
    Height = 20
    Caption = 'DeveloperLabel'
  end
  object DeveloperExitButton: TButton
    Left = 192
    Top = 106
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = DeveloperExitButtonOnClick
  end
end
