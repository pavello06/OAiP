object InstructionForm: TInstructionForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
  ClientHeight = 145
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = InstructionFormOnCreate
  TextHeight = 20
  object InstructionLabel: TLabel
    Left = 192
    Top = 24
    Width = 82
    Height = 20
    Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
  end
  object InstructionExitButton: TButton
    Left = 192
    Top = 104
    Width = 82
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = InstructionExitButtonOnClick
  end
end
