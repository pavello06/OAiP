Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.Menus, InstructionUnit, DeveloperUnit,
    Vcl.ExtDlgs, Clipbrd;

Type
    TStringGridEx = Class(TStringGrid);

    ERRORS_CODE = (CORRECT,
                   INCORRECT_NUM,
                   INCORRECT_RANGE,
                   IS_NOT_DIFFERENT,
                   INCORRECT_NUMS_AMOUNT,
                   EXTRA_DATA);
    TArr = Array Of Integer;

    TMainForm = Class(TForm)

    TabsMainMenu: TMainMenu;
    FileMenuItem: TMenuItem;
    OpenMenuItem: TMenuItem;
    SaveMenuItem: TMenuItem;
    SeparatorMenuItem: TMenuItem;
    ExitMenuItem: TMenuItem;
    InstructionMenuItem: TMenuItem;
    DeveloperMenuItem: TMenuItem;

    OpenTextFileDialog1: TOpenTextFileDialog;
    SaveTextFileDialog1: TSaveTextFileDialog;

    TaskLabel: TLabel;
    NumsAmountLabel: TLabel;
    NumsAmountEdit: TEdit;
    NumsLabel: TLabel;
    NumsStringGrid: TStringGrid;
    ResultButton: TButton;
    ResultStringGrid: TStringGrid;

    Function MainFormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;

    Procedure InstructionMenuItemClick(Sender: TObject);
    Procedure DeveloperMenuItemClick(Sender: TObject);

    Procedure OpenMenuItemClick(Sender: TObject);

    Procedure NumsAmountEditChange(Sender: TObject);
    procedure NumsAmountEditContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    Procedure NumsAmountEditKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure NumsAmountEditKeyPress(Sender: TObject; Var Key: Char);
    Procedure NumsAmountEditKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);

    Procedure NumsStringGridExit(Sender: TObject);
    Procedure NumsStringGridKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure NumsStringGridKeyPress(Sender: TObject; Var Key: Char);
    Procedure NumsStringGridKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure NumsStringGridSelectCell(Sender: TObject; ACol, ARow: Integer; Var CanSelect: Boolean);
    Procedure NumsStringGridSetEditText(Sender: TObject; ACol, ARow: Integer; Const Value: String);

    Procedure ResultButtonClick(Sender: TObject);

    Procedure SaveMenuItemClick(Sender: TObject);

    Procedure ExitMenuItemClick(Sender: TObject);
    Procedure MainFormCloseQuery(Sender: TObject; Var CanClose: Boolean);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Const
    ENTER = #13;
    BACKSPACE = #8;
    NONE = #0;
    ALPHABET = ['A'..'Z', 'a'..'z'];
    DIGITS = ['0'..'9'];
    DIGITS_WITHOUT_ZERO = ['1'..'9'];
    ERRORS: Array [ERRORS_CODE] Of String = ( '',
                                              '������������ ����� � �����!',
                                              '�������� �� �������� � ��������!',
                                              '�������� �� ��������!',
                                              '������������ ���������� ����� � �����!',
                                              '������ ������ � �����!');
    MIN_NUMS_AMOUNT = 1;
    MAX_NUMS_AMOUNT = 8;
    MIN_NUM = 1;
    MAX_NUM = 10000;
Var
    MainForm: TMainForm;
    CtrlPressed: Boolean = False;
    IsSaved: Boolean = True;

Implementation

{$R *.dfm}

Function TMainForm.MainFormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    InstructionMenuItemClick(InstructionMenuItem);
    MainFormHelp := False;
End;



Procedure TMainForm.InstructionMenuItemClick(Sender: TObject);
Begin
    InstructionForm := TInstructionForm.Create(Self);
    InstructionForm.Icon := MainForm.Icon;
    InstructionForm.ShowModal;
    InstructionForm.Free;
End;

Procedure TMainForm.DeveloperMenuItemClick(Sender: TObject);
Begin
    DeveloperForm := TDeveloperForm.Create(Self);
    DeveloperForm.Icon := MainForm.Icon;
    DeveloperForm.ShowModal;
    DeveloperForm.Free;
End;



Function IsValidRange(Num: Integer; Const MIN, MAX: Integer) : Boolean;
Begin
    IsValidRange := (Num >= MIN) And (Num <= MAX);
End;



Function AreFileNumsDifferent(NumsArr: TArr; LastIndex: Integer) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
    I: Integer;
Begin
    Error := CORRECT;
    I := 0;
    While (Error = CORRECT) And (I < LastIndex) Do
    Begin
        If (NumsArr[I] = NumsArr[LastIndex]) Then
            Error := IS_NOT_DIFFERENT;
        Inc(I);
    End;
    AreFileNumsDifferent := Error;
End;

Function ReadFileNum(Var InputFile: TextFile; Var Num: Integer; Const MIN, MAX: Integer) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
Begin
    Error := CORRECT;
    Try
        Read(InputFile, Num);
    Except
        Error := INCORRECT_NUM;
    End;
    If (Error = CORRECT) And Not IsValidRange(Num, MIN, MAX) Then
        Error := INCORRECT_RANGE;
    ReadFileNum := Error;
End;

Function ReadFileNumsAmount(Var InputFile: TextFile; Var NumsAmount: Integer) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
Begin
    Error := ReadFileNum(InputFile, NumsAmount, MIN_NUMS_AMOUNT, MAX_NUMS_AMOUNT);
    If (Error = CORRECT) And Not seekEOLN(InputFile) Then
        Error := EXTRA_DATA;
    ReadFileNumsAmount := Error;
End;

Function ReadFileNums(Var InputFile: TextFile; Var NumsArr: TArr; NumsAmount: Integer) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
    I: Integer;
Begin
    Error := CORRECT;
    SetLength(NumsArr, NumsAmount);
    I := 0;
    While (Error = CORRECT) And Not seekEOLN(InputFile) Do
    Begin
        If I < NumsAmount Then
        Begin
            Error := ReadFileNum(InputFile, NumsArr[I], MIN_NUM, MAX_NUM);
            If Error = CORRECT Then
                Error := AreFileNumsDifferent(NumsArr, I);
        End
        Else
            Error := INCORRECT_NUMS_AMOUNT;
        Inc(I);
    End;
    If (Error = CORRECT) And (I <> NumsAmount) Then
        Error := INCORRECT_NUMS_AMOUNT;
    ReadFileNums := Error;
End;

Function ReadFileData(Var InputFile: TextFile; Var NumsArr: TArr; Var NumsAmount: Integer) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
Begin
    Reset(InputFile);
    Error := ReadFileNumsAmount(InputFile, NumsAmount);
    ReadLn(InputFile);
    If Error = CORRECT Then
        Error := ReadFileNums(InputFile, NumsArr, NumsAmount);
    If (Error = CORRECT) And Not seekEOF(InputFile) Then
        Error := EXTRA_DATA;
    CloseFile(InputFile);
    ReadFileData := Error;
End;

Procedure RecordFileData(Error: ERRORS_CODE; Var NumsArr: TArr; Var NumsAmount: Integer);
Var
    I: Integer;
Begin
    If Error = CORRECT Then
    Begin
        MainForm.NumsAmountEdit.Text := IntToStr(NumsAmount);
        For I := 0 To High(NumsArr) Do
            MainForm.NumsStringGrid.Cells[I, 1] := IntToStr(NumsArr[I]);
        MainForm.ResultButton.Enabled := True;
    End
    Else
        Application.MessageBox(PWideChar(ERRORS[Error]), '������', MB_OK Or MB_ICONERROR);
End;

Procedure TMainForm.OpenMenuItemClick(Sender: TObject);
Var
    Error: ERRORS_CODE;
    InputFile: TextFile;
    NumsArr: TArr;
    NumsAmount: Integer;
Begin
    If OpenTextFileDialog1.Execute Then
    Begin
        AssignFile(InputFile, OpenTextFileDialog1.FileName);
        Error := ReadFileData(InputFile, NumsArr, NumsAmount);
        RecordFileData(Error, NumsArr, NumsAmount);
    End;
End;



Procedure ClearStringGrid(StringGrid: TStringGrid);
Var
    Row, Col: Integer;
Begin
    For Row := 0 To StringGrid.RowCount - 1 Do
        For Col := 0 To StringGrid.ColCount - 1 Do
            StringGrid.Cells[Col, Row] := '';
    StringGrid.Enabled := False;
    StringGrid.Visible := False;
End;



Function IsFullFields() : Boolean;
Const
    NumsRow = 1;
Var
    IsFull: Boolean;
    Col: Integer;
Begin
    IsFull := MainForm.NumsAmountEdit.Text <> '';
    Col := 0;
    While IsFull And (Col < MainForm.NumsStringGrid.ColCount) Do
    Begin
        If (MainForm.NumsStringGrid.Cells[Col, NumsRow] = '') Then
            IsFull := False;
        Inc(Col);
    End;
    IsFullFields := IsFull;
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

Procedure DrawNumsStringGrid(NumsStringGrid: TStringGrid; ColCount: Integer);
Const
    FixedRow = 0;
Var
    I: Integer;
Begin
    NumsStringGrid.ColCount := ColCount;
    For I := 0 To NumsStringGrid.ColCount - 1 Do
        NumsStringGrid.Cells[I, FixedRow] := IntToStr(I + 1);
    NumsStringGrid.ScrollBars := ssNone;
    NumsStringGrid.Width := NumsStringGrid.ColCount * (NumsStringGrid.DefaultColWidth + NumsStringGrid.GridLineWidth) + NumsStringGrid.GridLineWidth + 2;
    NumsStringGrid.Height := 82; // 2 * (NumsStringGrid.DefaultRowHeight + NumsStringGrid.GridLineWidth) + NumsStringGrid.GridLineWidth
    NumsStringGrid.Enabled := True;
    NumsStringGrid.Visible := True;
End;

Function AreFormNumsDifferent(NumsStringGrid: TStringGrid) : Boolean;
Const
    NumsRow = 1;
Var
    IsDifferent: Boolean;
    Col: Integer;
Begin
    IsDifferent := True;
    If NumsStringGrid.Cells[NumsStringGrid.Col, NumsRow] <> '' Then
    Begin
        Col := 0;
        While IsDifferent And (Col < NumsStringGrid.ColCount) Do
        Begin
            If (Col <> NumsStringGrid.Col) And (NumsStringGrid.Cells[NumsStringGrid.Col, NumsRow] = NumsStringGrid.Cells[Col, NumsRow]) Then
                IsDifferent := False;
            Inc(Col);
        End;
    End;
    AreFormNumsDifferent := IsDifferent;
End;

Procedure DeleteIdentical(NumsStringGrid: TStringGrid);
Const
    NumsRow = 1;
Var
    Col1, Col2: Integer;
    IsIdentical: Boolean;
Begin
    IsIdentical := False;
    Col1 := 0;
    Repeat
        Col2 := Col1 + 1;
        Repeat
            If (NumsStringGrid.Cells[Col1, NumsRow] <> '') And (NumsStringGrid.Cells[Col1, NumsRow] = NumsStringGrid.Cells[Col2, NumsRow]) Then
            Begin
                IsIdentical := True;
                NumsStringGrid.Cells[Col2, NumsRow] := '';
                Application.MessageBox('����������� ����� ������ ���� ����������!', '������', MB_OK Or MB_ICONERROR);
            End;
            Inc(Col2);
        Until IsIdentical Or (Col2 >= NumsStringGrid.ColCount);
        Inc(Col1);
    Until IsIdentical Or (Col1 >= NumsStringGrid.ColCount);
End;



Procedure ComponentChange();
Begin
    If MainForm.ResultStringGrid.Cells[0, 0] <> '' Then
        ClearStringGrid(MainForm.ResultStringGrid);
    IsSaved := True;
    MainForm.SaveMenuItem.Enabled := False;
End;

Procedure ComponentKeyDown(Var Key: Word; Shift: TShiftState; SelStart, SelLength: Integer; Text: String; Const MIN, MAX: Integer);
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
        If Not IsPossiblePaste(SelStart, SelLength, Text, MIN, MAX) Then
            Key := Ord(NONE);
    End;
    If (Shift = [ssCtrl]) And CharInSet(Chr(Key), ALPHABET) Then
        CtrlPressed := True;
End;

Procedure ComponentKeyPress(Var Key: Char; SelStart, SelLength: Integer; Text: String; Const MIN, MAX: Integer);
Begin
    If Key = BACKSPACE Then
    Begin
       If (SelLength = 0) And (SelStart = 1) And (Length(Text) > 1) And (Text[2] = '0') Or
          (SelLength > 0) And (SelStart = 0) And (SelLength <> Length(Text)) And (Text[SelLength + 1] = '0') Then
           Key := NONE;
    End
    Else If Key = ENTER Then
    Begin
        If IsFullFields() Then
            MainForm.ResultButtonClick(MainForm.ResultButton);
    End
    Else If Not CtrlPressed Then
    Begin
        If Not (IsValidChar(SelStart, Key) And IsValidRange(StrToInt(Copy(Text, 1, SelStart) + Key + Copy(Text, SelStart + SelLength + 1)), MIN, MAX)) Then
            Key := NONE;
    End;
End;

Procedure ComponentKeyUp();
Begin
    CtrlPressed := False;
End;



Procedure TMainForm.NumsAmountEditChange(Sender: TObject);
Begin
    ComponentChange();
    ResultButton.Enabled := False;
    ClearStringGrid(NumsStringGrid);
    If NumsAmountEdit.Text = '' Then
    Begin
        NumsLabel.Enabled := False;
        NumsLabel.Visible := False;
    End
    Else
    Begin
        NumsLabel.Enabled := True;
        NumsLabel.Visible := True;
        DrawNumsStringGrid(NumsStringGrid, StrToInt(NumsAmountEdit.Text));
        NumsStringGrid.Col := 0;
    End;
End;

procedure TMainForm.NumsAmountEditContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Begin
    If Not IsPossiblePaste(NumsAmountEdit.SelStart, NumsAmountEdit.SelLength, NumsAmountEdit.Text, MIN_NUMS_AMOUNT, MAX_NUMS_AMOUNT) Or
       (NumsAmountEdit.SelLength = 0) And (NumsAmountEdit.SelStart = 1) And (Length(NumsAmountEdit.Text) > 1) And (NumsAmountEdit.Text[2] = '0') Or
       (NumsAmountEdit.SelLength > 0) And (NumsAmountEdit.SelStart = 0) And (NumsAmountEdit.SelLength <> Length(NumsAmountEdit.Text)) And (NumsAmountEdit.Text[NumsAmountEdit.SelLength + 1] = '0') Then
        Handled := True;
End;

Procedure TMainForm.NumsAmountEditKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    ComponentKeyDown(Key, Shift, NumsAmountEdit.SelStart, NumsAmountEdit.SelLength, NumsAmountEdit.Text, MIN_NUMS_AMOUNT, MAX_NUMS_AMOUNT);
End;

Procedure TMainForm.NumsAmountEditKeyPress(Sender: TObject; Var Key: Char);
Begin
    ComponentKeyPress(Key, NumsAmountEdit.SelStart, NumsAmountEdit.SelLength, NumsAmountEdit.Text, MIN_NUMS_AMOUNT, MAX_NUMS_AMOUNT);
End;

Procedure TMainForm.NumsAmountEditKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    ComponentKeyUp();
End;



Procedure TMainForm.NumsStringGridExit(Sender: TObject);
Begin
    DeleteIdentical(NumsStringGrid);
End;

Procedure TMainForm.NumsStringGridKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Var
    NumsGrid: TStringGridEx;
    SelStart, SelLength: Integer;
    Text: String;
Begin
    NumsGrid := TStringGridEx(Sender);
    If Assigned(NumsGrid.InplaceEditor) Then
    Begin
        SelStart := NumsGrid.InplaceEditor.SelStart;
        SelLength := NumsGrid.InplaceEditor.SelLength;
        Text := NumsGrid.InplaceEditor.Text;
        ComponentKeyDown(Key, Shift, SelStart, SelLength, Text, MIN_NUM, MAX_NUM);
    End;
End;

Procedure TMainForm.NumsStringGridKeyPress(Sender: TObject; Var Key: Char);
Var
    NumsGrid: TStringGridEx;
    SelStart, SelLength: Integer;
    Text: String;
Begin
    NumsGrid := TStringGridEx(Sender);
    If Assigned(NumsGrid.InplaceEditor) Then
    Begin
        SelStart := NumsGrid.InplaceEditor.SelStart;
        SelLength := NumsGrid.InplaceEditor.SelLength;
        Text := NumsGrid.InplaceEditor.Text;
        ComponentKeyPress(Key, SelStart, SelLength, Text, MIN_NUM, MAX_NUM);
    End;
End;

Procedure TMainForm.NumsStringGridKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    ComponentKeyUp();
End;

Procedure TMainForm.NumsStringGridSelectCell(Sender: TObject; ACol, ARow: Integer; Var CanSelect: Boolean);
Begin
    DeleteIdentical(NumsStringGrid);
End;

Procedure TMainForm.NumsStringGridSetEditText(Sender: TObject; ACol, ARow: Integer; Const Value: String);
Var
    NumsGrid: TStringGridEx;
    Text: String;
    Num: Integer;
Begin
    ComponentChange();
    NumsGrid := TStringGridEx(Sender);
    If Assigned(NumsGrid.InplaceEditor) Then
    Begin
        Text := NumsGrid.InplaceEditor.Text;
        If Not (TryStrToInt(Text, Num) And (Text[1] <> '0') And IsValidRange(StrToInt(Text), MIN_NUM, MAX_NUM)) Then
            NumsStringGrid.Cells[NumsStringGrid.Col, NumsStringGrid.Row] := '';
    End;
    ResultButton.Enabled := IsFullFields() And AreFormNumsDifferent(NumsStringGrid);
End;



Procedure FillArrayFromStringGrid(NumsStringGrid: TStringGrid; Var NumsArr: TArr);
Const
    NumsRow = 1;
Var
    I: Integer;
Begin
    SetLength(NumsArr, NumsStringGrid.ColCount);
    For I := 0 To High(NumsArr) Do
        NumsArr[I] := StrToInt(NumsStringGrid.Cells[I, NumsRow]);
End;

Function Factorial(N: Integer) : Integer;
Var
    ResFactorial, I: Integer;
Begin
    ResFactorial := 1;
    For I := 2 To N Do
        ResFactorial := ResFactorial * I;
    Factorial := ResFactorial;
End;

Procedure DrawResultStringGrid(ResultStringGrid: TStringGrid);
Const
    FixedRow = 0;
Var
    Col: Integer;
Begin
    ResultStringGrid.ColCount := MainForm.NumsStringGrid.ColCount;
    ResultStringGrid.RowCount := Factorial(ResultStringGrid.ColCount) + 1;
    For Col := 0 To ResultStringGrid.ColCount - 1 Do
        ResultStringGrid.Cells[Col, FixedRow] := IntToStr(Col + 1);
    ResultStringGrid.Width := ResultStringGrid.ColCount * (ResultStringGrid.DefaultColWidth + ResultStringGrid.GridLineWidth) + ResultStringGrid.GridLineWidth + 20;
    ResultStringGrid.Height := ResultStringGrid.Height + 5;
    ResultStringGrid.ScrollBars := ssNone;
    If (ResultStringGrid.RowCount > 3) Then
    Begin
        ResultStringGrid.ScrollBars := ssVertical;
        ResultStringGrid.Width := ResultStringGrid.Width + 22;
        ResultStringGrid.Height := 120;
    End;
End;

Procedure SwapNums(Var Num1, Num2: Integer);
Var
    Temp: Integer;
Begin
    Temp := Num1;
    Num1 := Num2;
    Num2 := Temp;
End;

Procedure WriteFormData(NumsArr: TArr; Var PrintingRow: Integer);
Var
    I: Integer;
Begin
    For I := 0 To High(NumsArr) Do
        MainForm.ResultStringGrid.Cells[I, PrintingRow] := IntToStr(NumsArr[I]);
    Inc(PrintingRow);
End;

Procedure MakePermutations(NumsArr: TArr; StartIndex: Integer; Var PrintingRow: Integer);
Var
    I: Integer;
Begin
    If StartIndex = High(NumsArr) Then
        WriteFormData(NumsArr, PrintingRow)
    Else
        For I := StartIndex To High(NumsArr) Do
        Begin
            SwapNums(NumsArr[I], NumsArr[StartIndex]);
            MakePermutations(NumsArr, StartIndex + 1, PrintingRow);
            SwapNums(NumsArr[I], NumsArr[StartIndex]);
        End;
End;



Procedure TMainForm.ResultButtonClick(Sender: TObject);
Var
    NumsArr: TArr;
    PrintingRow: Integer;
Begin
    FillArrayFromStringGrid(NumsStringGrid, NumsArr);
    DrawResultStringGrid(ResultStringGrid);
    PrintingRow := 1;
    MakePermutations(NumsArr, 0, PrintingRow);
    ResultStringGrid.Enabled := True;
    ResultStringGrid.Visible := True;
    IsSaved := False;
    SaveMenuItem.Enabled := True;
End;



Procedure WriteFileData(ResultStringGrid: TStringGrid; Var OutputFile: TextFile);
Var
    Row, Col: Integer;
Begin
    ReWrite(OutputFile);
    WriteLn(OutputFile, '������������:');
    For Row := 1 To ResultStringGrid.RowCount - 1 Do
    Begin
        For Col := 0 To ResultStringGrid.ColCount - 1 Do
            Write(OutputFile, ResultStringGrid.Cells[Col, Row], ' ');
        WriteLn(OutputFile);
    End;
    CloseFile(OutputFile);
End;

Procedure TMainForm.SaveMenuItemClick(Sender: TObject);
Var
    OutputFile: TextFile;
Begin
    If SaveTextFileDialog1.Execute Then
    Begin
        AssignFile(OutputFile, SaveTextFileDialog1.FileName);
        WriteFileData(ResultStringGrid, OutputFile);
        IsSaved := True;
    End;
End;



Procedure TMainForm.ExitMenuItemClick(Sender: TObject);
Begin
    Close;
End;

Procedure TMainForm.MainFormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Var
    Confirmation: Integer;
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
                SaveMenuItemClick(Sender);
                If IsSaved Then
                    CanClose := True
                Else
                    MainFormCloseQuery(Sender, CanClose);
            End;
            mrNo:
                CanClose := True;
            mrCancel:
                CanClose := False;
        End;
    End;
End;

End.
