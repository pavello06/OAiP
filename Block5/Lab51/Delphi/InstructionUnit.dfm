object InstructionForm: TInstructionForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
  ClientHeight = 136
  ClientWidth = 578
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = InstructionFormCreate
  OnKeyDown = InstructionFormKeyDown
  TextHeight = 25
  object InstructionLabel: TLabel
    Left = 224
    Top = 48
    Width = 125
    Height = 25
    Caption = 'InstructionLabel'
    WordWrap = True
  end
end
