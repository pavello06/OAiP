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
    InstructionLabel.Caption := '1. ���������� ����� ������ ���� ����������� � ������ � ��������� [' + IntToStr(MIN_NUMS_AMOUNT) + '; ' + IntToStr(MAX_NUMS_AMOUNT) + '].'#13#10 +
                                '2. ����� ������ ���� ������������ � ���������� � ������ � ��������� [' + IntToStr(MIN_NUM) + '; ' + IntToStr(MAX_NUM) + '].'#13#10 +
                                '3. ��� �������� �������� ���������� ������� F1 .'#13#10 +
                                '4. ���� ������ ����� ���������� txt � ���������:'#13#10'����������� �����, ������� ������������� ������� �������.'#13#10'�������, ������� ������������� ������� �������.';
    InstructionLabel.Left := (ClientWidth - InstructionLabel.Width) Div 2;
    InstructionLabel.Top := (ClientHeight - InstructionLabel.Height) Div 2;
End;

End.
