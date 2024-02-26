unit Unit1;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Unit2, Unit3, Clipbrd, Vcl.ExtDlgs,
  Vcl.Grids;

Type
    ERRORS_CODE = (CORRECT,
                   INCORRECT_NUM,
                   INCORRECT_SET_EL,
                   INCORRECT_RANGE);
    TSet = Set Of Char;
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
        TaskLabel: TLabel;
        OpenFile: TOpenTextFileDialog;
        SaveFile: TSaveTextFileDialog;
        X1SetLabel: TLabel;
        X1SetStringGrid: TStringGrid;
        X2SetLabel: TLabel;
        X2SetStringGrid: TStringGrid;
        X3SetLabel: TLabel;
        X3SetStringGrid: TStringGrid;
        YSetLabel: TLabel;
        YSetStringGrid: TStringGrid;
        Y1SetLabel: TLabel;
        Y1SetStringGrid: TStringGrid;
        ResultButton: TButton;
    X1SetLenLabel: TLabel;
    X1SetLenEdit: TEdit;
    X2SetLenLabel: TLabel;
    X2SetLenEdit: TEdit;
    X3SetLenLabel: TLabel;
    X3SetLenEdit: TEdit;

        Procedure InstructionTabOnClick(Sender: TObject);
        Procedure DeveloperTabOnClick(Sender: TObject);

        Function ReadFileData(Sender: TObject; Var F: TextFile) : ERRORS_CODE;
        Procedure OpenOptionOnClick(Sender: TObject);

        Function IsFullFields(Sender: TObject) : Boolean;

        Procedure OnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean; Text: String; SelStart, SelLength: Integer);
        Procedure OnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState; Text: String; SelStart, SelLength: Integer);
        Procedure OnKeyPress(Sender: TObject; Var Key: Char; Text: String; SelStart, SelLength: Integer);
        Procedure OnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure OnChange(Sender: TObject; SetStringGrid: TStringGrid; SetLabel: TLabel; SetLenEdit: TEdit; Numeration: Integer);


        procedure X1SetEditOnContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
        procedure X1SetEditOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure X1SetEditOnKeyPress(Sender: TObject; var Key: Char);
        procedure X1SetEditOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure X1SetEditOnChange(Sender: TObject);

        procedure X2SetEditOnContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
        procedure X2SetEditOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure X2SetEditOnKeyPress(Sender: TObject; var Key: Char);
        procedure X2SetEditOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure X2SetEditOnChange(Sender: TObject);

        procedure X3SetEditOnContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
        procedure X3SetEditOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure X3SetEditOnKeyPress(Sender: TObject; var Key: Char);
        procedure X3SetEditOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure X3SetEditOnChange(Sender: TObject);

        Procedure SetOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState; Text: String; SelLength: Integer);
        Procedure SetOnKeyPress(Sender: TObject;  Var Key: Char; SetStringGrid: TStringGrid);
        procedure SetOnSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);

        procedure X1SetStringGridOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure X1SetStringGridOnKeyPress(Sender: TObject; var Key: Char);

        procedure X2SetStringGridOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure X2SetStringGridOnKeyPress(Sender: TObject; var Key: Char);

        procedure X3SetStringGridOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure X3SetStringGridOnKeyPress(Sender: TObject; var Key: Char);

        procedure ResultButtonOnClick(Sender: TObject);

        Procedure WriteFileData(Sender: TObject; Var F: TextFile);
        Procedure SaveOptionOnClick(Sender: TObject);

        Procedure ExitOptionOnClick(Sender: TObject);
        Procedure ExitOnCloseQuery(Sender: TObject; Var CanClose: Boolean);
    procedure MainFormOnCreate(Sender: TObject);



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
    DIGITS_WITHOUT_ZERO = ['1'..'9'];
    ALPHABET = ['A'..'Z', 'a'..'z'];
    ERRORS: Array [ERRORS_CODE] Of String = ( '',
                                              '������������ ����� � �����!',
                                              '������������ ����� ��������� � ���������',
                                              '������������ ��������!');
    MIN_SET_LEN = 1;
    MAX_SET_LEN = 80;
var
    MainForm: TMainForm;
    CtrlPressed: Boolean;
    IsSaved: Boolean = True;
    PerformCloseQuery: Boolean = True;

implementation

{$R *.dfm}

procedure TMainForm.MainFormOnCreate(Sender: TObject);
begin
    YSetStringGrid.Cells[0, 0] := 'Y';
    Y1SetStringGrid.Cells[0, 0] := 'Y1';
end;

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
Begin
    Num := StrToInt(Str);
    IsValidRange := (Num >= MIN) And (Num <= MAX);
End;


Function ReadFileNum(Var F: TextFile; Var Num: Integer; Const MIN, MAX: Integer) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
    SNum: String;
Begin
    Error := CORRECT;
    Try
        ReadLn(F, SNum);
    Except
        Error := INCORRECT_NUM;
    End;
    If (Error = CORRECT) And Not IsValidRange(SNum, MIN, MAX) Then
        Error := INCORRECT_RANGE;
    If (Error = CORRECT) Then
        Num := StrToInt(SNum);
    ReadFileNum := Error;
End;
Function ReadFileSet(Var F: TextFile; SetStringGrid: TStringGrid; SetLength: Integer) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
    Col: Integer;
    Ch, ChS: Char;
Begin
    Error := CORRECT;
    Col := 1;
    While (Error = CORRECT) And Not EOLN(F) Do
    Begin
        If Col <= SetLength Then
        Begin
            Read(F, Ch);
            If Col <> SetLength Then
                Read(F, ChS);
            If (ChS <> ' ') Then
                Error := INCORRECT_SET_EL;
            If Error = CORRECT Then
                SetStringGrid.Cells[Col, 0] := Ch;
        End
        Else
            Error := INCORRECT_SET_EL;
        Inc(Col);
    End;
    If Col <> SetLength + 1 Then
        Error := INCORRECT_SET_EL;
    ReadFileSet := Error;
End;

Function TMainForm.ReadFileData(Sender: TObject; Var F: TextFile) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
    Num, SetLength, Row, Col: Integer;
Begin
    Reset(F);
    Error := ReadFileNum(F, Num, MIN_SET_LEN, MAX_SET_LEN);
    SetLength := 0;
    If Error = CORRECT Then
    Begin
        X1SetLenEdit.Text := IntToStr(Num);
        SetLength := Num;
    End;
    If (Error = CORRECT) And Not EOF(F) Then
    Begin
        ReadFileSet(F, X1SetStringGrid, SetLength);
    End;
    If (Error = CORRECT) And Not EOF(F) Then
    Begin
        ReadLn(F);
        Error := ReadFileNum(F, Num, MIN_SET_LEN, MAX_SET_LEN);
        SetLength := 0;
        If Error = CORRECT Then
        Begin
            X2SetLenEdit.Text := IntToStr(Num);
            SetLength := Num;
        End;
        If (Error = CORRECT) And Not EOF(F) Then
        Begin
            ReadFileSet(F, X2SetStringGrid, SetLength);
        End;
    End;
    If (Error = CORRECT) And Not EOF(F) Then
    Begin
        ReadLn(F);
        Error := ReadFileNum(F, Num, MIN_SET_LEN, MAX_SET_LEN);
        SetLength := 0;
        If Error = CORRECT Then
        Begin
            X3SetLenEdit.Text := IntToStr(Num);
            SetLength := Num;
        End;
        If (Error = CORRECT) And Not EOF(F) Then
        Begin
            ReadFileSet(F, X3SetStringGrid, SetLength);
        End;
    End;
    If (Error = CORRECT) And Not EOF(F) Then
        Error := INCORRECT_SET_EL;
    CloseFile(F);
    ReadFileData := Error;
End;

Procedure SetClear(SetStringGrid: TStringGrid);
Var
    Col: Integer;
Begin
    For Col := 1 To SetStringGrid.ColCount - 1 Do
        SetStringGrid.Cells[Col, 0] := '';
End;

Procedure TMainForm.OpenOptionOnClick(Sender: TObject);
Var
    Error: ERRORS_CODE;
    F: TextFile;
Begin
    If OpenFile.Execute Then
    Begin
        AssignFile(F, OpenFile.FileName);
        Error := ReadFileData(Sender, F);
        SetClear(YSetStringGrid);
        SetClear(Y1SetStringGrid);
        IsSaved := True;
        SaveOption.Enabled := False;
        If Error <> CORRECT Then
        Begin
            X1SetLenEdit.Text := '';
            X2SetLenEdit.Text := '';
            X3SetLenEdit.Text := '';
            Application.MessageBox(PWideChar(ERRORS[Error]), '������', MB_OK Or MB_ICONINFORMATION);
        End
        Else
        Begin
            If IsFullFields(Sender) Then
                ResultButton.Enabled := True
            Else
                ResultButton.Enabled := False;
        End;
    End;
End;


Function TMainForm.IsFullFields(Sender: TObject) : Boolean;
Var
    Col: Integer;
    IsFull: Boolean;
Begin
    IsFull := True;
    If (X1SetLenEdit.Text = '') Or (X2SetLenEdit.Text = '') Or (X3SetLenEdit.Text = '') Then
        IsFull := False;
    Col := 1;
    While IsFull And (Col < X1SetStringGrid.ColCount) Do
    Begin
        If (X1SetStringGrid.Cells[Col, 0] = '') Then
            IsFull := False;
        Inc(Col);
    End;
    Col := 1;
    While IsFull And (Col < X2SetStringGrid.ColCount) Do
    Begin
        If (X2SetStringGrid.Cells[Col, 0] = '') Then
            IsFull := False;
        Inc(Col);
    End;
    Col := 1;
    While IsFull And (Col < X3SetStringGrid.ColCount) Do
    Begin
        If (X3SetStringGrid.Cells[Col, 0] = '') Then
            IsFull := False;
        Inc(Col);
    End;
    IsFullFields := IsFull;
End;



Procedure DrawSet(SetLabel: TLabel; SetLenEdit: TEdit; SetStringGrid: TStringGrid; Numeration: Integer);
Var
    SetLen: Integer;
Begin
    If SetLenEdit.Text = '' Then
    Begin
        SetLabel.Visible := False;
        SetLabel.Enabled := False;
        SetStringGrid.Visible := False;
        SetStringGrid.Enabled := False;
    End
    Else
    Begin
        SetLabel.Visible := True;
        SetLabel.Enabled := True;
        SetStringGrid.Visible := True;
        SetStringGrid.Enabled := True;
        SetLen := StrToInt(SetLenEdit.Text);
        SetStringGrid.ColCount := SetLen + 1;
        SetStringGrid.Cells[0, 0] := 'X' + IntToStr(Numeration);
        If SetLen > 4 Then
        Begin
            SetStringGrid.Width := 400;
            SetStringGrid.Height := 60;
        End
        Else
        Begin
            SetStringGrid.Width := SetStringGrid.ColCount * 83 - SetLen - 1;
            SetStringGrid.Height := 40;
        End;
    End;
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

Function IsBufferCorrect() : Boolean;
Var
    Num: Integer;
Begin
    IsBufferCorrect := Clipboard.HasFormat(CF_TEXT) And (Length(ClipBoard.AsText) <> 0) And TryStrToInt(Clipboard.AsText, Num);
End;

Function IsPossiblePaste(Text: String; SelStart, SelLength: Integer) : Boolean;
Var
    Num: Integer;
Begin
    IsPossiblePaste := IsBufferCorrect And
                       IsValidPositiveNum(SelStart, ClipBoard.AsText[1]) And
                       TryStrToInt(Copy(Text, 1, SelStart) + ClipBoard.AsText + Copy(Text, SelStart + SelLength + 1), Num) And
                       IsValidRange(Copy(Text, 1, SelStart) + ClipBoard.AsText + Copy(Text, SelStart + SelLength + 1), MIN_SET_LEN, MAX_SET_LEN);
End;

Procedure TMainForm.OnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean; Text: String; SelStart, SelLength: Integer);
Begin
    If Not IsPossiblePaste(Text, SelStart, SelLength) Then
        Handled := True;
End;

Procedure TMainForm.OnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState; Text: String; SelStart, SelLength: Integer);
Begin
    If (Chr(Key) = ENTER) And (Length(Text) <> 0) And IsFullFields(Sender) Then
        ResultButtonOnClick(Sender)
    Else If Key = VK_DELETE Then
        Key := Ord(NONE)
    Else If (Shift = [ssCtrl]) And (UpperCase(Chr(Key)) = 'V') Or (Shift = [ssShift]) And (Key = VK_INSERT) Then
    Begin
        If Not IsPossiblePaste(Text, SelStart, SelLength) Then
            Key := Ord(NONE)
    End;
    If (Shift = [ssCtrl]) And CharInSet(Chr(Key), ALPHABET) Then
        CtrlPressed := True;
End;

Procedure TMainForm.OnKeyPress(Sender: TObject; Var Key: Char; Text: String; SelStart, SelLength: Integer);
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
            IsValidInput := IsValidRange(Copy(Text, 1, SelStart) + Key + Copy(Text, SelStart + SelLength + 1), MIN_SET_LEN, MAX_SET_LEN);
    End;
    If Not IsValidInput Then
        Key := NONE;
End;

Procedure TMainForm.OnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If (Shift = [ssCtrl]) Then
        CtrlPressed := False;
End;

Procedure TMainForm.OnChange(Sender: TObject; SetStringGrid: TStringGrid; SetLabel: TLabel; SetLenEdit: TEdit; Numeration: Integer);
Begin
    SetClear(SetStringGrid);
    SetClear(YSetStringGrid);
    SetClear(Y1SetStringGrid);
    DrawSet(SetLabel, SetLenEdit, SetStringGrid, Numeration);
    If IsFullFields(Sender) Then
    Begin
        ResultButton.Enabled := True;
    End
    Else
        ResultButton.Enabled := False;
End;


procedure TMainForm.X1SetEditOnContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
    OnContextPopup(Sender, MousePos, Handled, X1SetLenEdit.Text, X1SetLenEdit.SelStart, X1SetLenEdit.SelLength);
end;

procedure TMainForm.X1SetEditOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    OnKeyDown(Sender, Key, Shift, X1SetLenEdit.Text, X1SetLenEdit.SelStart, X1SetLenEdit.SelLength);
end;

procedure TMainForm.X1SetEditOnKeyPress(Sender: TObject; var Key: Char);
begin
    OnKeyPress(Sender, Key, X1SetLenEdit.Text, X1SetLenEdit.SelStart, X1SetLenEdit.SelLength)
end;

procedure TMainForm.X1SetEditOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    OnKeyUp(Sender, Key, Shift);
end;

procedure TMainForm.X1SetEditOnChange(Sender: TObject);
begin
    OnChange(Sender, X1SetStringGrid, X1SetLabel, X1SetLenEdit, 1);
end;


procedure TMainForm.X2SetEditOnContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
    OnContextPopup(Sender, MousePos, Handled, X2SetLenEdit.Text, X2SetLenEdit.SelStart, X2SetLenEdit.SelLength);
end;

procedure TMainForm.X2SetEditOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    OnKeyDown(Sender, Key, Shift, X2SetLenEdit.Text, X2SetLenEdit.SelStart, X2SetLenEdit.SelLength);
end;

procedure TMainForm.X2SetEditOnKeyPress(Sender: TObject; var Key: Char);
begin
    OnKeyPress(Sender, Key, X2SetLenEdit.Text, X2SetLenEdit.SelStart, X2SetLenEdit.SelLength)
end;

procedure TMainForm.X2SetEditOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    OnKeyUp(Sender, Key, Shift);
end;

procedure TMainForm.X2SetEditOnChange(Sender: TObject);
begin
    OnChange(Sender, X2SetStringGrid, X2SetLabel, X2SetLenEdit, 2);
end;


procedure TMainForm.X3SetEditOnContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
    OnContextPopup(Sender, MousePos, Handled, X3SetLenEdit.Text, X3SetLenEdit.SelStart, X3SetLenEdit.SelLength);
end;

procedure TMainForm.X3SetEditOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    OnKeyDown(Sender, Key, Shift, X3SetLenEdit.Text, X3SetLenEdit.SelStart, X3SetLenEdit.SelLength);
end;

procedure TMainForm.X3SetEditOnKeyPress(Sender: TObject; var Key: Char);
begin
    OnKeyPress(Sender, Key, X3SetLenEdit.Text, X3SetLenEdit.SelStart, X3SetLenEdit.SelLength)
end;

procedure TMainForm.X3SetEditOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    OnKeyUp(Sender, Key, Shift);
end;

procedure TMainForm.X3SetEditOnChange(Sender: TObject);
begin
    OnChange(Sender, X3SetStringGrid, X3SetLabel, X3SetLenEdit, 3);
end;


Procedure TMainForm.SetOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState; Text: String; SelLength: Integer);
Begin
    If (Chr(Key) = ENTER) And IsFullFields(Sender) Then
        ResultButtonOnClick(Sender)
    Else If (Shift = [ssCtrl]) And (UpperCase(Chr(Key)) = 'V') Or (Shift = [ssShift]) And (Key = VK_INSERT) Then
    Begin
        Key := Ord(NoNe);
    End;
    If (Shift = [ssCtrl]) And (CharInSet(Chr(Key), ALPHABET) Or (Key = Ord(NONE))) Then
        CtrlPressed := True;
End;

Procedure TMainForm.SetOnKeyPress(Sender: TObject;  Var Key: Char; SetStringGrid: TStringGrid);
Var
    SetNormGrid: TNormGrid;
    Col: Integer;
    IsValidInput: Boolean;
Begin
    SetNormGrid := TNormGrid(SetStringGrid);
    If Assigned(SetNormGrid.InplaceEditor) Then
    Begin
        If (Key <> ENTER) And Not CtrlPressed Then
        Begin
            IsValidInput := True;
            Col := 1;
            While (Col < SetStringGrid.ColCount) Do
            Begin
                If (SetStringGrid.Cells[Col, 0] = Key) Then
                    IsValidInput := False;
                Inc(Col);
            End;
            If (SetNormGrid.InplaceEditor.SelLength = 0) And (SetStringGrid.Cells[SetStringGrid.Col, 0] <> '') And (Key <> BACKSPACE) Then
                IsValidInput := False;
            If Not IsValidInput Then
                Key := NONE;
        End
        Else
            Key := NONE;
    End;
End;

procedure TMainForm.SetOnSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
Var
    Num: Integer;
begin
    SetClear(YSetStringGrid);
    SetClear(Y1SetStringGrid);
    If Length(TStringGrid(Sender).Cells[ACol, 0]) > 1 Then
        TStringGrid(Sender).Cells[ACol, 0] := '';
    If IsFullFields(Sender) Then
        ResultButton.Enabled := True
    Else
        ResultButton.Enabled := False;
    IsSaved := True;
    SaveOption.Enabled := False;
end;


procedure TMainForm.X1SetStringGridOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Var
    SetNormGrid: TNormGrid;
begin
    SetNormGrid := TNormGrid(Sender);
    If Assigned(SetNormGrid.InplaceEditor) Then
        SetOnKeyDown(Sender, Key, Shift, X1SetStringGrid.Cells[X1SetStringGrid.Col, 0], SetNormGrid.InplaceEditor.SelLength);
end;

procedure TMainForm.X1SetStringGridOnKeyPress(Sender: TObject; var Key: Char);
begin
    SetOnKeyPress(Sender, Key, X1SetStringGrid);
end;


procedure TMainForm.X2SetStringGridOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Var
    SetNormGrid: TNormGrid;
begin
    SetNormGrid := TNormGrid(Sender);
    If Assigned(SetNormGrid.InplaceEditor) Then
        SetOnKeyDown(Sender, Key, Shift, X2SetStringGrid.Cells[X2SetStringGrid.Col, 0], SetNormGrid.InplaceEditor.SelLength);
end;

procedure TMainForm.X2SetStringGridOnKeyPress(Sender: TObject; var Key: Char);
begin
    SetOnKeyPress(Sender, Key, X2SetStringGrid);
end;


procedure TMainForm.X3SetStringGridOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Var
    SetNormGrid: TNormGrid;
begin
    SetNormGrid := TNormGrid(Sender);
    If Assigned(SetNormGrid.InplaceEditor) Then
        SetOnKeyDown(Sender, Key, Shift, X3SetStringGrid.Cells[X3SetStringGrid.Col, 0], SetNormGrid.InplaceEditor.SelLength);
end;

procedure TMainForm.X3SetStringGridOnKeyPress(Sender: TObject; var Key: Char);
begin
    SetOnKeyPress(Sender, Key, X3SetStringGrid);
end;


Procedure CopySet(SetStringGrid: TStringGrid; Var XSet: TSet);
Var
    Col: Integer;
    CharItem: AnsiChar;
Begin
    XSet := [];
    For Col := 1 To SetStringGrid.ColCount - 1 Do
        Include(XSet, AnsiChar(SetStringGrid.Cells[Col, 0][1]));
End;

Procedure UniteSets(Var Y: TSet; X1: TSet; X2: TSet; X3: TSet);
Begin
    Y := X1 + X2 + X3;
End;

Procedure FindNums(Var Y1: TSet; Y: TSet);
Var
    Ch: AnsiChar;
Begin
    Y1 := [];
    For Ch in Y Do
        If (Ch >= '0') And (Ch <= '9') Then
            Include(Y1, Ch);
End;

Procedure WriteWindowData(YSetStringGrid, Y1SetStringGrid: TStringGrid; Y: TSet; Y1: TSet);
Var
    SetLength, Col: Integer;
    CharItem: AnsiChar;
Begin
    SetLength := 0;
    for CharItem in Y do
        Inc(SetLength);
    YSetStringGrid.ColCount := SetLength + 1;
    If SetLength > 4 Then
        YSetStringGrid.Height := 60
    Else
    Begin
        YSetStringGrid.Height := 60;
        YSetStringGrid.ColCount := 5;
    End;
    Col := 1;
    for CharItem in Y do
    Begin
        YSetStringGrid.Cells[Col, 0] := String(CharItem);
        Inc(Col);
    End;
    SetLength := 0;
    for CharItem in Y1 do
        Inc(SetLength);
    Y1SetStringGrid.ColCount := SetLength + 1;
    If SetLength > 4 Then
        Y1SetStringGrid.Height := 60
    Else
    Begin
        Y1SetStringGrid.Height := 60;
        Y1SetStringGrid.ColCount := 5;
    End;
    Col := 1;
    for CharItem in Y1 do
    Begin
        Y1SetStringGrid.Cells[Col, 0] := String(CharItem);
        Inc(Col);
    End;
End;

procedure TMainForm.ResultButtonOnClick(Sender: TObject);
Var
    X1, X2, X3, Y, Y1: TSet;
Begin
    CopySet(X1SetStringGrid, X1);
    CopySet(X2SetStringGrid, X2);
    CopySet(X3SetStringGrid, X3);
    UniteSets(Y, X1, X2, X3);
    FindNums(Y1, Y);
    WriteWindowData(YSetStringGrid, Y1SetStringGrid, Y, Y1);

        IsSaved := False;
        SaveOption.Enabled := True;
end;

Procedure TMainForm.WriteFileData(Sender: TObject; Var F: TextFile);
Var
    I: Integer;
Begin
    ReWrite(F);
    Write(F, 'Y: ');
    For I := 1 To YSetStringGrid.ColCount - 1 Do
    Begin
        Write(F, YSetStringGrid.Cells[I, 0], '; ');
    End;
    WriteLn(F);
    Write(F, 'Y1: ');
    For I := 1 To Y1SetStringGrid.ColCount - 1 Do
    Begin
        Write(F, Y1SetStringGrid.Cells[I, 0], '; ');
    End;
    CloseFile(F);
End;



Procedure TMainForm.SaveOptionOnClick(Sender: TObject);
Var
    F: TextFile;
Begin
    If SaveFile.Execute Then
    Begin
        AssignFile(F, SaveFile.FileName);
        WriteFileData(Sender, F);
        IsSaved := True;
    End;
End;


Procedure TMainForm.ExitOptionOnClick(Sender: TObject);
Var
    Confirmation: Integer;
Begin
    PerformCloseQuery := False;
    If (Not IsSaved) Then
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

    End
    Else
    Begin
        Confirmation := Application.MessageBox('�� ������������� ������ �����?', '�����', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
        If Confirmation = IDYES Then
            Close;
    End;
    PerformCloseQuery := True;
End;

Procedure TMainForm.ExitOnCloseQuery(Sender: TObject; Var CanClose: Boolean);
Var
    Confirmation: Integer;
Begin
    If PerformCloseQuery Then
    Begin
        If (Not IsSaved) Then
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
        End
        Else
        Begin
            Confirmation := Application.MessageBox('�� ������������� ������ �����?', '�����', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
            CanClose := Confirmation = IDYES;
        End;
    End;
End;

End.
