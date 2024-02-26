Unit Unit1;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Unit2, Unit3, Clipbrd;

Type
    ERRORS_CODE = (CORRECT,
                   INCORRECT_NUM,
                   INCORRECT_RANGE,
                   INCORRECT_AMOUNT_LINES,
                   IS_NOT_READABLE,
                   IS_NOT_WRITEABLE);
    TSAVE = (SAVE, UNSAVE);
    TLab = Class(TForm)
        Tabs: TMainMenu;
        FileTab: TMenuItem;
        InstructionTab: TMenuItem;
        DeveloperTab: TMenuItem;
        OpenOption: TMenuItem;
        SaveOption: TMenuItem;
        ExitOption: TMenuItem;
        TaskLabel: TLabel;
        OpenFile: TOpenDialog;
        NLabel: TLabel;
        NEdit: TEdit;
        ResultLabel: TLabel;
        ResultButton: TButton;
        ResultEdit: TEdit;
        Procedure InstructionTabOnClick(Sender: TObject);
        Procedure DeveloperTabOnClick(Sender: TObject);
        Procedure CheckControlButtons(Sender: TObject; CurrentEdit: TEdit; Var Key: Word);
        Function ReadFileData(Sender: TObject; Var F: TextFile) : ERRORS_CODE;
        Procedure OpenOptionOnClick(Sender: TObject);
        Procedure NOnClick(Sender: TObject);
        Procedure NOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure NEditOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure NEditOnKeyPress(Sender: TObject; var Key: Char);
        procedure NEditOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
        Procedure NOnChange(Sender: TObject);
        Procedure ResultButtonOnClick(Sender: TObject);
        Procedure ResultEditOnChange(Sender: TObject);
        procedure ResultOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
    DIGITS_WITHOUT_ZERO = ['1'..'9'];
    DIGITS = ['0'..'9'];
    CONTROL = [VK_LEFT, VK_UP, VK_RIGHT, VK_DOWN];
    ENTER = #13;
    BACKSPACE = #8;
    NONE = #0;
    ERRORS: Array [ERRORS_CODE] Of String = ( '',
                                              '������������ ����� � �����!',
                                              '������������ ��������!',
                                              '������������ ����� ����� � �����!',
                                              '���� ������ ��� ������!',
                                              '���� ������ ��� ������!');

Var
    Lab: TLab;

Implementation

{$R *.dfm}

Procedure TLab.InstructionTabOnClick(Sender: TObject);
Var
    InstructionForm: TInstructionForm;
Begin
    InstructionForm := TInstructionForm.Create(Self);
    InstructionForm.Icon := Lab.Icon;
    InstructionForm.ShowModal;
    InstructionForm.Free;
End;

Procedure TLab.DeveloperTabOnClick(Sender: TObject);
Var
    DeveloperForm: TDeveloperForm;
Begin
    DeveloperForm := TDeveloperForm.Create(Self);
    DeveloperForm.Icon := Lab.Icon;
    DeveloperForm.ShowModal;
    DeveloperForm.Free;
End;


Procedure TLab.CheckControlButtons(Sender: TObject; CurrentEdit: TEdit; Var Key: Word);
Begin
    If (Key = VK_LEFT) Or (Key = VK_UP) Then
        SelectNext(CurrentEdit, False, True)
    Else If (Key = VK_RIGHT) Or (Key = VK_DOWN) Then
        SelectNext(CurrentEdit, True, True);
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


Function IsReadable(Var F: TextFile) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
Begin
    Error := CORRECT;
    Try
        Try
            Reset(F);
        Finally
            CloseFile(F);
        End;
    Except
        Error := IS_NOT_READABLE;
    End;
    IsReadable := Error;
End;

Function IsValidFileNum(Str: String) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
    Num: Integer;
Begin
    Error := CORRECT;
    If Not TryStrToInt(Str, Num) Then
        Error := INCORRECT_NUM;
    IsValidFileNum := Error ;
End;

Function ReadFileNum(Var F: TextFile; Var Edit: String; Const MIN, MAX: Integer) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
    SNum: String;
    IsValidInput: Boolean;
Begin
    If Not EOF(F) Then
    Begin
        ReadLn(F, SNum);
        Error := IsValidFileNum(SNum);
        If Error = CORRECT Then
        Begin
            IsValidInput := IsValidRange(SNum, MIN, MAX);
            If Not IsValidInput Then
                Error := INCORRECT_RANGE;
        End;
        If Error = CORRECT Then
            Edit := SNum;
    End
    Else
        Error := INCORRECT_AMOUNT_LINES;
    ReadFileNum := Error;
End;

Function TLab.ReadFileData(Sender: TObject; Var F: TextFile) : ERRORS_CODE;
Const
    MIN_N = 1;
    MAX_N = 10000;
Var
    Error: ERRORS_CODE;
    SNum: String;
Begin
    Reset(F);
    Error := ReadFileNum(F, SNum, MIN_N, MAX_N);
    If Not EOF(F) Then
        Error := INCORRECT_AMOUNT_LINES;
    If Error = Correct Then 
        NEdit.Text := SNum;
    CloseFile(F);
    ReadFileData := Error;
End;

Procedure TLab.OpenOptionOnClick(Sender: TObject);
Var
    Error: ERRORS_CODE;
    F: TextFile;
    FileName: String;
Begin
    If OpenFile.Execute Then
    Begin
        FileName := OpenFile.FileName;
        AssignFile(F, FileName);
        Error := IsReadable(F);
        If Error = CORRECT Then
            Error := ReadFileData(Sender, F);
        If Error <> CORRECT Then
            Application.MessageBox(PWideChar(ERRORS[Error]), '������', MB_OK Or MB_ICONINFORMATION);
    End;
End;


Var
    CtrlPressed: Boolean;

Procedure TLab.NOnClick(Sender: TObject);
Begin
    If NEdit.SelStart <> Length(NEdit.Text) Then
        NEdit.SelStart := Length(NEdit.Text);
End;

Function IsBufferCorrect() : Boolean;
Var
    Num: Integer;
Begin
    IsBufferCorrect := Clipboard.HasFormat(CF_TEXT) And TryStrToInt(Clipboard.AsText, Num);
End;

Function IsPossiblePaste(Text: String; Const MIN, MAX: Integer) : Boolean;
Var
    Num: Integer;
Begin
    IsPossiblePaste := IsBufferCorrect And TryStrToInt(Text + ClipBoard.AsText, Num) And IsValidRange(Text + ClipBoard.AsText, MIN, MAX);
End;

Procedure TLab.NOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Const
    MIN_N = 1;
    MAX_N = 10000;
Begin
    If Not IsPossiblePaste(NEdit.Text, MIN_N, MAX_N) Then
        Handled := True;
End;

Procedure TLab.NEditOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Const
    MIN_N = 1;
    MAX_N = 10000;
Begin
    If Key In CONTROL Then
        CheckControlButtons(Sender, NEdit, Key)
    Else If (Key = Ord(ENTER)) And (Length(NEdit.Text) <> 0) Then
        ResultButtonOnClick(Sender)
    Else If (Shift = [ssCtrl]) And ((Key = Ord('V')) Or (Key = Ord('v'))) Then
        If IsPossiblePaste(NEdit.Text, MIN_N, MAX_N) Then
            CtrlPressed := True
        Else
            Key := Ord(NONE)
    Else If (Shift = [ssShift]) And (Key = VK_INSERT) Then
        If Not IsPossiblePaste(NEdit.Text, MIN_N, MAX_N) Then
            Key := Ord(NONE);
End;

Function IsValidEditNum(Text: String; Key: Char) : Boolean;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If (Length(Text) = 0) And Not CharInSet(Key, DIGITS_WITHOUT_ZERO) Then
        IsValidInput := False
    Else If Not CharInSet(Key, DIGITS) Then
        IsValidInput := False;
    IsValidEditNum := IsValidInput;
End;

Procedure TLab.NEditOnKeyPress(Sender: TObject; Var Key: Char);
Const
    MIN_N = 1;
    MAX_N = 10000;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If (Key <> BACKSPACE) And (Key <> ENTER) And Not CtrlPressed Then
    Begin
        IsValidInput := IsValidEditNum(NEdit.Text, Key);
        If IsValidInput Then
            IsValidInput := IsValidRange(NEdit.Text + Key, MIN_N, MAX_N);
    End;
    If Not IsValidInput Then
        Key := NONE;
End;

Procedure TLab.NEditOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If (Shift = [ssCtrl]) Then
        CtrlPressed := False;    
End;

Procedure TLab.NOnChange(Sender: TObject);
Begin
    ResultEdit.Enabled := False;
    ResultEdit.Text := '';
    If Length(NEdit.Text) = 0 Then
        ResultButton.Enabled := False
    Else
        ResultButton.Enabled := True;
End;


Var
    IsSaved: TSAVE = SAVE;

Function CalcCycleSum(N: Integer) : Integer;
Var
    CycleSum, I: Integer;
Begin
    CycleSum := 0;
    For I := 1 To N Do
        Inc(CycleSum, I);
    CalcCycleSum := CycleSum;
End;

Function CalcRowSum(N: Integer) : Integer;
Var
    RowSum: Integer;
Begin
    RowSum := N * (N + 1) Div 2;
    CalcRowSum := RowSum;
End;

Function CheckFormulaWorked(N: Integer) : Boolean;
Var
    CycleSum, RowSum: Integer;
    IsFormulaWorked: Boolean;
Begin
    CycleSum := CalcCycleSum(N);
    RowSum := CalcRowSum(N);
    If CycleSum = RowSum Then
        IsFormulaWorked := True
    Else
        IsFormulaWorked := False;
    CheckFormulaWorked := IsFormulaWorked;
End;

Procedure TLab.ResultButtonOnClick(Sender: TObject);
Var
    N: Integer;
Begin
    N := StrToInt(NEdit.Text);
    If CheckFormulaWorked(N) Then
        ResultEdit.Text := '������� ��������!'
    Else
        ResultEdit.Text := '������� �� ��������!';
    ResultEdit.Enabled := True;
End;

Procedure TLab.ResultEditOnChange(Sender: TObject);
Begin
    If ResultEdit.Text = '' Then
    Begin
        IsSaved := SAVE;
        SaveOption.Enabled := False;
        ResultEdit.Enabled := False;
    End
    Else
    Begin
        IsSaved := UNSAVE;
        SaveOption.Enabled := True;
        ResultEdit.Enabled := True;
    End;
End;

Procedure TLab.ResultOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    CheckControlButtons(Sender, ResultEdit, Key);
End;

Function IsWriteable(Var F: TextFile) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
Begin
    Error := CORRECT;
    Try
        Try
            Append(F);
        Finally
            CloseFile(F);
        End;
    Except
        Error := Is_NOT_WRITEABLE;
    End;
    IsWriteable := Error;
End;

Procedure TLab.WriteFileData(Var F: TextFile; Sender: TObject);
Begin
    Append(F);
    Write(F, ResultEdit.Text);
    CloseFile(F);
End;

Procedure TLab.SaveOptionOnClick(Sender: TObject);
Var
    Error: ERRORS_CODE;
    F: TextFile;
    FileName: String;
Begin
    If OpenFile.Execute Then
    Begin
        FileName := OpenFile.FileName;
        AssignFile(F, FileName);
        Error := IsWriteable(F);
        If Error = CORRECT Then
        Begin
            WriteFileData(F, Sender);
            IsSaved := SAVE;
        End
        Else
        Begin
            Application.MessageBox(PWideChar(ERRORS[Error]), '������', MB_OK Or MB_ICONINFORMATION);
            IsSaved := UNSAVE;
        End;
    End;
End;


Var
    PerformCloseQuery: Boolean = True;

Procedure TLab.ExitOptionOnClick(Sender: TObject);
Var
    Confirmation: Integer;
Begin
    PerformCloseQuery := False;
    If (IsSaved = UNSAVE) Then
    Begin
        Confirmation := Application.MessageBox('�� �� ��������� ����, ������ �� ���������?', '�����', MB_YESNOCANCEl + MB_ICONQUESTION + MB_DEFBUTTON2);
        Case Confirmation Of
            mrYes:
            Begin
                SaveOptionOnClick(Sender);
                If IsSaved = SAVE Then
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

Procedure TLab.ExitOnCloseQuery(Sender: TObject; Var CanClose: Boolean);
Var
    Confirmation: Integer;
Begin
    If PerformCloseQuery Then
    Begin
        If (IsSaved = UNSAVE) Then
        Begin
            Confirmation := Application.MessageBox('�� �� ��������� ����, ������ �� ���������?', '�����', MB_YESNOCANCEl + MB_ICONQUESTION + MB_DEFBUTTON2);
            Case Confirmation Of
                mrYes:
                Begin
                    SaveOptionOnClick(Sender);
                    If IsSaved = SAVE Then
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
