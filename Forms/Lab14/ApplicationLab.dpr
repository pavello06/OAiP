program ApplicationLab;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Lab},
  Vcl.Themes,
  Vcl.Styles,
  Unit2 in 'Unit2.pas' {InstructionForm},
  Unit3 in 'Unit3.pas' {DeveloperForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Dark');
  Application.CreateForm(TLab, Lab);
  Application.CreateForm(TInstructionForm, InstructionForm);
  Application.CreateForm(TDeveloperForm, DeveloperForm);
  Application.Run;
end.
