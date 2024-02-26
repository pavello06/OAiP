unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TInstructionForm = class(TForm)
    InstructionLabel: TLabel;
    InstructionExitButton: TButton;
    procedure InstructionFormOnCreate(Sender: TObject);
    procedure InstructionExitButtonOnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InstructionForm: TInstructionForm;

implementation

{$R *.dfm}

procedure TInstructionForm.InstructionFormOnCreate(Sender: TObject);
begin
    InstructionLabel.Caption := '1. �������� a, b, c, x0, xn, h ������������.'#13#10'2. �������� a, b, c, x0, xn ����������� ���������[-1000; 1000].'#13#10'3. �������� xn ������ ���� ������ x0.'#13#10'4. �������� h  ������������� � ���������(0; 1000].'#13#10'5. ���� ������ ����� 6 ����� � ����� ����������.';
    InstructionLabel.Width := 650;
    InstructionLabel.Left := (ClientWidth - InstructionLabel.Width) Div 2;
end;

procedure TInstructionForm.InstructionExitButtonOnClick(Sender: TObject);
begin
    Close;
end;

end.
