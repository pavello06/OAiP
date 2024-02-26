program Pstrichki;

uses
  Vcl.Forms,
  StartUnit in 'StartUnit.pas' {StartForm},
  PlayUnit in 'PlayUnit.pas' {PlayForm},
  RuleUnit in 'RuleUnit.pas' {RuleForm},
  SettingsUnit in 'SettingsUnit.pas' {SettingsForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TStartForm, StartForm);
  Application.CreateForm(TPlayForm, PlayForm);
  Application.CreateForm(TRuleForm, RuleForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.Run;
end.
