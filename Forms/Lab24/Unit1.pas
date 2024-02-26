unit Unit1;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtDlgs, Vcl.StdCtrls, Unit2, Unit3, Clipbrd,
    Vcl.Grids;

type
    ERRORS_CODE = (CORRECT,
                   INCORRECT_NUM,
                   INCORRECT_AMOUNT_ARR_EL,
                   INCORRECT_RANGE);
    TMatrix = Array Of Array Of Integer;
    TArr = Array Of Integer;
    TNormGrid = Class(TStringGrid);
    TMainForm = class(TForm)
        Tabs: TMainMenu;
        FileTab: TMenuItem;
        OpenOption: TMenuItem;
        SaveOption: TMenuItem;
        SepLine: TMenuItem;
        ExitOption: TMenuItem;
        InstructionTab: TMenuItem;
        DeveloperTab: TMenuItem;
        OpenFile: TOpenTextFileDialog;
        SaveFile: TSAVETEXTFILEDIALOG;
        TaskLabel: TLabel;
        MatrixOrderLabel: TLabel;
        MatrixOrderComboBox: TCOMBOBOX;
        MatrixLabel: TLabel;
        MatrixStringGrid: TStringGrid;
        ResultButton: TButton;
        ResultLabel: TLabel;
        ResultMemo: TMemo;

        Procedure InstructionTabOnClick(Sender: TObject);
        Procedure DeveloperTabOnClick(Sender: TObject);

        Function ReadFileData(Sender: TObject; Var F: TextFile) : ERRORS_CODE;
        Procedure OpenOptionOnClick(Sender: TObject);

        Procedure MatrixOrderOnChange(Sender: TObject);

        Procedure MatrixStringGridOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure MatrixStringGridOnKeyPress(Sender: TObject; Var Key: Char);
        Procedure MatrixStringGridOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure MatrixOnSetEditText(Sender: TObject; ACol, ARow: Integer; Const Value: String);

        Procedure ResultButtonOnClick(Sender: TObject);
        Procedure ResultMemoOnChage(Sender: TObject);

        Procedure WriteFileData(Sender: TObject; Var F: TextFile);
        Procedure SaveOptionOnClick(Sender: TObject);

        Procedure ExitOptionOnClick(Sender: TObject);
        Procedure ExitOnCloseQuery(Sender: TObject; Var CanClose: Boolean);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

Const
    DIGITS = ['0'..'9'];
    DIGITS_WITHOUT_ZERO = ['1'..'9'];
    ALPHABET = ['A'..'Z', 'a'..'z'];
    ENTER = #13;
    BACKSPACE = #8;
    NONE = #0;
    MIN_MATRIX_ORDER = 1;
    MAX_MATRIX_ORDER = 10;
    MIN_MATRIX_EL = -1000;
    MAX_MATRIX_EL = 1000;
    ERRORS: Array [ERRORS_CODE] Of String = ( '',
                                              '������������ ����� � �����!',
                                              '������������ ����� ��������� � �������',
                                              '������������ ��������!');
  
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
    Num, MatrixOrder, Row, Col: Integer;
Begin
    Reset(F);
    Error := ReadFileNum(F, Num, MIN_MATRIX_ORDER, MAX_MATRIX_ORDER);
    MatrixOrder := 0;
    If Error = CORRECT Then
    Begin
        MatrixOrderComboBox.ItemIndex := Num - 1;
        MatrixOrderOnChange(Sender);
        MatrixOrder := Num;
    End;
    ReadLn(F);
    Row := 0;
    While (Error = CORRECT) And Not EOF(F) Do
    Begin
        If Row < MatrixOrder Then
        Begin
            Col := 0;
            While (Error = CORRECT) And Not EOLN(F) Do
            Begin
                If Col < MatrixOrder Then
                Begin
                    Error := ReadFileNum(F, Num, MIN_MATRIX_EL, MAX_MATRIX_EL);
                    If Error = CORRECT Then
                        MatrixStringGrid.Cells[Col + 1, Row + 1] := IntToStr(Num);
                End
                Else
                    Error := INCORRECT_AMOUNT_ARR_EL;
                Inc(Col);
            End;
            If Col <> MatrixOrder Then
                Error := INCORRECT_AMOUNT_ARR_EL;
            ReadLn(F);
        End
        Else
            Error := INCORRECT_AMOUNT_ARR_EL;
        Inc(Row);
    End;
    If Row <> MatrixOrder Then
        Error := INCORRECT_AMOUNT_ARR_EL;
    CloseFile(F);
    ReadFileData := Error;
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
        If Error <> CORRECT Then
        Begin
            MatrixOrderComboBox.ItemIndex := -1;
            MatrixOrderOnChange(Sender);
            Application.MessageBox(PWideChar(ERRORS[Error]), '������', MB_OK Or MB_ICONINFORMATION);
        End;
    End;
End;


Procedure MatrixClear(MatrixStringGrid: TStringGrid);
Var
    Row, Col: Integer;
Begin
    For Row := 0 To MatrixStringGrid.RowCount - 1 Do
        For Col := 0 To MatrixStringGrid.ColCount - 1 Do
            MatrixStringGrid.Cells[Col, Row] := '';
End;

Procedure DrawMatrix(MatrixLabel: TLabel; MatrixOrderComboBox: TComboBox; MatrixStringGrid: TStringGrid);
Var
    MatrixOrder, Numeration: Integer;
Begin
    If MatrixOrderComboBox.Text = '' Then
    Begin
        MatrixLabel.Visible := False;
        MatrixLabel.Enabled := False;
        MatrixStringGrid.Visible := False;
        MatrixStringGrid.Enabled := False;
    End
    Else
    Begin
        MatrixLabel.Visible := True;
        MatrixLabel.Enabled := True;
        MatrixStringGrid.Visible := True;
        MatrixStringGrid.Enabled := True;
        MatrixOrder := StrToInt(MatrixOrderComboBox.Text);
        MatrixStringGrid.RowCount := MatrixOrder + 1;
        MatrixStringGrid.ColCount := MatrixOrder + 1;
        MatrixStringGrid.Cells[0, 0] := '     \';
        For Numeration := 1 To MatrixOrder Do
        Begin
            MatrixStringGrid.Cells[Numeration, 0] := IntToStr(Numeration);
            MatrixStringGrid.Cells[0, Numeration] := IntToStr(Numeration);
        End;
        If MatrixOrder > 5 Then
        Begin
            MatrixStringGrid.Width := 510;
            MatrixStringGrid.Height := 235;
        End
        Else
        Begin
            MatrixStringGrid.Width := MatrixStringGrid.ColCount * 83 - MatrixOrder - 1;
            MatrixStringGrid.Height := MatrixStringGrid.RowCount * 36;
        End;
    End;
End;

procedure TMainForm.MatrixOrderOnChange(Sender: TObject);
begin
    MatrixClear(MatrixStringGrid);
    DrawMatrix(MatrixLabel, MatrixOrderComboBox, MatrixStringGrid);
end;


Function CheckFields(MatrixOrderComboBox: TComboBox; MatrixStringGrid: TStringGrid) : Boolean;
Var
    Row, Col: Integer;
    IsFull: Boolean;
Begin
    IsFull := True;
    If MatrixOrderComboBox.Text = '' Then
        IsFull := False;
    Row := 1;
    While IsFull And (Row < MatrixStringGrid.RowCount) Do
    Begin
        Col := 1;
        While IsFull And (Col < MatrixStringGrid.ColCount) Do
        Begin
            If (MatrixStringGrid.Cells[Col, Row] = '') Or (MatrixStringGrid.Cells[Col, Row] = '-') Then
                IsFull := False;
            Inc(Col);
        End;
        Inc(Row);
    End;
    CheckFields := IsFull;
End;


Function IsBufferCorrect() : Boolean;
Var
    Num: Integer;
Begin
    IsBufferCorrect := Clipboard.HasFormat(CF_TEXT) And (Length(ClipBoard.AsText) <> 0) And (TryStrToInt(Clipboard.AsText, Num) Or (Clipboard.AsText = '-'));
End;

Function IsValidNum(Text: String; SelStart, SelLength: Integer; Key: Char) : Boolean;
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
    IsValidNum := IsValidInput;
End;

Function IsPossiblePaste(Text: String; SelStart, SelLength: Integer; Const MIN, MAX: Integer) : Boolean;
Var
    Num: Integer;
Begin

    IsPossiblePaste := IsBufferCorrect() And
                       ((SelStart > 0) Or (Clipboard.AsText = '-') Or (Length(IntToStr(StrToInt(Clipboard.AsText))) = Length(Clipboard.AsText))) And
                       IsValidNum(Text, SelStart, SelLength, ClipBoard.AsText[1]) And
                       ((Clipboard.AsText = '-') Or TryStrToInt(Copy(Text, 1, SelStart) + ClipBoard.AsText + Copy(Text, SelStart + SelLength + 1), Num)) And
                       ((Clipboard.AsText = '-') Or IsValidRange(Copy(Text, 1, SelStart) + ClipBoard.AsText + Copy(Text, SelStart + SelLength + 1), MIN, MAX));
End;

procedure TMainForm.MatrixStringGridOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Var
    StringGrid: TNormGrid;
    Text: String;
    SelStart, SelLength: Integer;
begin
    StringGrid := TNormGrid(Sender);
    If Assigned(StringGrid.InplaceEditor) Then
    Begin
        Text := MatrixStringGrid.Cells[MatrixStringGrid.Col, MatrixStringGrid.Row];
        SelStart := StringGrid.InplaceEditor.SelStart;
        SelLength := StringGrid.InplaceEditor.SelLength;
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
        Else If (Chr(Key) = ENTER) And (Length(Text) <> 0) And CheckFields(MatrixOrderComboBox, MatrixStringGrid) Then
            ResultButtonOnClick(Sender)
        Else If Key = VK_DELETE Then
            Key := Ord(NONE)
        Else If (Shift = [ssCtrl]) And (UpperCase(Chr(Key)) = 'V') Or (Shift = [ssShift]) And (Key = VK_INSERT) Then
        Begin
            If Not IsPossiblePaste(Text, SelStart, SelLength, MIN_MATRIX_EL, MAX_MATRIX_EL) Then
                Key := Ord(NONE)
    End;
    End;
    If (Shift = [ssCtrl]) And CharInSet(Chr(Key), ALPHABET) Then
        CtrlPressed := True;
end;

procedure TMainForm.MatrixStringGridOnKeyPress(Sender: TObject; var Key: Char);
Var
    StringGrid: TNormGrid;
    Text: String;
    SelStart, SelLength: Integer;
    Num: Integer;
    IsValidInput: Boolean;
begin
    StringGrid := TNormGrid(Sender);
    If Assigned(StringGrid.InplaceEditor) Then
    Begin
        Text := MatrixStringGrid.Cells[MatrixStringGrid.Col, MatrixStringGrid.Row];
        SelStart := StringGrid.InplaceEditor.SelStart;
        SelLength := StringGrid.InplaceEditor.SelLength;
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
            IsValidInput := IsValidNum(Text, SelStart, SelLength, Key);
            If IsValidInput And TryStrToInt(Copy(Text, 1, SelStart) + Key + Copy(Text, SelStart + SelLength + 1), Num) Then
                IsValidInput := IsValidRange(Copy(Text, 1, SelStart) + Key + Copy(Text, SelStart + SelLength + 1), MIN_MATRIX_EL, MAX_MATRIX_EL);
        End;
        If Not IsValidInput Then
            Key := NONE;
    End;
End;

procedure TMainForm.MatrixStringGridOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    If (Shift = [ssCtrl]) Then
        CtrlPressed := False;
end;

procedure TMainForm.MatrixOnSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
Var
    Num: Integer;
begin
    ResultMemo.Clear;
    If (MatrixStringGrid.Cells[MatrixStringGrid.Col, MatrixStringGrid.Row] <> '-') And Not TryStrToInt(MatrixStringGrid.Cells[MatrixStringGrid.Col, MatrixStringGrid.Row], Num) Then
        MatrixStringGrid.Cells[MatrixStringGrid.Col, MatrixStringGrid.Row] := '';
    If CheckFields(MatrixOrderComboBox, MatrixStringGrid) Then
        ResultButton.Enabled := True
    Else
        ResultButton.Enabled := False;
end;


Procedure CopyMatrix(MatrixStringGrid: TStringGrid; Var Matrix: TMatrix);
Var
    Row, Col: Integer;
Begin
    SetLength(Matrix, MatrixStringGrid.RowCount - 1, MatrixStringGrid.ColCount - 1);
    For Row := 0 To High(Matrix) Do
        For Col := 0 To High(Matrix[Row]) Do
            Matrix[Row][Col] := StrToInt(MatrixStringGrid.Cells[Col + 1, Row + 1]);
End;

Procedure FillArr(Matrix: TMatrix; Var Arr: TArr; Var ArrLen: Integer);
Var
    I, Row, Col: Integer;
Begin
    I := 0;
    ArrLen := Length(Matrix) * Length(Matrix);
    SetLength(Arr, ArrLen);
    For Row := 0 To High(Matrix) Do
        For Col := 0 To High(Matrix) Do
        Begin
            Arr[I] := Matrix[Row][Col];
            Inc(I);
        End;
End;

Procedure SortArr(Var Arr: TArr; ArrLen: Integer);
Var
    I, J, PreviousMaxIndex, Buf: Integer;
Begin
    PreviousMaxIndex := ArrLen - 2;
    For I := Low(Arr) To High(Arr) Do
        For J := Low(Arr) To PreviousMaxIndex - I Do
            If Arr[J] > Arr[J + 1] Then
            Begin
                Buf := Arr[J];
                Arr[J] := Arr[J + 1];
                Arr[J + 1] := Buf;
            End;
End;

Procedure FindSame(Arr: TArr; ArrLen: Integer; Var ResMatrix: TMatrix);
Var
    Count, I, J, PreviousMaxIndex: Integer;
Begin
    Count := 1;
    J := 0;
    PreviousMaxIndex := ArrLen - 2;
    SetLength(ResMatrix, ArrLen, 2);
    For I := Low(Arr) To PreviousMaxIndex Do
        If Arr[I] = Arr[I + 1] Then
            Inc(Count)
        Else
        Begin
            ResMatrix[J][0] := Arr[I];
            ResMatrix[J][1] := Count;
            Inc(J);
            Count:= 1;
        End;
    ResMatrix[J][0] := Arr[ArrLen - 1];
    ResMatrix[J][1] := Count;
End;

Procedure WriteWindowData(ResultMemo: TMemo; ResMatrix: TMatrix; ArrLen: Integer);
Var
    I: Integer;
Begin
    I := 0;
    While (I < ArrLen) And (ResMatrix[I][1] <> 0) Do
    Begin
        ResultMemo.Lines.Add('����� ' + IntToStr(ResMatrix[I][0]) + ' ����������� ' + IntToStr(ResMatrix[I][1]) + ' ���(�).');
        Inc(I);
    End;
End;

procedure TMainForm.ResultButtonOnClick(Sender: TObject);
Var
    Matrix, ResMatrix: TMatrix;
    Arr: TArr;
    Order, ArrLen, I, J: Integer;
begin
    CopyMatrix(MatrixStringGrid, Matrix);
    FillArr(Matrix, Arr, ArrLen);
    SortArr(Arr, ArrLen);
    FindSame(Arr, ArrLen, ResMatrix);
    WriteWindowData(ResultMemo, ResMatrix, ArrLen);
end;

procedure TMainForm.ResultMemoOnChage(Sender: TObject);
begin
    If ResultMemo.Text = '' Then
    Begin
        IsSaved := True;
        SaveOption.Enabled := False;
    End
    Else
    Begin
        IsSaved := False;
        SaveOption.Enabled := True;
    End;
end;


Procedure TMainForm.WriteFileData(Sender: TObject; Var F: TextFile);
Begin
    ReWrite(F);
    Write(F, ResultMemo.Text);
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
    If IsSaved Then
    Begin
        Confirmation := Application.MessageBox('�� ������������� ������ �����?', '�����', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
        If Confirmation = IDYES Then
            Close;
    End
    Else
    Begin
        Confirmation := Application.MessageBox('�� �� ��������� ����, ������ �� ���������?', '�����', MB_YESNOCANCEl + MB_ICONQUESTION + MB_DEFBUTTON1);
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
            Confirmation := Application.MessageBox('�� �� ��������� ����, ������ �� ���������?', '�����', MB_YESNOCANCEl + MB_ICONQUESTION + MB_DEFBUTTON1);
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

end.
