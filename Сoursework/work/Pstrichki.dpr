program Pstrichki;

uses
  Vcl.Forms,
  GameUnit in 'GameUnit.pas' {GameForm},
  StartUnit in 'StartUnit.pas' {StartForm},
  MenuUnit in 'MenuUnit.pas' {MenuFrame: TFrame},
  RuleUnit in 'RuleUnit.pas' {RuleForm},
  RatingUnit in 'RatingUnit.pas' {RatingForm},
  SettingsUnit in 'SettingsUnit.pas' {SettingsForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TGameForm, GameForm);
  Application.CreateForm(TStartForm, StartForm);
  Application.CreateForm(TRuleForm, RuleForm);
  Application.CreateForm(TRatingForm, RatingForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.Run;
end.
