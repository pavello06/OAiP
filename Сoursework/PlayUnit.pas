unit PlayUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TPlayForm = class(TForm)
    BackgroundImage: TImage;
    TitleLabel: TLabel;
    Player1Label: TLabel;
    Player1Edit: TEdit;
    Player2Label: TLabel;
    Player2Edit: TEdit;
    ContinueButton: TButton;
    BackButton: TButton;

    procedure PlayFormResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);

    procedure PlayerEditChange(Sender: TObject);

    procedure ButtonMouseEnter(Sender: TObject);
    procedure ButtonMouseLeave(Sender: TObject);

    procedure BackButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PlayForm: TPlayForm;

implementation

{$R *.dfm}

Procedure TPlayForm.PlayFormResize(Sender: TObject; Var NewWidth, NewHeight: Integer; Var Resize: Boolean);
Var
    MaxClientWidth, MaxClientHeight, MinClientWidth, MinClientHeight: Integer;
    TransformCoof: Real;
    FontSizeLabel: Integer;
    WidthEdit, HeightEdit, FontSizeEdit, LeftEdit: Integer;
    WidthButton, HeightButton, FontSizeButton, LeftButton: Integer;
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

    FontSizeLabel := Trunc(30 * TransformCoof);

    WidthEdit := Trunc(600 * TransformCoof);
    HeightEdit := Trunc(60 * TransformCoof);
    FontSizeEdit := Trunc(25 * TransformCoof);
    LeftEdit := (ClientWidth - WidthEdit) Div 2;

    Player1Label.Font.Size := FontSizeLabel;
    Player1Label.Left := LeftEdit;
    Player1Label.Top := TitleLabel.Top + TitleLabel.Height + Trunc(55 * TransformCoof);

    Player1Edit.Width := WidthEdit;
    Player1Edit.Height := HeightEdit;
    Player1Edit.Font.Size := FontSizeEdit;
    Player1Edit.Left := LeftEdit;
    Player1Edit.Top := Player1Label.Top + Player1Label.Height + Trunc(20 * TransformCoof);

    Player2Label.Font.Size := FontSizeLabel;
    Player2Label.Left := LeftEdit;
    Player2Label.Top := Player1Edit.Top + Player1Edit.Height + Trunc(20 * TransformCoof);

    Player2Edit.Width := WidthEdit;
    Player2Edit.Height := HeightEdit;
    Player2Edit.Font.Size := FontSizeEdit;
    Player2Edit.Left := LeftEdit;
    Player2Edit.Top := Player2Label.Top + Player2Label.Height + Trunc(20 * TransformCoof);

    WidthButton := Trunc(600 * TransformCoof);
    HeightButton := Trunc(90 * TransformCoof);
    FontSizeButton := Trunc(35 * TransformCoof);
    LeftButton := (ClientWidth - WidthButton) Div 2;

    ContinueButton.Width := WidthButton;
    ContinueButton.Height := HeightButton;
    ContinueButton.Font.Size := FontSizeButton;
    ContinueButton.Left := LeftButton;
    ContinueButton.Top := Player2Edit.Top + Player2Edit.Height + Trunc(55 * TransformCoof);

    BackButton.Width := WidthButton;
    BackButton.Height := HeightButton;
    BackButton.Font.Size := FontSizeButton;
    BackButton.Left := LeftButton;
    BackButton.Top := ContinueButton.Top + ContinueButton.Height + Trunc(30 * TransformCoof);
End;


procedure TPlayForm.PlayerEditChange(Sender: TObject);
begin
    If (Player1Edit.Text <> '') And (Player2Edit.Text <> '') Then
        ContinueButton.Enabled := True
    Else
        ContinueButton.Enabled := False;
end;


procedure TPlayForm.ButtonMouseEnter(Sender: TObject);
Var
    Button: TButton;
begin
    Button := TButton(Sender);
    Button.Font.Size := Button.Font.Size + 1;
    Button.Font.Style := [fsBold, fsItalic, fsUnderline];
end;

procedure TPlayForm.ButtonMouseLeave(Sender: TObject);
Var
    Button: TButton;
begin
    Button := TButton(Sender);
    Button.Font.Size := Button.Font.Size - 1;
    Button.Font.Style := [fsBold, fsItalic];
end;


procedure TPlayForm.BackButtonClick(Sender: TObject);
begin
    Close;
end;

end.
