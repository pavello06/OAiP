Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Menus,
    Vcl.ExtDlgs,
    Vcl.ExtCtrls, Vcl.Imaging.pngimage, ActionUnit, BinarySearchTreeUnit;

Type
    TMainForm = Class(TForm)
        TabsMainMenu: TMainMenu;
        FileMenuItem: TMenuItem;
        ExitMenuItem: TMenuItem;
        InstructionMenuItem: TMenuItem;
        DeveloperMenuItem: TMenuItem;

        InsertImage: TImage;
        RemoveImage: TImage;

        ScrollBox: TScrollBox;
        PaintBox: TPaintBox;
        CalculateImage: TImage;

        Function MainFormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
        Procedure MainFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);

        Procedure InstructionMenuItemClick(Sender: TObject);
        Procedure DeveloperMenuItemClick(Sender: TObject);

        Procedure InsertImageClick(Sender: TObject);
        Procedure RemoveImageClick(Sender: TObject);
        Procedure CalculateImageClick(Sender: TObject);

        Procedure PaintBoxPaint(Sender: TObject);

        Procedure ExitMenuItemClick(Sender: TObject);
        Procedure MainFormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure MainFormDestroy(Sender: TObject);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Const
    MIN_NUM = 1;
    MAX_NUM = 999;

Var
    MainForm: TMainForm;
    BinarySearchTree: TBinarySearchTree;
    ActionIR: Char = 'I';

Implementation

{$R *.dfm}

Function TMainForm.MainFormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    InstructionMenuItemClick(InstructionMenuItem);
    MainFormHelp := False;
End;

Procedure TMainForm.MainFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_INSERT Then
        InsertImageClick(InsertImage)
    Else If Key = VK_DELETE Then
        RemoveImageClick(RemoveImage);    
End;



Procedure CreateModalForm(CaptionText, LabelText: String; ModalWidth, ModalHeight: Integer);
Var
    ModalForm: TForm;
    ModalLabel: TLAbel;
Begin
    ModalForm := TForm.Create(Nil);
    Try
        ModalForm.Caption := CaptionText;
        ModalForm.Width := ModalWidth;
        ModalForm.Height := ModalHeight;
        ModalForm.BorderIcons := [BiSystemMenu];
        ModalForm.BorderStyle := BsSingle;
        ModalForm.Position := PoScreenCenter;
        ModalForm.Icon := MainForm.Icon;
        ModalForm.Font.Size := 13;
        ModalLabel := TLAbel.Create(ModalForm);
        ModalLabel.Parent := ModalForm;
        ModalLabel.Caption := LabelText;
        ModalLabel.Left := (ModalForm.ClientWidth - ModalLabel.Width) Div 2;
        ModalLabel.Top := (ModalForm.ClientHeight - ModalLabel.Height) Div 2;
        ModalForm.ShowModal;
    Finally
        ModalForm.Free;
    End;
End;

Procedure TMainForm.InstructionMenuItemClick(Sender: TObject);
Begin
    CreateModalForm('����������', '1. ������� 1 ������ ��� Ins ��� ����������.'#13#10'2. ������� 2 ������ ��� Del ��� ��������.'#13#10'3. ��� �������� �������, �� ������� ������� ������'#13#10' ������ � ������ �������, ������� 3 ������.'#13#10'4. ������������ ������� ������ 7.'#13#10'5. �������� �������� ���� [1..99].', 600, 250);
End;

Procedure TMainForm.DeveloperMenuItemClick(Sender: TObject);
Begin
    CreateModalForm('� ������������',
        '������: 351005'#13#10'�����������: ������ ����� �������������'#13#10'���������: @pavello06',
        500, 150);
End;



Procedure TMainForm.InsertImageClick(Sender: TObject);
Begin
    ActionIR := 'I';
    ActionForm := TActionForm.Create(Self);
    ActionForm.Icon := MainForm.Icon;
    ActionForm.Caption := '������� ����';
    ActionForm.ActionButton.Caption := '��������';
    ActionForm.ShowModal;
    ActionForm.Free;

End;

Procedure TMainForm.RemoveImageClick(Sender: TObject);
Begin
    ActionIR := 'R';
    ActionForm := TActionForm.Create(Self);
    ActionForm.Icon := MainForm.Icon;
    ActionForm.Caption := '�������� ����';
    ActionForm.ActionButton.Caption := '�������';
    ActionForm.ShowModal;
    ActionForm.Free;
End;

Procedure TMainForm.CalculateImageClick(Sender: TObject);
Var
    I: Integer;
    Levels: String;
Begin
    Levels := '������: ';
    For I := 1 To High(SingleParentLevels) Do
        SingleParentLevels[I] := 0;
    FindSingleParentLevels(BinarySearchTree, 1);
    For I := 1 To High(SingleParentLevels) Do
        If SingleParentLevels[I] = 1 Then
            Levels := Levels + IntToStr(I) + '; ';
    If Levels = '������: ' Then
        Levels := Levels + '�� ���(';
    CreateModalForm('������', Levels, 400, 100);
End;



Procedure TMainForm.PaintBoxPaint(Sender: TObject);
Begin
    Draw(BinarySearchTree, PaintBox);
End;



Procedure TMainForm.ExitMenuItemClick(Sender: TObject);
Begin
    Close;
End;

Procedure TMainForm.MainFormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Var
    Confirmation: Integer;
Begin
    Confirmation := Application.MessageBox('�� ������������� ������ �����?',
        '�����', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
    CanClose := Confirmation = IDYES;
End;

Procedure TMainForm.MainFormDestroy(Sender: TObject);
Begin
    Clear(BinarySearchTree);
End;

End.
