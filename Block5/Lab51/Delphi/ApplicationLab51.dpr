program ApplicationLab51;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  InstructionUnit in 'InstructionUnit.pas' {InstructionForm},
  DeveloperUnit in 'DeveloperUnit.pas' {DeveloperForm},
  AddUnit in 'AddUnit.pas' {AddForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TInstructionForm, InstructionForm);
  Application.CreateForm(TDeveloperForm, DeveloperForm);
  Application.CreateForm(TAddForm, AddForm);
  Application.Run;
end.
