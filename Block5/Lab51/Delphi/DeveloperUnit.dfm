object DeveloperForm: TDeveloperForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
  ClientHeight = 96
  ClientWidth = 390
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = DeveloperFormCreate
  OnKeyDown = DeveloperFormKeyDown
  TextHeight = 25
  object DeveloperLabel: TLabel
    Left = 128
    Top = 32
    Width = 122
    Height = 25
    Caption = 'DeveloperLabel'
  end
end
