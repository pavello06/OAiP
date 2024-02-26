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
                   INCORRECT_AMOUNT_LINES);
    TArr = Array Of Integer;
    TNormGrid = Class(TStringGrid);
    TMainForm = Class(TForm)
        Tabs: TMainMenu;
        FileTab: TMenuItem;
        InstructionTab: TMenuItem;
        DeveloperTab: TMenuItem;
        OpenOption: TMenuItem;
        SaveOption: TMenuItem;
        SepLine: TMenuItem;
        ExitOption: TMenuItem;
        OpenFile: TOpenTextFileDialog;
        SaveFile: TSaveTextFileDialog;
        TaskLabel: TLabel;
        ArrLenLabel: TLabel;
        ArrLenEdit: TEdit;
        ArrLabel: TLabel;
        ArrStringGrid: TStringGrid;
        ResultButton: TButton;
        ProcessLabel: TLabel;
        ProcessStringGrid: TStringGrid;
        ResultLabel: TLabel;
        ResultStringGrid: TStringGrid;
        Procedure InstructionTabOnClick(Sender: TObject);
        Procedure DeveloperTabOnClick(Sender: TObject);

        Function ReadFileData(Sender: TObject; Var F: TextFile) : ERRORS_CODE;
        Procedure OpenOptionOnClick(Sender: TObject);

        Function IsFullFields(ArrLenEdit: TEdit; ArrStringGrid: TStringGrid) : Boolean;
        Procedure ComponentOnChange(Sender: TObject);
        Procedure ComponentOnKeyUp(Shift: TShiftState);

        Procedure EditOnKeyDown(Sender: TObject; Text: String; SelStart, SelLength: Integer; Var Key: Word; Shift: TShiftState; Const MIN, MAX: Integer);
        
        Procedure ArrLenEditOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure ArrLenEditOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure ArrLenEditOnKeyPress(Sender: TObject; Var Key: Char);
        Procedure ArrLenEditOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure ArrLenEditOnChange(Sender: TObject);

        procedure GridOnKeyDown(Sender: TObject; Text: String; SelStart, SelLength: Integer; var Key: Word; Shift: TShiftState; Const MIN, MAX: Integer);

        Procedure ArrStringGridOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure ArrStringGridOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure ArrStringGridOnKeyPress(Sender: TObject; Var Key: Char);
        Procedure ArrStringGridOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
        procedure ArrStringGridOnSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);

        procedure ResultButtonOnClick(Sender: TObject);

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
    MIN_ARR_LEN = 1;
    MAX_ARR_LEN = 100;
    MIN_ARR_EL = -1000;
    MAX_ARR_EL = 1000;
    ERRORS: Array [ERRORS_CODE] Of String = ( '',
                                              '������������ ����� � �����!',
                                              '������������ ����� ��������� � �������',
                                              '������������ ��������!',
                                              '������������ ����� ����� � �����!');
var
    MainForm: TMainForm;
    CtrlPressed: Boolean = False;
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


Procedure ClearArr(ArrStringGrid: TStringGrid);
Var
    Col: Integer;
Begin
    For Col := 0 To ArrStringGrid.ColCount - 1 Do
    Begin
        ArrStringGrid.Cells[Col, 0] := '';
        ArrStringGrid.Cells[Col, 1] := '';
    End;
End;

Procedure HideArr(ArrLabel: TLabel; ArrStringGrid: TStringGrid);
Begin
    ArrLabel.Visible := False;
    ArrLabel.Enabled := False;
    ArrStringGrid.Visible := False;
    ArrStringGrid.Enabled := False;
End;

Procedure ShowArr(ArrLabel: TLabel; ArrStringGrid: TStringGrid);
Begin
    ArrLabel.Visible := True;
    ArrLabel.Enabled := True;
    ArrStringGrid.Visible := True;
    ArrStringGrid.Enabled := True;
End;

Procedure DrawArr(ArrLenEdit: TEdit; ArrLabel: TLabel; ArrStringGrid: TStringGrid);
Var
    ArrLen, Col: Integer;
Begin
    ClearArr(ArrStringGrid);
    If ArrLenEdit.Text = '' Then
        HideArr(ArrLabel, ArrStringGrid)
    Else
    Begin
        ShowArr(ArrLabel, ArrStringGrid);
        ArrLen := StrToInt(ArrLenEdit.Text);
        ArrStringGrid.ColCount := ArrLen;
        For Col := 0 To ArrLen Do
        Begin
            ArrStringGrid.Cells[Col, 0] := IntToStr(Col + 1);
        End;
        If ArrLen > 5 Then
        Begin
            ArrStringGrid.Width := 410;
            ArrStringGrid.Height := 94;
        End
        Else
        Begin
            ArrStringGrid.Width := ArrStringGrid.ColCount * 82 + 2;
            ArrStringGrid.Height := 72;
        End;
    End;
End;


Function IsValidRange(Str: String; Const MIN, MAX: Integer) : Boolean;
Var
    Num: Integer;
Begin
    Num := StrToInt(Str);
    IsValidRange := (Num >= MIN) And (Num <= MAX);
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
    If (Error = CORRECT) And Not IsValidRange(IntToStr(Num), MIN, MAX) Then
        Error := INCORRECT_RANGE;
    ReadFileNum := Error;
End;

Function TMainForm.ReadFileData(Sender: TObject; Var F: TextFile) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
    Num, ArrLen, Col: Integer;
Begin
    Reset(F);
    Error := ReadFileNum(F, Num, MIN_ARR_LEN, MAX_ARR_LEN);
    If (Error = CORRECT) And Not EOLN(F) Then
        Error := INCORRECT_NUM;
    If Error = CORRECT Then
    Begin
        ArrLenEdit.Text := IntToStr(Num);
        ArrLen := Num;
    End;
    ReadLn(F);
    Col := 0;
    While (Error = CORRECT) And Not EOF(F) Do
    Begin
        If Col < ArrLen Then
        Begin
            Error := ReadFileNum(F, Num, MIN_ARR_EL, MAX_ARR_EL);
            If Error = CORRECT Then
                ArrStringGrid.Cells[Col, 1] := IntToStr(Num);
        End
        Else
            Error := INCORRECT_AMOUNT_ARR_EL;
        Inc(Col);
    End;
    If (Error = CORRECT) And (Col <> ArrLen) Then
        Error := INCORRECT_AMOUNT_ARR_EL;
    If (Error = CORRECT) And Not EOF(F) Then
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
        End
        Else
            ResultButton.Enabled := True;
    End;
End;


Function TMainForm.IsFullFields(ArrLenEdit: TEdit; ArrStringGrid: TStringGrid) : Boolean;
Var
    Col: Integer;
    IsFull: Boolean;
Begin
    IsFull := True;
    If ArrLenEdit.Text = '' Then
        IsFull := False;
    Col := 0;
    While IsFull And (Col < ArrStringGrid.ColCount) Do
    Begin
        If (ArrStringGrid.Cells[Col, 1] = '') Or (ArrStringGrid.Cells[Col, 1] = '-') Then
            IsFull := False;
        Inc(Col);
    End;
    IsFullFields := IsFull;
End;

Procedure TMainForm.ComponentOnChange(Sender: TObject);
Begin
    HideArr(ProcessLabel, ProcessStringGrid);
    HideArr(ResultLabel, ResultStringGrid);
    IsSaved := True;
    SaveOption.Enabled := False;
    If IsFullFields(ArrLenEdit, ArrStringGrid) Then
        ResultButton.Enabled := True
    Else
        ResultButton.Enabled := False;
End;

Procedure TMainForm.ComponentOnKeyUp(Shift: TShiftState);
Begin
    CtrlPressed := False;
End;


Function IsBufferCorrectEdit() : Boolean;
Var
    Num: Integer;
Begin
    IsBufferCorrectEdit := Clipboard.HasFormat(CF_TEXT) And (Length(ClipBoard.AsText) <> 0) And TryStrToInt(Clipboard.AsText, Num);
End;

Function IsValidPositiveNumEdit(SelStart: Integer; Key: Char) : Boolean;
Begin
    IsValidPositiveNumEdit := ((SelStart = 0) And CharInSet(Key, DIGITS_WITHOUT_ZERO)) Or
                              CharInSet(Key, DIGITS);
End;

Function IsPossiblePasteEdit(Text: String; SelStart, SelLength: Integer; Const MIN, MAX: Integer) : Boolean;
Begin
    IsPossiblePasteEdit := IsBufferCorrectEdit() And ((SelStart = 0) And (ClipBoard.AsText[1] <> '0') Or (SelStart > 0)) And IsValidRange(Copy(Text, 1, SelStart) + ClipBoard.AsText + Copy(Text, SelStart + SelLength + 1), MIN, MAX);
End;

Procedure EditOnContextPopup(Text: String; SelStart, SelLength: Integer; Var Handled: Boolean; Const MIN, MAX: Integer);
Begin
    If Not IsPossiblePasteEdit(Text, SelStart, SelLength, MIN, MAX) Then
        Handled := True;
End;

Procedure TMainForm.EditOnKeyDown(Sender: TObject; Text: String; SelStart, SelLength: Integer; Var Key: Word; Shift: TShiftState; Const MIN, MAX: Integer);
Begin
If (Shift = [ssCtrl]) And (UpperCase(Chr(Key)) = 'X') Then
    Begin
        If (SelLength = 0) And (SelStart = 1) And (Length(Text) > 1) And (Text[2] = '0') Then
            Key := Ord(NONE)
        Else If (SelLength > 0) And (SelLength <> Length(Text)) And (SelStart = 0) And (Text[SelLength + 1] = '0') Then
            Key := Ord(NONE)
    End
    Else If (Chr(Key) = ENTER) And (Length(Text) <> 0) And IsFullFields(ArrLenEdit, ArrStringGrid) Then
        ResultButtonOnClick(Sender)
    Else If Key = VK_DELETE Then
        Key := Ord(NONE)
    Else If (Shift = [ssCtrl]) And (UpperCase(Chr(Key)) = 'V') Or (Shift = [ssShift]) And (Key = VK_INSERT) Then
    Begin
        If Not IsPossiblePasteEdit(Text, SelStart, SelLength, MIN, MAX) Then
            Key := Ord(NONE)
    End;
    If (Shift = [ssCtrl]) And CharInSet(Chr(Key), ALPHABET) Then
        CtrlPressed := True;
End;

Procedure EditOnKeyPress(Text: String; SelStart, SelLength: Integer; Var Key: Char; Const MIN, MAX: Integer);
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
        IsValidInput := IsValidPositiveNumEdit(SelStart, Key);
        If IsValidInput Then
            IsValidInput := IsValidRange(Copy(Text, 1, SelStart) + Key + Copy(Text, SelStart + SelLength + 1), MIN, MAX)
    End;
    If Not IsValidInput Then
        Key := NONE;
End;


Procedure TMainForm.ArrLenEditOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Begin
    EditOnContextPopup(ArrLenEdit.Text, ArrLenEdit.SelStart, ArrLenEdit.SelLength, Handled, MIN_ARR_LEN, MAX_ARR_LEN);
End;

Procedure TMainForm.ArrLenEditOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_UP Then
        SelectNext(ArrLenEdit, False, True)
    Else If Key = VK_DOWN Then
        SelectNext(ArrLenEdit, True, True)
    Else
        EditOnKeyDown(Sender, ArrLenEdit.Text, ArrLenEdit.SelStart, ArrLenEdit.SelLength, Key, Shift, MIN_ARR_LEN, MAX_ARR_LEN);
End;

Procedure TMainForm.ArrLenEditOnKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditOnKeyPress(ArrLenEdit.Text, ArrLenEdit.SelStart, ArrLenEdit.SelLength, Key, MIN_ARR_LEN, MAX_ARR_LEN);
End;

Procedure TMainForm.ArrLenEditOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    ComponentOnKeyUp(Shift);
End;

Procedure TMainForm.ArrLenEditOnChange(Sender: TObject);
Begin
    ComponentOnChange(Sender);
    DrawArr(ArrLenEdit, ArrLabel, ArrStringGrid);
End;


Function IsBufferCorrectGrid() : Boolean;
Var
    Num: Integer;
Begin
    IsBufferCorrectGrid := Clipboard.HasFormat(CF_TEXT) And (Length(ClipBoard.AsText) <> 0) And (TryStrToInt(Clipboard.AsText, Num) Or (Clipboard.AsText = '-'));
End;

Function IsValidNumGrid(Text: String; SelStart, SelLength: Integer; Key: Char) : Boolean;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If (SelStart = 0) Then
    Begin
        If (SelLength > 0) Then
        Begin
            If SelLength <> Length(Text) Then
            Begin
                If (Key = '-') And (Text[SelLength + 1] = '0') Then
                    IsValidInput := False
                Else If (Key = '0') Then
                    IsValidInput := False
            End;
            If Not (CharInSet(Key, DIGITS) Or (Key = '-')) Then
                IsValidInput := False;
        End
        Else If (Pos('-', Text) = 1) Then
            IsValidInput := False
        Else If (Pos('0', Text) = 1) And Not CharInSet(Key, DIGITS_WITHOUT_ZERO) Then
            IsValidInput := False
        Else If (Length(Text) > 0) And (Key = '0') Then
            IsValidInput := False
        Else If Not (CharInSet(Key, DIGITS) Or (Key = '-')) Then
            IsValidInput := False;
    End
    Else If (SelStart = 1) Then
    Begin
        If (SelLength > 0) Then
        Begin
            If (Key = '0') And (Text[1] = '-') Then
                IsValidInput := False;
            If Not CharInSet(Key, DIGITS) Then
                IsValidInput := False;
        End;
        If (Pos('0', Text) = 1) Then
            IsValidInput := False
        Else If (Pos('-', Text) = 1) And ((Key = '0') Or (Key = '-')) Then
            IsValidInput := False
        Else If Not CharInSet(Key, DIGITS) Then
            IsValidInput := False;
    End
    Else If Not CharInSet(Key, DIGITS) Then
        IsValidInput := False;
    IsValidNumGrid := IsValidInput;
End;

Function IsPossiblePasteGrid(Text: String; SelStart, SelLength: Integer; Const MIN, MAX: Integer) : Boolean;
Var
    Num: Integer;
Begin
    IsPossiblePasteGrid := IsBufferCorrectGrid() And
                       ((SelStart > 0) Or (Clipboard.AsText = '-') Or (Length(IntToStr(StrToInt(Clipboard.AsText))) = Length(Clipboard.AsText))) And
                       IsValidNumGrid(Text, SelStart, SelLength, ClipBoard.AsText[1]) And
                       ((Clipboard.AsText = '-') Or TryStrToInt(Copy(Text, 1, SelStart) + ClipBoard.AsText + Copy(Text, SelStart + SelLength + 1), Num)) And
                       ((Clipboard.AsText = '-') Or IsValidRange(Copy(Text, 1, SelStart) + ClipBoard.AsText + Copy(Text, SelStart + SelLength + 1), MIN, MAX));
End;

Procedure GridOnContextPopup(Text: String; SelStart, SelLength: Integer; Var Handled: Boolean; Const MIN, MAX: Integer);
Begin
    If Not IsPossiblePasteGrid(Text, SelStart, SelLength, MIN, MAX) Then
        Handled := True;
End;

procedure TMainForm.GridOnKeyDown(Sender: TObject; Text: String; SelStart, SelLength: Integer; var Key: Word; Shift: TShiftState; Const MIN, MAX: Integer);
begin
    If (Shift = [ssCtrl]) And (UpperCase(Chr(Key)) = 'X') Then
    Begin
        If (SelLength = 0) Then
        Begin
            If (SelStart = 1) And (Length(Text) > 1) And (Text[2] = '0') Or
               (SelStart = 2) And (Length(Text) > 2) And (Text[1] = '-') And (Text[3] = '0') Then
                Key := Ord(NONE);
        End
        Else If (SelLength <> Length(Text)) Then
        Begin
            If (SelStart = 0) And (Text[SelLength + 1] = '0') Or
               (SelStart = 1) And (Length(Text) > 2) And (Text[1] = '-') And (Text[SelLength + 1] = '0') Then
                Key := Ord(NONE);
        End;
    End
    Else If (Chr(Key) = ENTER) And (Length(Text) <> 0) And IsFullFields(ArrLenEdit, ArrStringGrid) Then
        ResultButtonOnClick(Sender)
    Else If Key = VK_DELETE Then
        Key := Ord(NONE)
    Else If (Shift = [ssCtrl]) And (UpperCase(Chr(Key)) = 'V') Or (Shift = [ssShift]) And (Key = VK_INSERT) Then
    Begin
        If Not IsPossiblePasteGrid(Text, SelStart, SelLength, MIN, MAX) Then
            Key := Ord(NONE)
    End;
    If (Shift = [ssCtrl]) And CharInSet(Chr(Key), ALPHABET) Then
        CtrlPressed := True;
end;

procedure GridOnKeyPress(Text: String; SelStart, SelLength: Integer; var Key: Char; Const MIN, MAX: Integer);
Var
    Num: Integer;
    IsValidInput: Boolean;
begin
    IsValidInput := True;
    If Key = BACKSPACE Then
    Begin
        If (SelLength = 0) Then
        Begin
            If (SelStart = 1) And (Length(Text) > 1) And (Text[2] = '0') Or
               (SelStart = 2) And (Length(Text) > 2) And (Text[1] = '-') And (Text[3] = '0') Then
                Key := NONE;
        End
        Else If (SelLength <> Length(Text)) Then
        Begin
            If (SelStart = 0) And (Text[SelLength + 1] = '0') Or
               (SelStart = 1) And (Length(Text) > 2) And (Text[1] = '-') And (Text[SelLength + 1] = '0') Then
                Key := NONE;
        End;
    End
    Else If (Key <> ENTER) And Not CtrlPressed Then
    Begin
        IsValidInput := IsValidNumGrid(Text, SelStart, SelLength, Key);
        If IsValidInput And TryStrToInt(Copy(Text, 1, SelStart) + Key + Copy(Text, SelStart + SelLength + 1), Num) Then
            IsValidInput := IsValidRange(Copy(Text, 1, SelStart) + Key + Copy(Text, SelStart + SelLength + 1), MIN_ARR_EL, MAX_ARR_EL);
    End;
    If Not IsValidInput Then
        Key := NONE;
End;


Procedure TMainForm.ArrStringGridOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Var
    StringGrid: TNormGrid;
Begin
    StringGrid := TNormGrid(Sender);
    If Assigned(StringGrid.InplaceEditor) Then
        GridOnContextPopup(ArrStringGrid.Cells[ArrStringGrid.Col, 1], StringGrid.InplaceEditor.SelStart, StringGrid.InplaceEditor.SelLength, Handled, MIN_ARR_EL, MAX_ARR_EL);
End;

Procedure TMainForm.ArrStringGridOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Var
    StringGrid: TNormGrid;
Begin
    If Key = VK_UP Then
        SelectNext(ArrStringGrid, False, True)
    Else If Key = VK_DOWN Then
        SelectNext(ArrStringGrid, True, True)
    Else
    Begin
        StringGrid := TNormGrid(Sender);
        If Assigned(StringGrid.InplaceEditor) Then
            GridOnKeyDown(Sender, ArrStringGrid.Cells[ArrStringGrid.Col, 1], StringGrid.InplaceEditor.SelStart, StringGrid.InplaceEditor.SelLength, Key, Shift, MIN_ARR_EL, MAX_ARR_EL);
    End;
End;

Procedure TMainForm.ArrStringGridOnKeyPress(Sender: TObject; Var Key: Char);
Var
    StringGrid: TNormGrid;
Begin
    StringGrid := TNormGrid(Sender);
    If Assigned(StringGrid.InplaceEditor) Then
        GridOnKeyPress(ArrStringGrid.Cells[ArrStringGrid.Col, 1], StringGrid.InplaceEditor.SelStart, StringGrid.InplaceEditor.SelLength, Key, MIN_ARR_EL, MAX_ARR_EL);
End;

Procedure TMainForm.ArrStringGridOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin

    ComponentOnKeyUp(Shift);
End;

procedure TMainForm.ArrStringGridOnSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
Var
    Num: Integer;
begin
    If (ArrStringGrid.Cells[ACol, ARow] <> '-') And Not TryStrToInt(ArrStringGrid.Cells[ACol, ARow], Num) Then
        ArrStringGrid.Cells[ArrStringGrid.Col, ARow] := '';
    ComponentOnChange(Sender);
end;


Procedure CopyArr(ArrStringGrid: TStringGrid; Var Arr: TArr);
Var
    Col: Integer;
Begin
    SetLength(Arr, ArrStringGrid.ColCount);
    For Col := 0 To High(Arr) Do
        Arr[Col] := StrToInt(ArrStringGrid.Cells[Col, 1]);
End;

Procedure ShowProcess(HelpArr: TArr; ProcessLabel: TLabel; Step: Integer; ProcessStringGrid: TStringGrid);
Var
    Col: Integer;
Begin
    ProcessLabel.Caption := '��� ' + IntToStr(Step) + ': ';
    For Col := 0 To High(HelpArr) Do
        ProcessStringGrid.Cells[Col, Step + 1] := IntToStr(HelpArr[Col]);
End;

Procedure SortArr(Arr: TArr; ProcessLabel: TLabel; ProcessStringGrid: TStringGrid);
Var
    HelpArr: TArr;
    Col, LeftIndex, RightIndex, I, J, CurrentElem, Step: Integer;
Begin
    SetLength(HelpArr, Length(Arr) * 2 - 1);
    ProcessLabel.Caption := '��� 1: ';
    ProcessStringGrid.ColCount := Length(HelpArr);
    ProcessStringGrid.RowCount := Length(Arr) + 1;
    HelpArr[High(Arr)] := Arr[0];
    For Col := 0 To High(HelpArr) Do
    Begin
        ProcessStringGrid.Cells[Col, 0] := IntToStr(Col + 1);
        ProcessStringGrid.Cells[Col, 1] := IntToStr(HelpArr[Col]);
    End;
    If Length(HelpArr) > 5 Then
    Begin
        ProcessStringGrid.Width := 410;
        ProcessStringGrid.Height := 174;
    End
    Else
    Begin
        ProcessStringGrid.Width := ProcessStringGrid.ColCount * 82 + 2;
        ProcessStringGrid.Height := 140;
    End;
    ShowArr(ProcessLabel, ProcessStringGrid);
    LeftIndex := High(Arr);
    RightIndex := High(Arr);
    Step := 1;
    For I := 1 To High(Arr) Do
    Begin
        CurrentElem := Arr[I];
        If CurrentElem > Arr[I - 1] Then
        Begin
            Inc(RightIndex);
            J := RightIndex;
            While CurrentElem < HelpArr[J - 1] Do
            Begin
                HelpArr[J] := HelpArr[J - 1];
                Dec(J);
            End;
        End
        Else
        Begin
            Dec(LeftIndex);
            J := LeftIndex;
            While CurrentElem > HelpArr[J + 1] Do
            Begin
                HelpArr[J] := HelpArr[J + 1];
                Inc(J);
            End;
        End;
        HelpArr[J] := CurrentElem;
        ShowProcess(HelpArr, ProcessLabel, Step, ProcessStringGrid);
        Inc(Step);
    End;
    For J := Low(Arr) To High(Arr) Do
        Arr[J] := HelpArr[J + LeftIndex];
End;

Procedure WriteWindowData(Arr: TArr; ArrLenEdit: TEdit; ResultLabel: TLabel; ResultStringGrid: TStringGrid);
Var
    Col: Integer;
Begin
    DrawArr(ArrLenEdit, ResultLabel, ResultStringGrid);
    For Col := 0 To High(Arr) Do
        ResultStringGrid.Cells[Col, 1] := IntToStr(Arr[Col]);
End;

procedure TMainForm.ResultButtonOnClick(Sender: TObject);
Var
    Arr: TArr;
begin
    CopyArr(ArrStringGrid, Arr);
    SortArr(Arr, ProcessLabel, ProcessStringGrid);
    WriteWindowData(Arr, ArrLenEdit, ResultLabel, ResultStringGrid);
    IsSaved := False;
    SaveOption.Enabled := True;
end;


Procedure TMainForm.WriteFileData(Var F: TextFile; Sender: TObject);
Var
    Row, Col: Integer;
Begin
    ReWrite(F);
    For Row := 1 To ProcessStringGrid.RowCount - 1 Do
    Begin
        WriteLn(F, '��� ', Row, ': ');
        For Col := 0 To ProcessStringGrid.ColCount Do
        Begin
            Write(F, ProcessStringGrid.Cells[Col, Row], ' ');
        End;
        WriteLn(F);
    End;
    WriteLn(F, '���������: ');
    For Col := 0 To ResultStringGrid.ColCount Do
    Begin
        Write(F, ResultStringGrid.Cells[Col, 1], ' ');
    End;
    WriteLn(F);
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
