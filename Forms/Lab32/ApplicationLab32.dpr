program ApplicationLab32;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  Unit2 in 'Unit2.pas' {InstructionForm},
  Unit3 in 'Unit3.pas' {DeveloperForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Auric');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TInstructionForm, InstructionForm);
  Application.CreateForm(TDeveloperForm, DeveloperForm);
  Application.Run;
end.
