Unit Unit2;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

Type
    TInstructionForm = Class(TForm)
        InstructionLabel1: TLabel;
        InstructionLabel2: TLabel;
    InstructionCloseButton: TButton;
    InstructionLabel3: TLabel;
    procedure InstructionCloseButtonOnClick(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
  InstructionForm: TInstructionForm;

Implementation

{$R *.dfm}

procedure TInstructionForm.InstructionCloseButtonOnClick(Sender: TObject);
begin
    Close;
end;

End.
