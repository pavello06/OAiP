object InstructionForm: TInstructionForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
  ClientHeight = 197
  ClientWidth = 626
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
    Left = 248
    Top = 24
    Width = 105
    Height = 20
    Caption = 'InstructionLabel'
  end
  object InstructionExitButton: TButton
    Left = 264
    Top = 136
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = InstructionExitButtonOnClick
  end
end
