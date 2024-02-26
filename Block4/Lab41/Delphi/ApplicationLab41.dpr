program ApplicationLab41;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  InstructionUnit in 'InstructionUnit.pas' {InstructionForm},
  DeveloperUnit in 'DeveloperUnit.pas' {DeveloperForm},
  EditUnit in 'EditUnit.pas' {EditForm},
  SearchUnit in 'SearchUnit.pas' {SearchForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TInstructionForm, InstructionForm);
  Application.CreateForm(TDeveloperForm, DeveloperForm);
  Application.CreateForm(TEditForm, EditForm);
  Application.CreateForm(TSearchForm, SearchForm);
  Application.Run;
end.
