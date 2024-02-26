Unit AddUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Grids,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Clipbrd;

Type
    TAddForm = Class(TForm)
    NumberLabel: TLabel;
    NumberEdit: TEdit;
        AddButton: TButton;
        CancelButton: TButton;

        Procedure AddFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);

        Procedure ComponentKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);

        Procedure NumberEditChange(Sender: TObject);
        Procedure NumberEditContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure NumberEditKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure NumberEditKeyPress(Sender: TObject; Var Key: Char);
        Procedure NumberEditKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);

        Procedure AddButtonClick(Sender: TObject);
        Procedure CloseButtonClick(Sender: TObject);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Const
    ENTER = #13;
    BACKSPACE = #8;
    NONE = #0;
    DIGITS = ['0'..'9'];
    ALPHABET = ['A'..'Z', 'a'..'z'];
    NUMBER_LENGTH = 13;

Type
    TLimitedString = String[NUMBER_LENGTH];

Var
    AddForm: TAddForm;
    CtrlPressed: Boolean = False;

Implementation

{$R *.dfm}

Uses MainUnit;

Procedure Add(Data: TLimitedString); Stdcall; External 'LinkedList.dll';

Procedure WriteLinkedList(StringGrid: TStringGrid); Stdcall; External 'LinkedList.dll';



Procedure TAddForm.AddFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;



Procedure TAddForm.ComponentKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_UP Then
        SelectNext(TWinControl(Sender), False, True)
    Else If Key = VK_DOWN Then
        SelectNext(TWinControl(Sender), True, True)
    Else If (Key = Ord(ENTER)) And AddButton.Enabled Then
        AddButtonClick(AddButton);
End;



Procedure TAddForm.NumberEditChange(Sender: TObject);
Begin
    AddButton.Enabled := Length(NumberEdit.Text) = NumberEdit.MaxLength;
End;

Function IsPossiblePaste(SelStart, SelLength: Integer; Text: String) : Boolean;
Var
    Num: Integer;
Begin
    IsPossiblePaste := Clipboard.HasFormat(CF_TEXT) And (Length(ClipBoard.AsText) <> 0) And
                       TryStrToInt(Copy(Text, 1, SelStart) + ClipBoard.AsText + Copy(Text, SelStart + SelLength + 1), Num) And
                       (ClipBoard.AsText[1] <> '-');
End;

Procedure TAddForm.NumberEditContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Begin
     Handled := Not IsPossiblePaste(NumberEdit.SelStart, NumberEdit.SelLength, NumberEdit.Text);
End;

Procedure TAddForm.NumberEditKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    ComponentKeyDown(NumberEdit, Key, Shift);
    If (Shift = [ssCtrl]) And (UpCase(Chr(Key)) = 'V') Or (Shift = [ssShift]) And (Key = VK_INSERT) Then
    Begin
        If Not IsPossiblePaste(NumberEdit.SelStart, NumberEdit.SelLength, NumberEdit.Text) Then
            Key := Ord(NONE);
    End;
    If (Shift = [ssCtrl]) And CharInSet(Chr(Key), ALPHABET) Then
        CtrlPressed := True;
End;

Procedure TAddForm.NumberEditKeyPress(Sender: TObject; Var Key: Char);
Begin
    If Not (CtrlPressed Or CharInSet(Key, DIGITS) Or (Key = BACKSPACE)) Then
        Key := NONE;
End;

Procedure TAddForm.NumberEditKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    CtrlPressed := False;
End;



Procedure TAddForm.AddButtonClick(Sender: TObject);
Begin
    Add(TLimitedString('+375' + NumberEdit.Text));
    MainForm.NumberStringGrid.RowCount := MainForm.NumberStringGrid.RowCount + 1;
    WriteLinkedList(MainForm.NumberStringGrid);

    IsEdited := True;
    Close;
End;

Procedure TAddForm.CloseButtonClick(Sender: TObject);
Begin
    Close;
End;

End.
