Unit InstructionUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

Type
    TInstructionForm = Class(TForm)
        InstructionLabel: TLabel;

        Procedure InstructionFormCreate(Sender: TObject);
        Procedure InstructionFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    InstructionForm: TInstructionForm;

Implementation

{$R *.dfm}

Procedure TInstructionForm.InstructionFormCreate(Sender: TObject);
Begin
    InstructionLabel.Width := 800;
    InstructionLabel.Caption := '1. ��� ���������� �������� � ������ ������� ������ "��������".'#13#10 +
                                '2. ��� �������� �������� ������ ������� ������ "�������".'#13#10 +
                                '3. ��� ���������� ������ ������� ������ "�����������".'#13#10 +
                                '4. ���� �������� ������ ������� � +375.';
    InstructionLabel.Left := (ClientWidth - InstructionLabel.Width) Div 2;
    InstructionLabel.Top := (ClientHeight - InstructionLabel.Height) Div 2;
End;

Procedure TInstructionForm.InstructionFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;

End.
