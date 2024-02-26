unit Unit1;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Unit2, Unit3, Clipbrd, Vcl.ExtDlgs,
    Vcl.Grids, Vcl.ExtCtrls;

Type
    ERRORS_CODE = (CORRECT,
                   INCORRECT_NUM,
                   INCORRECT_AMOUNT_ARR_EL,
                   INCORRECT_RANGE,
                   INCORRECT_AMOUNT_LINES,
                   IS_NOT_READABLE,
                   IS_NOT_WRITEABLE);
    TNormGrid = Class(TStringGrid);
    TMainForm = Class(TForm)
        Tabs: TMainMenu;
        FileTab: TMenuItem;
        InstructionTab: TMenuItem;
        DeveloperTab: TMenuItem;
        OpenOption: TMenuItem;
        SaveOption: TMenuItem;
        ExitOption: TMenuItem;
        TaskLabel: TLabel;
        OpenFile: TOpenTextFileDialog;
        SaveFile: TSaveTextFileDialog;
        ArrLenLabel: TLabel;
        ArrLenEdit: TEdit;
        ArrLabel: TLabel;
        ArrStringGrid: TStringGrid;
        ResultButton: TButton;
        ResultLabel: TLabel;
        ResultEdit: TEdit;
    N1: TMenuItem;
        Procedure InstructionTabOnClick(Sender: TObject);
        Procedure DeveloperTabOnClick(Sender: TObject);

        Function ReadFileData(Sender: TObject; Var F: TextFile) : ERRORS_CODE;
        Procedure OpenOptionOnClick(Sender: TObject);

        Function CheckFields() : Boolean;
        Procedure ComponentOnChange(Sender: TObject);
        Procedure ComponentOnKeyDown(Sender: TObject; Text: String; SelStart, SelLength: Integer; Var Key: Word; Shift: TShiftState; Const MIN, MAX: Integer);
        Procedure ComponentOnKeyUp(Sender: TObject; Shift: TShiftState);
        
        Procedure ArrLenEditOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure ArrLenEditOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure ArrLenEditOnKeyPress(Sender: TObject; Var Key: Char);
        Procedure ArrLenEditOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure ArrLenEditOnChange(Sender: TObject);

        Procedure ArrStringGridOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure ArrStringGridOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure ArrStringGridOnKeyPress(Sender: TObject; Var Key: Char);
        Procedure ArrStringGridOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);

        procedure ResultButtonOnClick(Sender: TObject);
        procedure ResultEditOnChange(Sender: TObject);

        Procedure WriteFileData(Var F: TextFile; Sender: TObject);

        Procedure SaveOptionOnClick(Sender: TObject);
        Procedure ExitOptionOnClick(Sender: TObject);
        Procedure ExitOnCloseQuery(Sender: TObject; Var CanClose: Boolean);
    Private
      { Private declarations }
    Public
      { Public declarations }
    End;

Const
    DIGITS = ['0'..'9'];
    DIGITS_WITHOUT_ZERO = ['1'..'9'];
    ALPHABET = ['A'..'Z', 'a'..'z'];
    ENTER = #13;
    BACKSPACE = #8;
    NONE = #0;
    ERRORS: Array [ERRORS_CODE] Of String = ( '',
                                              '������������ ����� � �����!',
                                              '������������ ����� ��������� � �������',
                                              '������������ ��������!',
                                              '������������ ����� ����� � �����!',
                                              '���� ������ ��� ������!',
                                              '���� ������ ��� ������!');
    MIN_ARR_LEN = 1;
    MAX_ARR_LEN = 99;
    MIN_ARR_EL = 1;
    MAX_ARR_EL = 153;
var
    MainForm: TMainForm;
    CtrlPressed: Boolean;
    IsSaved: Boolean = True;
    PerformCloseQuery: Boolean = True;

implementation

{$R *.dfm}

Procedure TMainForm.InstructionTabOnClick(Sender: TObject);
Var
    InstructionForm: TInstructionForm;
Begin
    InstructionForm := TInstructionForm.Create(Self);
    InstructionForm.Icon := MainForm.Icon;
    InstructionForm.ShowModal;
    InstructionForm.Free;
End;

Procedure TMainForm.DeveloperTabOnClick(Sender: TObject);
Var
    DeveloperForm: TDeveloperForm;
Begin
    DeveloperForm := TDeveloperForm.Create(Self);
    DeveloperForm.Icon := MainForm.Icon;
    DeveloperForm.ShowModal;
    DeveloperForm.Free;
End;


Function IsValidRange(Str: String; Const MIN, MAX: Integer) : Boolean;
Var
    Num: Integer;
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    Num := StrToInt(Str);
    If (Num < MIN) Or (Num > MAX) Then
        IsValidInput := False;
    IsValidRange := IsValidInput;
End;


Function ReadFileNum(Var F: TextFile; Var Num: Integer; Const MIN, MAX: Integer) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
Begin
    Error := CORRECT;
    Try
        Read(F, Num);
    Except
        Error := INCORRECT_NUM;
    End;
    If (Error = CORRECT) And IsValidRange(IntToStr(Num), MIN, MAX) Then
        Error := INCORRECT_RANGE;
    ReadFileNum := Error;
End;

Function TMainForm.ReadFileData(Sender: TObject; Var F: TextFile) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
    Num: Integer;
    I: Integer;
Begin
    Reset(F);
    Error := ReadFileNum(F, Num, MIN_ARR_LEN, MAX_ARR_LEN);
    If Error = CORRECT Then
        ArrLenEdit.Text := IntToStr(Num);
    ReadLn(F);
    For I := 0 To Num - 1 Do
        If Error = CORRECT Then
        Begin
            Error := ReadFileNum(F, Num, MIN_ARR_EL, MAX_ARR_EL);
            If Error = CORRECT Then
                ArrStringGrid.Cells[I, 1] := IntToStr(Num);
        End
        Else
            Error := INCORRECT_AMOUNT_ARR_EL;
    If Not EOF(F) Then
        Error := INCORRECT_AMOUNT_LINES;
    CloseFile(F);
    ReadFileData := Error;
End;

Procedure TMainForm.OpenOptionOnClick(Sender: TObject);
Var
    Error: ERRORS_CODE;
    F: TextFile;
    FileName: String;
Begin
    If OpenFile.Execute Then
    Begin
        FileName := OpenFile.FileName;
        AssignFile(F, FileName);
        Error := ReadFileData(Sender, F);
        If Error <> CORRECT Then
        Begin
            ArrLenEdit.Text := '';
            Application.MessageBox(PWideChar(ERRORS[Error]), '������', MB_OK Or MB_ICONINFORMATION);
        End;
    End;
End;


Function TMainForm.CheckFields() : Boolean;
Var
    I: Integer;
    IsFull: Boolean;
Begin
    IsFull := True;
    If ArrLenEdit.Text = '' Then
        IsFull := False;
    I := 0;
    While IsFull And (I < ArrStringGrid.ColCount) Do
    Begin
        If ArrStringGrid.Cells[I, 1] = '' Then
            IsFull := False;
        Inc(I);
    End;
    CheckFields := IsFull;
End;

Procedure TMainForm.ComponentOnChange(Sender: TObject);
Begin
    ResultEdit.Text := '';
    If CheckFields() Then
    Begin
        ResultButton.Enabled := True;
    End
    Else
        ResultButton.Enabled := False;
End;


Function IsBufferCorrect() : Boolean;
Var
    Num: Integer;
Begin
    IsBufferCorrect := Clipboard.HasFormat(CF_TEXT) And (Length(ClipBoard.AsText) <> 0) And TryStrToInt(Clipboard.AsText, Num);
End;

Function IsPossiblePaste(Text: String; SelStart, SelLength: Integer; Const MIN, MAX: Integer) : Boolean;
Var
    IsRight: Boolean;
Begin
    IsRight := False;
    If IsBufferCorrect() Then
    Begin
        If (SelStart = 0) And  (ClipBoard.AsText[1] = '0') Then
            IsRight := False
        Else
            IsRight :=  IsValidRange(Copy(Text, 1, SelStart) + ClipBoard.AsText + Copy(Text, SelStart + SelLength + 1), MIN, MAX);
    End;
    IsPossiblePaste := IsRight;
End;

Procedure ComponentOnContextPopup(Text: String; SelStart, SelLength: Integer; Var Handled: Boolean; Const MIN, MAX: Integer);
Begin
    If Not IsPossiblePaste(Text, SelStart, SelLength, MIN, MAX) Then
        Handled := True;
End;

Function IsValidPositiveNum(SelStart: Integer; Key: Char) : Boolean;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If (SelStart = 0) And Not CharInSet(Key, DIGITS_WITHOUT_ZERO) Then
        IsValidInput := False
    Else If Not CharInSet(Key, DIGITS) Then
        IsValidInput := False;
    IsValidPositiveNum := IsValidInput;
End;

Procedure TMainForm.ComponentOnKeyDown(Sender: TObject; Text: String; SelStart, SelLength: Integer; Var Key: Word; Shift: TShiftState; Const MIN, MAX: Integer);
Begin
     If (Shift = [ssCtrl]) And (UpperCase(Chr(Key)) = 'X') Then
    Begin
        If (SelLength = 0) And (SelStart = 1) And (Length(Text) > 1) And (Text[2] = '0') Then
            Key := Ord(NONE)
        Else If (SelLength > 0) And (SelLength <> Length(Text)) And (SelStart = 0) And (Text[SelLength + 1] = '0') Then
            Key := Ord(NONE)
    End
    Else If (Chr(Key) = ENTER) And (Length(Text) <> 0) And CheckFields() Then
        ResultButtonOnClick(Sender)
    Else If Key = VK_DELETE Then
        Key := Ord(NONE)
    Else If (Shift = [ssCtrl]) And (UpperCase(Chr(Key)) = 'V') Or (Shift = [ssShift]) And (Key = VK_INSERT) Then
    Begin
        If Not IsPossiblePaste(Text, SelStart, SelLength, MIN, MAX) Then
            Key := Ord(NONE)
    End;
    If (Shift = [ssCtrl]) And CharInSet(Chr(Key), ALPHABET) Then
        CtrlPressed := True;
End;

Procedure ComponentOnKeyPress(Text: String; SelStart, SelLength: Integer; Var Key: Char; Const MIN, MAX: Integer);
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If Key = BACKSPACE Then
    Begin
        If (SelLength = 0) And (SelStart = 1) And (Length(Text) > 1) And (Text[2] = '0') Then
            Key := NONE
        Else If (SelLength > 0) And (SelLength <> Length(Text)) And (SelStart = 0) And (Text[SelLength + 1] = '0') Then
            Key := NONE
    End
    Else If (Key <> ENTER) And Not CtrlPressed Then
    Begin
        IsValidInput := IsValidPositiveNum(SelStart, Key);
        If IsValidInput Then
            IsValidInput := IsValidRange(Copy(Text, 1, SelStart) + Key + Copy(Text, SelStart + SelLength + 1), MIN, MAX)
    End;
    If Not IsValidInput Then
        Key := NONE;
End;

Procedure TMainForm.ComponentOnKeyUp(Sender: TObject; Shift: TShiftState);
Begin
    If (Shift = [ssCtrl]) Then
        CtrlPressed := False;
    ComponentOnChange(Sender);
End;


Procedure TMainForm.ArrLenEditOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Begin
    ComponentOnContextPopup(ArrLenEdit.Text, ArrLenEdit.SelStart, ArrLenEdit.SelLength, Handled, MIN_ARR_LEN, MAX_ARR_LEN);
End;

Procedure TMainForm.ArrLenEditOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_UP Then
        SelectNext(ArrLenEdit, False, True)
    Else If Key = VK_DOWN Then
        SelectNext(ArrLenEdit, True, True);
    ComponentOnKeyDown(Sender, ArrLenEdit.Text, ArrLenEdit.SelStart, ArrLenEdit.SelLength, Key, Shift, MIN_ARR_LEN, MAX_ARR_LEN);
End;

Procedure TMainForm.ArrLenEditOnKeyPress(Sender: TObject; Var Key: Char);
Begin
    ComponentOnKeyPress(ArrLenEdit.Text, ArrLenEdit.SelStart, ArrLenEdit.SelLength, Key, MIN_ARR_LEN, MAX_ARR_LEN);
End;

Procedure TMainForm.ArrLenEditOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    ComponentOnKeyUp(Sender, Shift);
End;

Procedure DrawStringGrid(ArrLenEdit: TEdit; ArrStringGrid: TStringGrid);
Var
    I: Integer;
Begin
    ArrStringGrid.ColCount := StrToInt(ArrLenEdit.Text);
    For I := 0 To ArrStringGrid.ColCount - 1 Do
        ArrStringGrid.Cells[I, 0] := IntToStr(I + 1);
    If ArrStringGrid.ColCount > 5 Then
    Begin
        ArrStringGrid.Height := 83;
        ArrStringGrid.Width := 409;
    End
    Else
    Begin
        ArrStringGrid.Height := 63;
        ArrStringGrid.Width := ArrStringGrid.ColCount * 82 - StrToInt(ArrLenEdit.Text) + 4;
    End;
End;

Procedure TMainForm.ArrLenEditOnChange(Sender: TObject);
Var
    I: Integer;
Begin
    For I := 0 To ArrStringGrid.ColCount - 1 Do
        ArrStringGrid.Cells[I, 1] := '';
    If ArrLenEdit.Text = '' Then
    Begin
        ArrLabel.Visible := False;
        ArrStringGrid.Visible := False
    End
    Else
    Begin
        ArrLabel.Visible := True;
        ArrStringGrid.Visible := True;
        DrawStringGrid(ArrLenEdit, ArrStringGrid);
    End;
End;


Procedure TMainForm.ArrStringGridOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Var
    StringGrid: TNormGrid;
Begin
    StringGrid := TNormGrid(Sender);
    If Assigned(StringGrid.InplaceEditor) Then
        ComponentOnContextPopup(ArrStringGrid.Cells[StringGrid.Col, StringGrid.Row], StringGrid.InplaceEditor.SelStart, StringGrid.InplaceEditor.SelLength, Handled, MIN_ARR_EL, MAX_ARR_EL);
End;

Procedure TMainForm.ArrStringGridOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Var
    StringGrid: TNormGrid;
Begin
    StringGrid := TNormGrid(Sender);
    If Key = VK_UP Then
        SelectNext(ArrStringGrid, False, True)
    Else If Key = VK_DOWN Then
        SelectNext(ArrStringGrid, True, True);
    If Assigned(StringGrid.InplaceEditor) Then
        ComponentOnKeyDown(Sender, ArrStringGrid.Cells[ArrStringGrid.Col, StringGrid.Row], StringGrid.InplaceEditor.SelStart, StringGrid.InplaceEditor.SelLength, Key, Shift, MIN_ARR_EL, MAX_ARR_EL);
End;

Procedure TMainForm.ArrStringGridOnKeyPress(Sender: TObject; Var Key: Char);
Var
    StringGrid: TNormGrid;
Begin
    StringGrid := TNormGrid(Sender);
    If Assigned(StringGrid.InplaceEditor) Then
        ComponentOnKeyPress(ArrStringGrid.Cells[ArrStringGrid.Col, StringGrid.Row], StringGrid.InplaceEditor.SelStart, StringGrid.InplaceEditor.SelLength, Key, MIN_ARR_EL, MAX_ARR_EL);
End;

Procedure TMainForm.ArrStringGridOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    ComponentOnKeyUp(Sender, Shift);
End;


Function CalcCountOfOdd(ArrStringGrid: TStringGrid) : Integer;
Var
    I, CountOfOdd: Integer;
Begin
    I := 1;
    CountOfOdd := 0;
    While (I < ArrStringGrid.ColCount) Do
    Begin
        If (StrToInt(ArrStringGrid.Cells[I, 1]) Mod 2 = 1) Then
            Inc(CountOfOdd);
        Inc(I, 2);
    End;
    CalcCountOfOdd := CountOfOdd;
End;

procedure TMainForm.ResultButtonOnClick(Sender: TObject);
Var
    CountOfOdd: Integer;
begin
    CountOfOdd := CalcCountOfOdd(ArrStringGrid);
    ResultEdit.Text := IntToStr(CountOfOdd);
end;

procedure TMainForm.ResultEditOnChange(Sender: TObject);
begin
    If ResultEdit.Text = '' Then
    Begin
        IsSaved := True;
        SaveOption.Enabled := False;
        ResultEdit.Enabled := False;
    End
    Else
    Begin
        IsSaved := False;
        SaveOption.Enabled := True;
        ResultEdit.Enabled := True;
    End;
end;


Procedure TMainForm.WriteFileData(Var F: TextFile; Sender: TObject);
Begin
    ReWrite(F);
    Write(F, '����� �����, ��������������� �������: ', ResultEdit.Text);
    CloseFile(F);
End;

Procedure TMainForm.SaveOptionOnClick(Sender: TObject);
Var
    F: TextFile;
    FileName: String;
Begin
    If SaveFile.Execute Then
    Begin
        FileName := SaveFile.FileName;
        AssignFile(F, FileName);
        WriteFileData(F, Sender);
        IsSaved := True;
    End;
End;


Procedure TMainForm.ExitOptionOnClick(Sender: TObject);
Var
    Confirmation: Integer;
Begin
    PerformCloseQuery := False;
    If IsSaved Then
    Begin
        Confirmation := Application.MessageBox('�� ������������� ������ �����?', '�����', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
        If Confirmation = IDYES Then
            Close;
    End
    Else
    Begin
        Confirmation := Application.MessageBox('�� �� ��������� ����, ������ �� ���������?', '�����', MB_YESNOCANCEl + MB_ICONQUESTION + MB_DEFBUTTON2);
        Case Confirmation Of
            mrYes:
            Begin
                SaveOptionOnClick(Sender);
                If IsSaved Then
                    Close
                Else
                    ExitOptionOnClick(Sender);
            End;
            mrNo:
                Close;
        End;
    End;
    PerformCloseQuery := True;
End;

Procedure TMainForm.ExitOnCloseQuery(Sender: TObject; Var CanClose: Boolean);
Var
    Confirmation: Integer;
Begin
    If PerformCloseQuery Then
    Begin
        If IsSaved Then
        Begin
            Confirmation := Application.MessageBox('�� ������������� ������ �����?', '�����', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
            CanClose := Confirmation = IDYES;
        End
        Else
        Begin
            Confirmation := Application.MessageBox('�� �� ��������� ����, ������ �� ���������?', '�����', MB_YESNOCANCEl + MB_ICONQUESTION + MB_DEFBUTTON2);
            Case Confirmation Of
                mrYes:
                Begin
                    SaveOptionOnClick(Sender);
                    If IsSaved Then
                        CanClose := True
                    Else
                        ExitOnCloseQuery(Sender, CanClose);
                End;
                mrNo:
                    CanClose := True;
                mrCancel:
                    CanClose := False;
            End;
        End;
    End;
End;

End.
