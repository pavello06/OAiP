program ApplicationLab62;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  FrontEndUnit in 'FrontEndUnit.pas',
  BackEndUnit in 'BackEndUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
