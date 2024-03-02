program ApplicationLab52;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  ActionUnit in 'ActionUnit.pas' {ActionForm},
  BinarySearchTreeUnit in 'BinarySearchTreeUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TActionForm, ActionForm);
  Application.Run;
end.
