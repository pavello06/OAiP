Unit RatingUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MenuUnit, Vcl.Grids, Vcl.ExtCtrls;

Type
    TRatingForm = Class(TForm)
        MenuFrame: TMenuFrame;

        RatingStringGrid: TStringGrid;
        BackPanel: TPanel;

        Procedure RatingFormResize(Sender: TObject);

        Procedure PanelMouseEnter(Sender: TObject);
        Procedure PanelMouseLeave(Sender: TObject);
        Procedure BackPanelClick(Sender: TObject);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    RatingForm: TRatingForm;

Implementation

{$R *.dfm}

Procedure TRatingForm.RatingFormResize(Sender: TObject);
Begin
    With MenuFrame Do
    Begin
        MenuFrame.MenuFrameResize(MenuFrame);

        RatingStringGrid.Width := BASIC_RATING_WIDTH * ClientWidth Div BASIC_CLIENT_WIDTH;
        RatingStringGrid.Height := BASIC_RATING_HEIGHT * ClientHeight Div BASIC_CLIENT_HEIGHT;
        RatingStringGrid.Font.Size := BASIC_RATING_FONT_SIZE * ClientHeight Div BASIC_CLIENT_HEIGHT;
        RatingStringGrid.Left := (ClientWidth - RatingStringGrid.Width) Div 2;
        RatingStringGrid.Top := TitleLabel.Top + TitleLabel.Height + BASIC_TITLE_RATING_DISTANCE * ClientHeight Div BASIC_CLIENT_HEIGHT;

        BackPanel.Top := RatingStringGrid.Top + RatingStringGrid.Height + BASIC_RATING_PANEL_DISNACE * ClientHeight Div BASIC_CLIENT_HEIGHT;
        PanelProperties(BackPanel, PanelWidth, PanelHeight, PanelFontSize, PanelLeft);
    End;
End;



Procedure TRatingForm.PanelMouseEnter(Sender: TObject);
Begin
    MenuFrame.PanelMoveEnter(Sender);
End;

Procedure TRatingForm.PanelMouseLeave(Sender: TObject);
Begin
    MenuFrame.PanelMoveLeave(Sender);
End;

Procedure TRatingForm.BackPanelClick(Sender: TObject);
Begin
    Close;
End;

End.
