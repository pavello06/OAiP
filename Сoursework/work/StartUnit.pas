Unit StartUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
    Vcl.ExtCtrls, Vcl.ComCtrls, MenuUnit, RuleUnit, RatingUnit, SettingsUnit;

Type
    TStartForm = Class(TForm)
    MenuFrame: TMenuFrame;
    PlayPanel: TPanel;
    RatingPanel: TPanel;
    RulePanel: TPanel;
    SettingsPanel: TPanel;
    ExitPanel: TPanel;

        Procedure StartFormResize(Sender: TObject);

        Procedure PanelMouseEnter(Sender: TObject);
        Procedure PanelMouseLeave(Sender: TObject);

        Procedure RulePanelClick(Sender: TObject);
        Procedure RatingPanelClick(Sender: TObject);
    procedure SettingsPanelClick(Sender: TObject);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    StartForm: TStartForm;

Implementation

{$R *.dfm}

Procedure TStartForm.StartFormResize(Sender: TObject);
Var
    PanelDistance: Integer;
Begin
    With MenuFrame Do
    Begin
        MenuFrame.MenuFrameResize(MenuFrame);

        PanelDistance := BASIC_PANELS_DISTANCE * ClientHeight Div BASIC_CLIENT_HEIGHT;

        PlayPanel.Top := TitleLabel.Top + TitleLabel.Height + BASIC_TITLE_PANEL_DISTANCE * ClientHeight Div BASIC_CLIENT_HEIGHT;
        PanelProperties(PlayPanel, PanelWidth, PanelHeight, PanelFontSize, PanelLeft);

        RulePanel.Top := PlayPanel.Top + PlayPanel.Height + PanelDistance;
        PanelProperties(RulePanel, PanelWidth, PanelHeight, PanelFontSize, PanelLeft);

        RatingPanel.Top := RulePanel.Top + RulePanel.Height + PanelDistance;
        PanelProperties(RatingPanel, PanelWidth, PanelHeight, PanelFontSize, PanelLeft);

        SettingsPanel.Top := RatingPanel.Top + RatingPanel.Height + PanelDistance;
        PanelProperties(SettingsPanel, PanelWidth, PanelHeight, PanelFontSize, PanelLeft);

        ExitPanel.Top := SettingsPanel.Top + SettingsPanel.Height + PanelDistance;
        PanelProperties(ExitPanel, PanelWidth, PanelHeight, PanelFontSize, PanelLeft);
    End;
End;



Procedure TStartForm.PanelMouseEnter(Sender: TObject);
Begin
    MenuFrame.PanelMoveEnter(Sender);
End;

Procedure TStartForm.PanelMouseLeave(Sender: TObject);
Begin
    MenuFrame.PanelMoveLeave(Sender);
End;



Procedure TStartForm.RulePanelClick(Sender: TObject);
Begin
    RuleForm := TRuleForm.Create(Self);
    RuleForm.Icon := RuleForm.Icon;
    RuleForm.ShowModal;
    RuleForm.Free;
End;

Procedure TStartForm.RatingPanelClick(Sender: TObject);
Begin
    RatingForm := TRatingForm.Create(Self);
    RatingForm.Icon := RatingForm.Icon;
    RatingForm.ShowModal;
    RatingForm.Free;
End;

Procedure TStartForm.SettingsPanelClick(Sender: TObject);
Begin
    SettingsForm := TSettingsForm.Create(Self);
    SettingsForm.Icon := SettingsForm.Icon;
    SettingsForm.ShowModal;
    SettingsForm.Free;
End;

End.
