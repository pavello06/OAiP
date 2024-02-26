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
    InstructionLabel.Caption := '1. Число n, для которго проверяется формула, должно быть натуральным числом в диапазоне[1; 10000].'#13#10'2. Файл должен содержать одну строку с числом n, удовлетворяющим вышеперечисленному условию.';
    InstructionLabel.Width := 700;
    InstructionLabel.Left := (ClientWidth - InstructionLabel.Width) Div 2;
end;

procedure TInstructionForm.InstructionExitButtonOnClick(Sender: TObject);
begin
    Close;
end;

end.
