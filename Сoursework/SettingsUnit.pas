unit SettingsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.MPlayer;

type
  TSettingsForm = class(TForm)
    BackgroundImage: TImage;
    TitleLabel: TLabel;
    BackgroundSongMediaPlayer: TMediaPlayer;
    BackButton: TButton;

    procedure SettingsFormResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);

    procedure ButtonMouseEnter(Sender: TObject);
    procedure ButtonMouseLeave(Sender: TObject);

    procedure BackButtonClick(Sender: TObject);
    procedure BackgroundSongMediaPLayerClick(Sender: TObject;
      Button: TMPBtnType; var DoDefault: Boolean);
    procedure BackgroundSongMediaPLayerNotify(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SettingsForm: TSettingsForm;

implementation

{$R *.dfm}


Procedure TSettingsForm.SettingsFormResize(Sender: TObject; Var NewWidth, NewHeight: Integer; Var Resize: Boolean);
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

    BackgroundSongMediaPlayer.Width := Trunc(800 * TransformCoof);
    BackgroundSongMediaPlayer.Height := Trunc(300 * TransformCoof);
    BackgroundSongMediaPlayer.Left := (ClientWidth - BackgroundSongMediaPlayer.Width) Div 2;
    BackgroundSongMediaPlayer.Top := TitleLabel.Top + TitleLabel.Height + Trunc(55 * TransformCoof);

    BackButton.Width := Trunc(600 * TransformCoof);
    BackButton.Height := Trunc(90 * TransformCoof);
    BackButton.Font.Size := Trunc(35 * TransformCoof);
    BackButton.Left := (ClientWidth - BackButton.Width) Div 2;
    BackButton.Top := BackgroundSongMediaPlayer.Top + BackgroundSongMediaPlayer.Height + Trunc(55 * TransformCoof);
End;


procedure TSettingsForm.BackgroundSongMediaPLayerClick(Sender: TObject; Button: TMPBtnType; var DoDefault: Boolean);
begin
    BackgroundSongMediaPlayer.Open;
    BackgroundSongMediaPlayer.Play;
end;

procedure TSettingsForm.BackgroundSongMediaPLayerNotify(Sender: TObject);
begin
    if BackgroundSongMediaPlayer.NotifyValue = nvSuccessful then
  begin
    BackgroundSongMediaPlayer.Stop;
    BackgroundSongMediaPlayer.Rewind;
    BackgroundSongMediaPlayer.Play;
  end;
end;

procedure TSettingsForm.ButtonMouseEnter(Sender: TObject);
Var
    Button: TButton;
begin
    Button := TButton(Sender);
    Button.Font.Size := Button.Font.Size + 1;
    Button.Font.Style := [fsBold, fsItalic, fsUnderline];
end;

procedure TSettingsForm.ButtonMouseLeave(Sender: TObject);
Var
    Button: TButton;
begin
    Button := TButton(Sender);
    Button.Font.Size := Button.Font.Size - 1;
    Button.Font.Style := [fsBold, fsItalic];
end;


procedure TSettingsForm.BackButtonClick(Sender: TObject);
begin
    Close;
end;

end.
