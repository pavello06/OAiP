Unit ActionUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Grids,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Clipbrd, BinarySearchTreeUnit;

Type
    TActionForm = Class(TForm)
        NumberEdit: TEdit;

        ActionButton: TButton;
        CancelButton: TButton;

        Procedure AddFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);

        Procedure NumberEditChange(Sender: TObject);
        Procedure NumberEditContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure NumberEditKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure NumberEditKeyPress(Sender: TObject; Var Key: Char);
        Procedure NumberEditKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);

        Procedure ActionButtonClick(Sender: TObject);
        Procedure CloseButtonClick(Sender: TObject);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    ActionForm: TActionForm;

Implementation

{$R *.dfm}

Uses MainUnit;

Const
    ENTER = #13;
    BACKSPACE = #8;
    NONE = #0;
    DIGITS = ['0'..'9'];
    DIGITS_WITHOUT_ZERO = ['1'..'9'];
    ALPHABET = ['A'..'Z', 'a'..'z'];

Var
    CtrlPressed: Boolean = False;

Procedure TActionForm.AddFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;



Function IsValidRange(Num: Integer; Const MIN, MAX: Integer) : Boolean;
Begin
    IsValidRange := (Num >= MIN) And (Num <= MAX);
End;

Function IsPossiblePaste(SelStart, SelLength: Integer; Text: String; Const MIN, MAX: Integer) : Boolean;
Var
    Num: Integer;
Begin
    IsPossiblePaste := Clipboard.HasFormat(CF_TEXT) And (Length(ClipBoard.AsText) <> 0) And
                       TryStrToInt(Copy(Text, 1, SelStart) + ClipBoard.AsText + Copy(Text, SelStart + SelLength + 1), Num) And
                       ((SelStart = 0) And (ClipBoard.AsText[1] <> '0') Or (SelStart > 0)) And
                       IsValidRange(StrToInt(Copy(Text, 1, SelStart) + ClipBoard.AsText + Copy(Text, SelStart + SelLength + 1)), MIN, MAX);
End;

Function IsValidChar(SelStart: Integer; Key: Char) : Boolean;
Begin
    IsValidChar := (SelStart = 0) And CharInSet(Key, DIGITS_WITHOUT_ZERO) Or (SelStart > 0) And CharInSet(Key, DIGITS);
End;

Procedure TActionForm.NumberEditChange(Sender: TObject);
Begin
    ActionButton.Enabled := NumberEdit.Text <> '';
End;

Procedure TActionForm.NumberEditContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Begin
    With NumberEdit Do
    Begin
        If Not IsPossiblePaste(SelStart, SelLength, Text, MIN_NUM, MAX_NUM) Or
           (SelLength = 0) And (SelStart = 1) And (Length(Text) > 1) And (Text[2] = '0') Or
           (SelLength > 0) And (SelStart = 0) And (SelLength <> Length(Text)) And (Text[SelLength + 1] = '0') Then
            Handled := True;
    End;
End;

Procedure TActionForm.NumberEditKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    With NumberEdit Do
    Begin
        If (Shift = [ssCtrl]) And (UpCase(Chr(Key)) = 'X') Then
        Begin
            If (SelLength = 0) And (SelStart = 1) And (Length(Text) > 1) And (Text[2] = '0') Or
               (SelLength > 0) And (SelStart = 0) And (SelLength <> Length(Text)) And (Text[SelLength + 1] = '0') Then
                Key := Ord(NONE);
        End
        Else If Key = VK_DELETE Then
        Begin
            If (SelLength = 0) And (SelStart = 0) And (Length(Text) > 1) And (Text[2] = '0') Or
               (SelLength > 0) And (SelStart = 0) And (SelLength <> Length(Text)) And (Text[SelLength + 1] = '0') Then
                Key := Ord(NONE);
        End
        Else If (Shift = [ssCtrl]) And (UpCase(Chr(Key)) = 'V') Or (Shift = [ssShift]) And (Key = VK_INSERT) Then
        Begin
            If Not IsPossiblePaste(SelStart, SelLength, Text, MIN_NUM, MAX_NUM) Then
                Key := Ord(NONE);
        End;
        If (Shift = [ssCtrl]) And CharInSet(Chr(Key), ALPHABET) Then
            CtrlPressed := True;
    End;
End;

Procedure TActionForm.NumberEditKeyPress(Sender: TObject; Var Key: Char);
Begin
    With NumberEdit Do
    Begin
        If Key = BACKSPACE Then
        Begin
           If (SelLength = 0) And (SelStart = 1) And (Length(Text) > 1) And (Text[2] = '0') Or
              (SelLength > 0) And (SelStart = 0) And (SelLength <> Length(Text)) And (Text[SelLength + 1] = '0') Then
               Key := NONE;
        End
        Else If Key = ENTER Then
        Begin
            If ActionButton.Enabled Then
                ActionButtonClick(ActionButton);
        End
        Else If Not CtrlPressed Then
        Begin
            If Not (IsValidChar(SelStart, Key) And IsValidRange(StrToInt(Copy(Text, 1, SelStart) + Key + Copy(Text, SelStart + SelLength + 1)), MIN_NUM, MAX_NUM)) Then
                Key := NONE;
        End;
    End;
End;

Procedure TActionForm.NumberEditKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    CtrlPressed := False;
End;



Procedure TActionForm.ActionButtonClick(Sender: TObject);
Var
    Error: ERRORS_CODE;
Begin
    Case ActionIR Of
        'I':
            If BinarySearchTree = Nil Then
                Make(BinarySearchTree, StrToInt(NumberEdit.Text))
            Else
                Insert(BinarySearchTree, StrToInt(NumberEdit.Text), Error);
        'R':
            If (BinarySearchTree <> Nil) And (BinarySearchTree.Data = StrToInt(NumberEdit.Text)) Then
                RemoveFirstNode(BinarySearchTree, Error)
            Else
                Remove(BinarySearchTree, StrToInt(NumberEdit.Text), Error);
    End;
    If Error = CORRECT Then
    Begin
        MainForm.PaintBoxPaint(MainForm.PaintBox);
        Close;
    End
    Else
        Application.MessageBox(PWideChar(ERRORS[Error]), 'Ошибка', MB_OK Or MB_ICONERROR);

End;

Procedure TActionForm.CloseButtonClick(Sender: TObject);
Begin
    Close;
End;

End.
