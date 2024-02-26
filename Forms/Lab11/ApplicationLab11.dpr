program ApplicationLab11;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Lab11},
  Unit2 in 'Unit2.pas' {InstructionForm},
  Unit3 in 'Unit3.pas' {DeveloperForm},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Dark');
  Application.CreateForm(TLab11, Lab11);
  Application.CreateForm(TInstructionForm, InstructionForm);
  Application.CreateForm(TDeveloperForm, DeveloperForm);
  Application.Run;
end.
