unit Unit1;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Unit2, Unit3, Clipbrd, Vcl.ExtDlgs,
  Vcl.Grids;

Type
    ERRORS_CODE = (CORRECT,
                   INCORRECT_NUM,
                   INCORRECT_RANGE,
                   INCORRECT_AMOUNT_LINES,
                   IS_NOT_READABLE,
                   IS_NOT_WRITEABLE);
    TSAVE = (SAVE, UNSAVE);
    TArr = Array Of Real;
    TLab = Class(TForm)
        Tabs: TMainMenu;
        FileTab: TMenuItem;
        InstructionTab: TMenuItem;
        DeveloperTab: TMenuItem;
        OpenOption: TMenuItem;
        SaveOption: TMenuItem;
        ResultButton: TButton;
        ExitOption: TMenuItem;
        TaskLabel: TLabel;
        OpenFile: TOpenTextFileDialog;
        SaveFile: TSaveTextFileDialog;
        CoofALabel: TLabel;
        CoofAEdit: TEdit;
        CoofBLabel: TLabel;
        CoofBEdit: TEdit;
        CoofCLabel: TLabel;
        CoofCEdit: TEdit;
        StartXLabel: TLabel;
        StartXEdit: TEdit;
        EndXLabel: TLabel;
        EndXEdit: TEdit;
        StepLabel: TLabel;
        StepEdit: TEdit;
        SeparatedLine: TMenuItem;
        ArrsXYStringGrid: TStringGrid;
        procedure FormOnCreate(Sender: TObject);
        Procedure InstructionTabOnClick(Sender: TObject);
        Procedure DeveloperTabOnClick(Sender: TObject);

        Procedure CheckControlButtons(Sender: TObject; CurrentEdit: TEdit; Var Key: Word);

        Function ReadFileData(Sender: TObject; Var F: TextFile) : ERRORS_CODE;
        Procedure OpenOptionOnClick(Sender: TObject);

        Function CheckFields() : Boolean;
        Procedure OnClick(Sender: TObject; Edit: TEdit);
        Procedure OnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean; Edit: TEdit; Const MIN, MAX: Integer);
        Procedure OnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState; Edit: TEdit; Const MIN, MAX: Integer);
        Procedure OnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure ClearStringGrid(Sender: TObject);
        Procedure OnChange(Sender: TObject);
        Procedure OnExit(Sender: TObject; Edit: TEdit);

        Procedure CoofAOnChange(Sender: TObject);
        Procedure CoofAOnClick(Sender: TObject);
        Procedure CoofAOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure CoofAOnExit(Sender: TObject);
        Procedure CoofAOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure CoofAOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure CoofAOnKeyPress(Sender: TObject; Var Key: Char);

        Procedure CoofBOnChange(Sender: TObject);
        Procedure CoofBOnClick(Sender: TObject);
        Procedure CoofBOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure CoofBOnExit(Sender: TObject);
        Procedure CoofBOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure CoofBOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure CoofBOnKeyPress(Sender: TObject; Var Key: Char);

        Procedure CoofCOnChange(Sender: TObject);
        Procedure CoofCOnClick(Sender: TObject);
        Procedure CoofCOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure CoofCOnExit(Sender: TObject);
        Procedure CoofCOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure CoofCOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure CoofCOnKeyPress(Sender: TObject; Var Key: Char);

        Procedure StartXOnChange(Sender: TObject);
        Procedure StartXOnClick(Sender: TObject);
        Procedure StartXOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure StartXOnExit(Sender: TObject);
        Procedure StartXOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure StartXOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure StartXOnKeyPress(Sender: TObject; Var Key: Char);

        Procedure EndXOnChange(Sender: TObject);
        Procedure EndXOnClick(Sender: TObject);
        Procedure EndXOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure EndXOnExit(Sender: TObject);
        Procedure EndXOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure EndXOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure EndXOnKeyPress(Sender: TObject; Var Key: Char);

        Procedure StepOnChange(Sender: TObject);
        Procedure StepOnClick(Sender: TObject);
        Procedure StepOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure StepOnExit(Sender: TObject);
        Procedure StepOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure StepOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure StepOnKeyPress(Sender: TObject; Var Key: Char);

        Procedure WriteAnswer(Sender: TObject; ArrX: TArr; ArrY: TArr);
        Procedure ResultButtonOnClick(Sender: TObject);

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
var
    Lab: TLab;

implementation

{$R *.dfm}

procedure TLab.FormOnCreate(Sender: TObject);
begin
    ArrsXYStringGrid.Cells[0, 0] := 'X';
    ArrsXYStringGrid.Cells[0, 1] := 'Y';
end;

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
    Num: Real;
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    Num := StrToFloat(Str);
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
    Num: Double;
Begin
    Error := CORRECT;
    If Not TryStrToFloat(Str, Num) Then
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
    MIN_COOF_AND_X = -1000;
    MAX_COOF_AND_X = 1000;
    MIN_STEP = 0;
    MAX_STEP = 1000;
Var
    Error: ERRORS_CODE;
    SNum: String;
Begin
    Reset(F);
    Error := ReadFileNum(F, SNum, MIN_COOF_AND_X, MAX_COOF_AND_X);
    If Error = CORRECT Then
    Begin
        CoofAEdit.Text := SNum;
        Error := ReadFileNum(F, SNum, MIN_COOF_AND_X, MAX_COOF_AND_X);
    End;
    If Error = CORRECT Then
    Begin
        CoofBEdit.Text := SNum;
        Error := ReadFileNum(F, SNum, MIN_COOF_AND_X, MAX_COOF_AND_X);
    End;
    If Error = CORRECT Then
    Begin
        CoofCEdit.Text := SNum;
        Error := ReadFileNum(F, SNum, MIN_COOF_AND_X, MAX_COOF_AND_X);
    End;
    If Error = CORRECT Then
    Begin
        StartXEdit.Text := SNum;
        Error := ReadFileNum(F, SNum, MIN_COOF_AND_X, MAX_COOF_AND_X);
    End;
    If Error = CORRECT Then
    Begin
        EndXEdit.Text := SNum;
        Error := ReadFileNum(F, SNum, MIN_STEP, MAX_STEP);
    End;
    If Error = CORRECT Then
        StepEdit.Text := SNum;
    If Not EOF(F) Then
        Error := INCORRECT_AMOUNT_LINES;
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
        Error := ReadFileData(Sender, F);
        If Error <> CORRECT Then
            Application.MessageBox(PWideChar(ERRORS[Error]), '������', MB_OK Or MB_ICONINFORMATION);
    End;
End;


Function IsPossiblePaste(Text: String; Const MIN, MAX: Integer) : Boolean;
Var
    Num: Double;
Begin
    IsPossiblePaste := Clipboard.HasFormat(CF_TEXT) And TryStrToFloat(Text + ClipBoard.AsText, Num) And IsValidRange(Text + ClipBoard.AsText, MIN, MAX);
End;

Function TLab.CheckFields() : Boolean;
Var
    Num: Double;
Begin
    CheckFields := TryStrToFloat(CoofAEdit.Text, Num) And
                   TryStrToFloat(CoofBEdit.Text, Num) And
                   TryStrToFloat(CoofCEdit.Text, Num) And
                   TryStrToFloat(StartXEdit.Text, Num) And
                   TryStrToFloat(EndXEdit.Text, Num) And
                   TryStrToFloat(StepEdit.Text, Num);
End;

Function IsValidEditNum(Text: String; Key: Char) : Boolean;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If (Length(Text) = 0) And (Key = '-') Then
        IsValidInput := True
    Else If (Length(Text) = 1) And (Text[1] = '0') And (Key <> ',') And (Key <> BACKSPACE) Then
        IsValidInput := False
    Else If (Length(Text) = 2) And (Text[1] = '-') And (Text[2] = '0')  And (Key <> ',') And (Key <> BACKSPACE) Then
        IsValidInput := False
    Else
    Begin
        If Key = ',' Then
        Begin
            If (Length(Text) = 0) Or (Pos(',', Text) > 0) Then
                IsValidInput := False
            Else If (Text[1] = '-') And ((Length(Text) < 2) Or (Pos(',', Text) > 0)) Then
                IsValidInput := False;
        End
        Else If Not CharInSet(Key, DIGITS) And (Key <> BACKSPACE) Then
            IsValidInput := False;
    End;
    IsValidEditNum := IsValidInput;
End;

Function IsValidEditPositiveNum(Text: String; Key: Char) : Boolean;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If (Length(Text) = 1) And (Text[1] = '0') And (Key <> ',') And (Key <> BACKSPACE) Then
        IsValidInput := False
    Else If Key = ',' Then
    Begin
        If (Length(Text) = 0) Or (Pos(',', Text) > 0) Then
            IsValidInput := False;
    End
    Else If Not CharInSet(Key, DIGITS) And (Key <> BACKSPACE) Then
        IsValidInput := False;
    IsValidEditPositiveNum := IsValidInput;
End;


Procedure TLab.OnClick(Sender: TObject; Edit: TEdit);
Begin
    If Edit.SelStart <> Length(Edit.Text) Then
        Edit.SelStart := Length(Edit.Text);
End;

Procedure TLab.OnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean; Edit: TEdit; Const MIN, MAX: Integer);
Begin
    If Not IsPossiblePaste(Edit.Text, MIN, MAX) Then
        Handled := True;
End;

Var
    CtrlPressed: Boolean;
    IsSaved: TSAVE = SAVE;

Procedure TLab.OnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState; Edit: TEdit; Const MIN, MAX: Integer);
Begin
    If Key In CONTROL Then
        CheckControlButtons(Sender, Edit, Key)
    Else If (Key = Ord(ENTER)) And (Length(Edit.Text) <> 0) And CheckFields() Then
        ResultButtonOnClick(Sender)
    Else If (Shift = [ssCtrl]) And ((Key = Ord('V')) Or (Key = Ord('v'))) Or (Shift = [ssShift]) And (Key = VK_INSERT) Then
        If IsPossiblePaste(Edit.Text, MIN, MAX) Then
        Begin
            If StrToFloat(Edit.Text + Clipboard.AsText) = 0 Then
                Edit.Text := '';
        End
        Else
            Key := Ord(NONE);
    If (Shift = [ssCtrl]) And ((Key In [Ord('A')..Ord('Z')]) Or (Key In [Ord('a')..Ord('z')])) Then
        CtrlPressed := True;
End;

Procedure TLab.OnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If (Shift = [ssCtrl]) Then
        CtrlPressed := False;
End;

Procedure TLab.ClearStringGrid(Sender: TObject);
Const
    StartCount = 8;
    StartHeigth = 66;
Var
    I: Integer;
Begin
    ArrsXYStringGrid.ColCount := StartCount;
    ArrsXYStringGrid.Height := StartHeigth;
    For I := 1 To StartCount Do
    Begin
        ArrsXYStringGrid.Cells[I, 0] := '';
        ArrsXYStringGrid.Cells[I, 1] := '';
    End;
End;

Procedure TLab.OnChange(Sender: TObject);
Begin
    IsSaved := SAVE;
    SaveOption.Enabled := False;
    ClearStringGrid(Sender);
    ArrsXYStringGrid.Enabled := False;
    If CheckFields() Then
    Begin
        ResultButton.Enabled := True;
    End
    Else
        ResultButton.Enabled := False;
End;

Procedure TLab.OnExit(Sender: TObject; Edit: TEdit);
Var
    Num: Double;
Begin
    If (Length(Edit.Text) > 1) And (Edit.Text[Length(Edit.Text)] = ',') Then
        Edit.Text := Edit.Text + '0';
    If TryStrToFloat(Edit.Text, Num) And (Num = 0) Then
    Begin
        Edit.Text := '0';
    End;
End;


procedure TLab.CoofAOnClick(Sender: TObject);
begin
    OnClick(Sender, CoofAEdit);
end;

Procedure TLab.CoofAOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Const
    MIN_A = -1000;
    MAX_A = 1000;
Begin
    OnContextPopup(Sender, MousePos, Handled, CoofAEdit, MIN_A, MAX_A);
End;

Procedure TLab.CoofAOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Const
    MIN_A = -1000;
    MAX_A = 1000;
Begin
    OnKeyDown(Sender, Key, Shift, CoofAEdit, MIN_A, MAX_A);
End;

Procedure TLab.CoofAOnKeyPress(Sender: TObject; Var Key: Char);
Const
    MIN_A = -1000;
    MAX_A = 1000;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If (Key <> BACKSPACE) And (Key <> ENTER) And Not CtrlPressed Then
    Begin
        OnClick(Sender, CoofAEdit);
        IsValidInput := IsValidEditNum(CoofAEdit.Text, Key);
        If IsValidInput And (Key <> '-') Then
            IsValidInput := IsValidRange(CoofAEdit.Text + Key, MIN_A, MAX_A);
    End;
    If Not IsValidInput Then
        Key := NONE;
End;

Procedure TLab.CoofAOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    OnKeyUp(Sender, Key, Shift);
End;

Procedure TLab.CoofAOnChange(Sender: TObject);
Begin
    OnChange(Sender);
End;

Procedure TLab.CoofAOnExit(Sender: TObject);
Begin
    OnExit(Sender, CoofAEdit);
End;

procedure TLab.CoofBOnClick(Sender: TObject);
begin
    OnClick(Sender, CoofBEdit);
end;

Procedure TLab.CoofBOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Const
    MIN_B = -1000;
    MAX_B = 1000;
Begin
    OnContextPopup(Sender, MousePos, Handled, CoofBEdit, MIN_B, MAX_B);
End;

Procedure TLab.CoofBOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Const
    MIN_B = -1000;
    MAX_B = 1000;
Begin
    OnKeyDown(Sender, Key, Shift, CoofBEdit, MIN_B, MAX_B);
End;

Procedure TLab.CoofBOnKeyPress(Sender: TObject; Var Key: Char);
Const
    MIN_B = -1000;
    MAX_B = 1000;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If (Key <> BACKSPACE) And (Key <> ENTER) And Not CtrlPressed Then
    Begin
        OnClick(Sender, CoofBEdit);
        IsValidInput := IsValidEditNum(CoofBEdit.Text, Key);
        If IsValidInput And (Key <> '-') Then
            IsValidInput := IsValidRange(CoofBEdit.Text + Key, MIN_B, MAX_B);
    End;
    If Not IsValidInput Then
        Key := NONE;
End;

Procedure TLab.CoofBOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    OnKeyUp(Sender, Key, Shift);
End;

Procedure TLab.CoofBOnChange(Sender: TObject);
Begin
    OnChange(Sender);
End;

Procedure TLab.CoofBOnExit(Sender: TObject);
Begin
    OnExit(Sender, CoofBEdit);
End;

procedure TLab.CoofCOnClick(Sender: TObject);
begin
    OnClick(Sender, CoofCEdit);
end;

Procedure TLab.CoofCOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Const
    MIN_C = -1000;
    MAX_C = 1000;
Begin
    OnContextPopup(Sender, MousePos, Handled, CoofCEdit, MIN_C, MAX_C);
End;

Procedure TLab.CoofCOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Const
    MIN_C = -1000;
    MAX_C = 1000;
Begin
    OnKeyDown(Sender, Key, Shift, CoofCEdit, MIN_C, MAX_C);
End;

Procedure TLab.CoofCOnKeyPress(Sender: TObject; Var Key: Char);
Const
    MIN_C = -1000;
    MAX_C = 1000;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If (Key <> BACKSPACE) And (Key <> ENTER) And Not CtrlPressed Then
    Begin
        OnClick(Sender, CoofCEdit);
        IsValidInput := IsValidEditNum(CoofCEdit.Text, Key);
        If IsValidInput And (Key <> '-') Then
            IsValidInput := IsValidRange(CoofCEdit.Text + Key, MIN_C, MAX_C);
    End;
    If Not IsValidInput Then
        Key := NONE;
End;

Procedure TLab.CoofCOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    OnKeyUp(Sender, Key, Shift);
End;

Procedure TLab.CoofCOnChange(Sender: TObject);
Begin
    OnChange(Sender);
End;

Procedure TLab.CoofCOnExit(Sender: TObject);
Begin
    OnExit(Sender, CoofCEdit);
End;

procedure TLab.StartXOnClick(Sender: TObject);
begin
    OnClick(Sender, StartXEdit);
end;

Procedure TLab.StartXOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Const
    MIN_X = -1000;
    MAX_X = 1000;
Begin
    OnContextPopup(Sender, MousePos, Handled, StartXEdit, MIN_X, MAX_X);
End;

Procedure TLab.StartXOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Const
    MIN_X = -1000;
    MAX_X = 1000;
Begin
    OnKeyDown(Sender, Key, Shift, StartXEdit, MIN_X, MAX_X);
End;

Procedure TLab.StartXOnKeyPress(Sender: TObject; Var Key: Char);
Const
    MIN_X = -1000;
    MAX_X = 1000;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If (Key <> BACKSPACE) And (Key <> ENTER) And Not CtrlPressed Then
    Begin
        OnClick(Sender, StartXEdit);
        IsValidInput := IsValidEditNum(StartXEdit.Text, Key);
        If IsValidInput And (Key <> '-') Then
            IsValidInput := IsValidRange(StartXEdit.Text + Key, MIN_X, MAX_X);
    End;
    If Not IsValidInput Then
        Key := NONE;
End;

Procedure TLab.StartXOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    OnKeyUp(Sender, Key, Shift);
End;

Procedure TLab.StartXOnChange(Sender: TObject);
Begin
    OnChange(Sender);
End;

Procedure TLab.StartXOnExit(Sender: TObject);
Begin
    OnExit(Sender, StartXEdit);
    If (Length(StartXEdit.Text) <> 0) And (Length(EndXEdit.Text) <> 0) And (StrToFloat(StartXEdit.Text) >= StrToFloat(EndXEdit.Text)) Then
    Begin
        StartXEdit.Text := '';
        ShowMessage('�������� x0 �� ����� ���� ������ ��� ����� xn!');
    End;
End;

procedure TLab.EndXOnClick(Sender: TObject);
begin
    OnClick(Sender, EndXEdit);
end;

Procedure TLab.EndXOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Const
    MIN_X = -1000;
    MAX_X = 1000;
Begin
    OnContextPopup(Sender, MousePos, Handled, EndXEdit, MIN_X, MAX_X);
End;

Procedure TLab.EndXOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Const
    MIN_X = -1000;
    MAX_X = 1000;
Begin
    OnKeyDown(Sender, Key, Shift, EndXEdit, MIN_X, MAX_X);
End;

Procedure TLab.EndXOnKeyPress(Sender: TObject; Var Key: Char);
Const
    MIN_X = -1000;
    MAX_X = 1000;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If (Key <> BACKSPACE) And (Key <> ENTER) And Not CtrlPressed Then
    Begin
        OnClick(Sender, EndXEdit);
        IsValidInput := IsValidEditNum(EndXEdit.Text, Key);
        If IsValidInput And (Key <> '-') Then
            IsValidInput := IsValidRange(EndXEdit.Text + Key, MIN_X, MAX_X);
    End;
    If Not IsValidInput Then
        Key := NONE;
End;

Procedure TLab.EndXOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    OnKeyUp(Sender, Key, Shift);
End;

Procedure TLab.EndXOnChange(Sender: TObject);
Begin
    OnChange(Sender);
End;

Procedure TLab.EndXOnExit(Sender: TObject);
Begin
    OnExit(Sender, EndXEdit);
    If (Length(StartXEdit.Text) <> 0) And (Length(EndXEdit.Text) <> 0) And (StrToFloat(StartXEdit.Text) >= StrToFloat(EndXEdit.Text)) Then
    Begin
        EndXEdit.Text := '';
        ShowMessage('�������� xn �� ����� ���� ������ x0!');
    End;
End;

procedure TLab.StepOnClick(Sender: TObject);
begin
    OnClick(Sender, StepEdit);
end;

Procedure TLab.StepOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Const
    MIN_STEP = 0;
    MAX_STEP = 1000;
Begin
    OnContextPopup(Sender, MousePos, Handled, CoofCEdit, MIN_STEP, MAX_STEP);
End;

Procedure TLab.StepOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Const
    MIN_STEP = 0;
    MAX_STEP = 1000;
Begin
    OnKeyDown(Sender, Key, Shift, StepEdit, MIN_STEP, MAX_STEP);
End;

Procedure TLab.StepOnKeyPress(Sender: TObject; Var Key: Char);
Const
    MIN_STEP = 0;
    MAX_STEP = 1000;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If (Key <> BACKSPACE) And (Key <> ENTER) And Not CtrlPressed Then
    Begin
        OnClick(Sender, StepEdit);
        IsValidInput := IsValidEditPositiveNum(StepEdit.Text, Key);
        If IsValidInput And (Key <> '-') Then
            IsValidInput := IsValidRange(StepEdit.Text + Key, MIN_STEP, MAX_STEP);
    End;
    If Not IsValidInput Then
        Key := NONE;
End;

Procedure TLab.StepOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    OnKeyUp(Sender, Key, Shift);
End;

Procedure TLab.StepOnChange(Sender: TObject);
Begin
    OnChange(Sender);
End;

Procedure TLab.StepOnExit(Sender: TObject);
Var
    Num: Double;
Begin
    OnExit(Sender, StepEdit);
    If TryStrToFloat(StepEdit.Text, Num) And (Num = 0) Then
    Begin
        StepEdit.Text := '';
        ShowMessage('�������� h �� ����� ���� ����� 0!');
    End;
End;


Procedure CalcArrsXY(CoofA, CoofB, CoofC, StartX, EndX, Step: Real; Var ArrX: TArr; Var ArrY: TArr);
Const
    EPS = 0.00000000001;
Var
    CurrX: Real;
    SizeOfArrs, I: Integer;
begin
    SizeOfArrs := Trunc((EndX - StartX) / Step + 1 + EPS);
    SetLength(ArrX, SizeOfArrs);
    SetLength(ArrY, SizeOfArrs);
    CurrX := StartX;
    For I := 0 To High(ArrX) Do
    Begin    
        ArrX[I] := CurrX;
        ArrY[I] := CoofA * CurrX * CurrX + CoofB * CurrX + CoofC;
        CurrX := CurrX + Step;
    End;
end;

Procedure TLab.WriteAnswer(Sender: TObject; ArrX: TArr; ArrY: TArr);
Var
    I: Integer;
Begin
    If Length(ArrX) > 8 Then
    Begin
        ArrsXYStringGrid.ColCount := Length(ArrX) + 1;
        ArrsXYStringGrid.Height := 86;
    End;
    For I := 0 To High(ArrX) Do
    Begin
        ArrsXYStringGrid.Cells[I + 1, 0] := FloatToStr(ArrX[I]);
        ArrsXYStringGrid.Cells[I + 1, 1] := FloatToStr(ArrY[I]);
    End;
End;


procedure TLab.ResultButtonOnClick(Sender: TObject);
Var
    CoofA, CoofB, CoofC, StartX, EndX, Step: Real;
    ArrX, ArrY: TArr;
begin
    CoofA := StrToFloat(CoofAEdit.Text);
    CoofB := StrToFloat(CoofBEdit.Text);
    CoofC := StrToFloat(CoofCEdit.Text);
    StartX := StrToFloat(StartXEdit.Text);
    EndX := StrToFloat(EndXEdit.Text);
    Step := StrToFloat(StepEdit.Text);
    CalcArrsXY(CoofA, CoofB, CoofC, StartX, EndX, Step, ArrX, ArrY);
    WriteAnswer(Sender, ArrX, ArrY);
    IsSaved := UNSAVE;
    SaveOption.Enabled := True;
    ArrsXYStringGrid.Enabled := True;
end;


Procedure TLab.WriteFileData(Var F: TextFile; Sender: TObject);
Var
    I: Integer;
Begin
    ReWrite(F);
    Write(F, 'X: ');
    For I := 1 To ArrsXYStringGrid.ColCount Do
    Begin
        Write(F, ArrsXYStringGrid.Cells[I, 0], '; ');
    End;
    WriteLn(F);
    Write(F, 'Y: ');
    For I := 1 To ArrsXYStringGrid.ColCount Do
    Begin
        Write(F, ArrsXYStringGrid.Cells[I, 1], '; ');
    End;
    CloseFile(F);
End;

Procedure TLab.SaveOptionOnClick(Sender: TObject);
Var
    F: TextFile;
    FileName: String;
Begin
    If SaveFile.Execute Then
    Begin
        FileName := SaveFile.FileName;
        AssignFile(F, FileName);
        WriteFileData(F, Sender);
        IsSaved := SAVE;
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
