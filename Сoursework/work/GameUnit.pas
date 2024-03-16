Unit GameUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
    Vcl.Imaging.jpeg, Vcl.StdCtrls, StartUnit;

Type
    TGameForm = Class(TForm)
        BackgroundImage: TImage;
        GameFieldImage: TImage;
        SettingsImage: TImage;

        Procedure GameFormCreate(Sender: TObject);
        Procedure GameFormCanResize(Sender: TObject; Var NewWidth, NewHeight: Integer; Var Resize: Boolean);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    GameForm: TGameForm;

Implementation

{$R *.dfm}

Procedure TGameForm.GameFormCreate(Sender: TObject);
Begin
    StartForm := TStartForm.Create(Self);
    StartForm.Icon := StartForm.Icon;
    StartForm.ShowModal;
    StartForm.Free;
    GameFieldImage.Width := 800;
    GameFieldImage.Height := 800;
End;

Procedure TGameForm.GameFormCanResize(Sender: TObject; Var NewWidth, NewHeight: Integer; Var Resize: Boolean);
begin
    SettingsImage.Left := 20;
    SettingsImage.Top := 20;

    GameFieldImage.Left := (ClientWidth - GameFieldImage.Width) Div 2;
    GameFieldImage.Top := (ClientHeight - GameFieldImage.Height) Div 2;
end;

End.
