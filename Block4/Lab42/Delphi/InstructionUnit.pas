Unit InstructionUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

Type
    TInstructionForm = Class(TForm)

        InstructionLabel: TLabel;

        Procedure InstructionFormCreate(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    InstructionForm: TInstructionForm;

Implementation

{$R *.dfm}

Uses MainUnit;

Procedure TInstructionForm.InstructionFormCreate(Sender: TObject);
Begin
    InstructionLabel.Width := 600;
    InstructionLabel.Caption := '1. Количество чисел должно быть натуральным и лежать в диапазоне [' + IntToStr(MIN_NUMS_AMOUNT) + '; ' + IntToStr(MAX_NUMS_AMOUNT) + '].'#13#10 +
                                '2. Числа должны быть натуральными и различными и лежать в диапазоне [' + IntToStr(MIN_NUM) + '; ' + IntToStr(MAX_NUM) + '].'#13#10 +
                                '3. Для быстрого открытия инстуркции нажмите F1 .'#13#10 +
                                '4. Файл должен иметь расширение txt и структуру:'#13#10'Количеством чисел, которое удовлетворяет первому условию.'#13#10'Числами, которые удовлетворяют второму условию.';
    InstructionLabel.Left := (ClientWidth - InstructionLabel.Width) Div 2;
    InstructionLabel.Top := (ClientHeight - InstructionLabel.Height) Div 2;
End;

End.
