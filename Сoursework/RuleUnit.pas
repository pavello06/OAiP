unit RuleUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TRuleForm = class(TForm)
    BackgroundImage: TImage;
    TitleLabel: TLabel;
    RuleLabel: TLabel;
    BackButton: TButton;

    procedure RuleFormCreate(Sender: TObject);
    procedure RuleFormResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);

    procedure ButtonMouseEnter(Sender: TObject);
    procedure ButtonMouseLeave(Sender: TObject);

    procedure BackButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RuleForm: TRuleForm;

implementation

{$R *.dfm}

procedure TRuleForm.RuleFormCreate(Sender: TObject);
begin
    RuleLabel.Caption := 'В начале игры шашки противоположных цветов (по 8 штук) расставляются на шахматной доске в крайних рядах напротив друг друга, после чего игроки по очереди пытаются щелчком выбить чужие шашки, при этом стараясь оставлять свои в игре.' + ' Если игрок выбивает шашку/шашки соперника и при этом своя ударная шашка остаётся на доске, то он делает ещё один удар. Игрок, выбивший все чужие шашки (и при этом на доске осталась хотя бы одна его шашка) побеждает.';
end;

Procedure TRuleForm.RuleFormResize(Sender: TObject; Var NewWidth, NewHeight: Integer; Var Resize: Boolean);
Var
    MaxClientWidth, MaxClientHeight, MinClientWidth, MinClientHeight: Integer;
    TransformCoof: Real;
Begin
    MaxClientWidth := Screen.WorkAreaRect.Width;
    MaxClientHeight := Screen.WorkAreaRect.Height;
    MinClientWidth := MaxClientWidth Div 2;
    MinClientHeight := MaxClientHeight Div 2;

    If NewWidth < MinClientWidth Then
        NewWidth := MinClientWidth;
    If NewHeight < MinClientHeight Then
        NewHeight := MinClientHeight;

    If NewWidth = Width Then
        NewWidth := NewHeight * MaxClientWidth Div MaxClientHeight
    Else
        NewHeight := NewWidth * MaxClientHeight Div MaxClientWidth;

    TransformCoof := ClientWidth / MaxClientWidth;

    TitleLabel.Font.Size := Trunc(100 * TransformCoof);
    TitleLabel.Left := (ClientWidth - TitleLabel.Width) Div 2;
    TitleLabel.Top := Trunc(55 * TransformCoof);

    RuleLabel.Width := Trunc(1250 * TransformCoof);
    RuleLabel.Font.Size := Trunc(25 * TransformCoof);
    RuleLabel.Left := (ClientWidth - RuleLabel.Width) Div 2;
    RuleLabel.Top := TitleLabel.Top + TitleLabel.Height + Trunc(55 * TransformCoof);

    BackButton.Width := Trunc(600 * TransformCoof);
    BackButton.Height := Trunc(90 * TransformCoof);
    BackButton.Font.Size := Trunc(35 * TransformCoof);
    BackButton.Left := (ClientWidth - BackButton.Width) Div 2;
    BackButton.Top := RuleLabel.Top + RuleLabel.Height + Trunc(55 * TransformCoof);
End;


procedure TRuleForm.ButtonMouseEnter(Sender: TObject);
Var
    Button: TButton;
begin
    Button := TButton(Sender);
    Button.Font.Size := Button.Font.Size + 1;
    Button.Font.Style := [fsBold, fsItalic, fsUnderline];
end;

procedure TRuleForm.ButtonMouseLeave(Sender: TObject);
Var
    Button: TButton;
begin
    Button := TButton(Sender);
    Button.Font.Size := Button.Font.Size - 1;
    Button.Font.Style := [fsBold, fsItalic];
end;


procedure TRuleForm.BackButtonClick(Sender: TObject);
begin
    Close;
end;

end.
