Unit MenuUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes,
    Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg,
    Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.MPlayer;

Const
    BASIC_CLIENT_WIDTH = 1920;
    BASIC_CLIENT_HEIGHT = 1051;

    BASIC_TITLE_FONT_SIZE = 100;
    BASIC_TITLE_TOP = 55;

    BASIC_TITLE_PANEL_DISTANCE = 100;
    BASIC_TITLE_RULE_DISTANCE = 100;
    BASIC_TITLE_RATING_DISTANCE = 100;

    BASIC_PANEL_WIDTH = 600;
    BASIC_PANEL_HEIGHT = 90;
    BASIC_PANEL_FONT_SIZE = 35;
    BASIC_PANELS_DISTANCE = 30;

    BASIC_RULE_WIDTH = 1300;
    BASIC_RULE_FONT_SIZE = 25;
    BASIC_RULE_PANEL_DISNACE = 40;

    BASIC_RATING_WIDTH = 600;
    BASIC_RATING_HEIGHT = 400;
    BASIC_RATING_FONT_SIZE = 20;
    BASIC_RATING_PANEL_DISNACE = 40;

    BASIC_VOLUME_WIDTH = 300;
    BASIC_VOLUME_HEIGHT = 300;
    BASIC_VOLUME_PANEL_DISNACE = 70;

Type
    TMenuFrame = Class(TFrame)
        BackGroundImage: TImage;
        TitleLabel: TLabel;
        MediaPlayer: TMediaPlayer;

        Procedure MenuFrameResize(Sender: TObject);

        Procedure MediaPlayerNotify(Sender: TObject);

        Procedure PanelProperties(Panel: TPanel; PanelWidth, PanelHeight, PanelFontSize, PanelLeft: Integer);
        Procedure PanelMoveEnter(Sender: TObject);
        Procedure PanelMoveLeave(Sender: TObject);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    PanelWidth, PanelHeight, PanelFontSize, PanelLeft: Integer;

Implementation

{$R *.dfm}

Procedure TMenuFrame.MenuFrameResize(Sender: TObject);
Begin
    TitleLabel.Font.Size := BASIC_TITLE_FONT_SIZE * ClientHeight Div BASIC_CLIENT_HEIGHT;
    TitleLabel.Left := (ClientWidth - TitleLabel.Width) Div 2;
    TitleLabel.Top := BASIC_TITLE_TOP * ClientHeight Div BASIC_CLIENT_HEIGHT;

    PanelWidth := BASIC_Panel_WIDTH * ClientWidth Div BASIC_CLIENT_WIDTH;
    PanelHeight := BASIC_Panel_HEIGHT * ClientHeight Div BASIC_CLIENT_HEIGHT;
    PanelFontSize := BASIC_Panel_FONT_SIZE * ClientHeight Div BASIC_CLIENT_HEIGHT;
    PanelLeft := (ClientWidth - PanelWidth) Div 2;
End;


Procedure TMenuFrame.MediaPlayerNotify(Sender: TObject);
Begin
    If MediaPlayer.NotifyValue = nvSuccessful Then
    Begin
        MediaPlayer.Stop;
        MediaPlayer.Rewind;
        MediaPlayer.Play;
    End;
End;



Procedure TMenuFrame.PanelProperties(Panel: TPanel; PanelWidth, PanelHeight, PanelFontSize, PanelLeft: Integer);
Begin
    With Panel Do
    Begin
        Width := PanelWidth;
        Height := PanelHeight;
        Font.Size := PanelFontSize;
        Left := PanelLeft;
    End;
End;

Procedure TMenuFrame.PanelMoveEnter(Sender: TObject);
Begin
    TPanel(Sender).Font.Style := [fsBold, fsItalic, fsUnderLine];
End;

Procedure TMenuFrame.PanelMoveLeave(Sender: TObject);
Begin
    TPanel(Sender).Font.Style := [fsBold, fsItalic];
End;

End.
