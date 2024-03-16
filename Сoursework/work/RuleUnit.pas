Unit RuleUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MenuUnit, Vcl.StdCtrls, Vcl.ExtCtrls;

Type
    TRuleForm = Class(TForm)
        MenuFrame: TMenuFrame;

        BackPanel: TPanel;

        Procedure RuleFormCreate(Sender: TObject);
        Procedure RuleFormResize(Sender: TObject);
        Procedure RuleFormDestroy(Sender: TObject);

        Procedure PanelMouseEnter(Sender: TObject);
        Procedure PanelMouseLeave(Sender: TObject);
        Procedure BackPanelClick(Sender: TObject);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    RuleForm: TRuleForm;

Implementation

{$R *.dfm}

Var
    RuleLabel: TLabel;

Procedure TRuleForm.RuleFormCreate(Sender: TObject);
Begin
    RuleLabel := TLabel.Create(MenuFrame);
    RuleLabel.Parent := MenuFrame;
    RuleLabel.WordWrap := True;
    RuleLabel.Alignment := taCenter;
    RuleLabel.Font.Color := clInfoBk;
    RuleLabel.Caption := '� ������ ���� ����� ��������������� ������ (�� 8 ����) ������������� �� ��������� ����� � ������� ����� �������� ���� �����, ����� ���� ������ �� ������� �������� ������� ������ ����� �����, ��� ���� �������� ��������� ���� � ����.' + ' ���� ����� �������� �����/����� ��������� � ��� ���� ���� ������� ����� ������� �� �����, �� �� ������ ��� ���� ����. �����, �������� ��� ����� ����� (� ��� ���� �� ����� �������� ���� �� ���� ��� �����) ���������.';
End;

Procedure TRuleForm.RuleFormResize(Sender: TObject);
Begin
    With MenuFrame Do
    Begin
        MenuFrame.MenuFrameResize(MenuFrame);

        RuleLabel.Width := BASIC_RULE_WIDTH * ClientWidth Div BASIC_CLIENT_WIDTH;
        RuleLabel.Font.Size := BASIC_RULE_FONT_SIZE * ClientHeight Div BASIC_CLIENT_HEIGHT;
        RuleLabel.Left := (ClientWidth - RuleLabel.Width) Div 2;
        RuleLabel.Top := TitleLabel.Top + TitleLabel.Height + BASIC_TITLE_RULE_DISTANCE * ClientHeight Div BASIC_CLIENT_HEIGHT;

        BackPanel.Top := RuleLabel.Top + RuleLabel.Height + BASIC_RULE_PANEL_DISNACE * ClientHeight Div BASIC_CLIENT_HEIGHT;
        PanelProperties(BackPanel, PanelWidth, PanelHeight, PanelFontSize, PanelLeft);
    End;
End;

Procedure TRuleForm.RuleFormDestroy(Sender: TObject);
Begin
    RuleLabel.Free;
End;



Procedure TRuleForm.PanelMouseEnter(Sender: TObject);
Begin
    MenuFrame.PanelMoveEnter(Sender);
End;

Procedure TRuleForm.PanelMouseLeave(Sender: TObject);
Begin
    MenuFrame.PanelMoveLeave(Sender);
End;

Procedure TRuleForm.BackPanelClick(Sender: TObject);
Begin
    Close;
End;

End.
