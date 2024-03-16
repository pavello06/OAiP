Unit SettingsUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MenuUnit, Vcl.ExtCtrls,
    Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList, Vcl.Buttons,
    Vcl.Imaging.jpeg, Vcl.MPlayer;

Type
    TSettingsForm = Class(TForm)
        MenuFrame: TMenuFrame;

        VolumePanel: TPanel;
        VolumeImage: TImage;
        BackPanel: TPanel;

        Procedure SettingsFormResize(Sender: TObject);

        Procedure PanelMouseEnter(Sender: TObject);
        Procedure PanelMouseLeave(Sender: TObject);
        Procedure BackPanelClick(Sender: TObject);
        procedure VolumeImageClick(Sender: TObject);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    SettingsForm: TSettingsForm;

Implementation

{$R *.dfm}

Procedure TSettingsForm.SettingsFormResize(Sender: TObject);
Begin
    With MenuFrame Do
    Begin
        MenuFrame.MenuFrameResize(MenuFrame);

        VolumePanel.Width := BASIC_VOLUME_WIDTH * ClientWidth Div BASIC_CLIENT_WIDTH;
        VolumePanel.Height := BASIC_VOLUME_HEIGHT * ClientHeight Div BASIC_CLIENT_HEIGHT;
        VolumePanel.Left := (ClientWidth - VolumePanel.Width) Div 2;
        VolumePanel.Top := TitleLabel.Top + TitleLabel.Height + BASIC_TITLE_RATING_DISTANCE * ClientHeight Div BASIC_CLIENT_HEIGHT;

        VolumeImage.Width := VolumePanel.Width * 2 Div 3;
        VolumeImage.Left := (VolumePanel.Width - VolumeImage.Width) Div 2;
        VolumeImage.Top := (VolumePanel.Height - VolumeImage.Height) Div 2;

        BackPanel.Top := VolumePanel.Top + VolumePanel.Height + BASIC_VOLUME_PANEL_DISNACE * ClientHeight Div BASIC_CLIENT_HEIGHT;
        PanelProperties(BackPanel, PanelWidth, PanelHeight, PanelFontSize, PanelLeft);
    End;
End;



Procedure TSettingsForm.VolumeImageClick(Sender: TObject);
Begin
    If MenuFrame.MediaPlayer.Mode = mpPlaying Then
    Begin
        MenuFrame.MediaPlayer.Stop;
    End
    Else
    Begin
        MenuFrame.MediaPlayer.Open;
        MenuFrame.MediaPlayer.Play;
    End;
End;



Procedure TSettingsForm.PanelMouseEnter(Sender: TObject);
Begin
    MenuFrame.PanelMoveEnter(Sender);
End;

Procedure TSettingsForm.PanelMouseLeave(Sender: TObject);
Begin
    MenuFrame.PanelMoveLeave(Sender);
End;

Procedure TSettingsForm.BackPanelClick(Sender: TObject);
Begin
    Close;
End;

End.
