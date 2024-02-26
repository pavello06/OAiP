unit Unit1;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Unit2, Unit3, Clipbrd,
  Vcl.ExtDlgs;

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
        EPSLabel: TLabel;
        EPSEdit: TEdit;
        XLabel: TLabel;
        XEdit: TEdit;
        ResultButton: TButton;
        ResultLabel: TLabel;
        ResultSinLabel: TLabel;
        ResultSinEdit: TEdit;
        ResultNLabel: TLabel;
        ResultNEdit: TEdit;
        SaveFile: TSaveTextFileDialog;
        OpenFile: TOpenTextFileDialog;
    N1: TMenuItem;
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
        Procedure OnChange(Sender: TObject);
        Procedure OnExit(Sender: TObject; Edit: TEdit);
        Procedure EPSOnClick(Sender: TObject);
        Procedure EPSOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure EPSOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure EPSOnKeyPress(Sender: TObject; Var Key: Char);
        Procedure EPSOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure EPSOnChange(Sender: TObject);
        Procedure EPSOnExit(Sender: TObject);
        Procedure XOnClick(Sender: TObject);
        Procedure XOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure XOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure XOnKeyPress(Sender: TObject; Var Key: Char);
        Procedure XOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure XOnChange(Sender: TObject);
        Procedure XOnExit(Sender: TObject);
        Procedure ResultButtonOnClick(Sender: TObject);
        procedure ResultNOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        Procedure ResultSinEditOnChange(Sender: TObject);
        procedure ResultSinOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        Procedure WriteFileData(Var F: TextFile; Sender: TObject);
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
    MIN_EPS = 0;
    MAX_EPS = 1;
    MIN_X = -1000;
    MAX_X = 1000;
Var
    Error: ERRORS_CODE;
    SNum: String;
Begin
    Reset(F);
    Error := ReadFileNum(F, SNum, MIN_EPS, MAX_EPS);
    If Error = CORRECT Then
    Begin
        EPSEdit.Text := SNum;
        Error := ReadFileNum(F, SNum, MIN_X, MAX_X);
    End;
    If Error = CORRECT Then
        XEdit.Text := SNum;
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
        Error := IsReadable(F);
        If Error = CORRECT Then
            Error := ReadFileData(Sender, F);
        If Error <> CORRECT Then
            Application.MessageBox(PWideChar(ERRORS[Error]), '������', MB_OK Or MB_ICONINFORMATION);
    End;
End;




Function IsBufferCorrect() : Boolean;
Var
    Num: Double;
Begin
    IsBufferCorrect := Clipboard.HasFormat(CF_TEXT) And TryStrToFloat(Clipboard.AsText, Num);
End;

Function IsPossiblePaste(Text: String; Const MIN, MAX: Integer) : Boolean;
Var
    Num: Double;
Begin
    IsPossiblePaste := IsBufferCorrect And TryStrToFloat(Text + ClipBoard.AsText, Num) And IsValidRange(Text + ClipBoard.AsText, MIN, MAX);
End;

Function TLab.CheckFields() : Boolean;
Var
    Num: Double;
Begin
    CheckFields := (TryStrToFloat(EPSEdit.Text, Num)) And (TryStrToFloat(XEdit.Text, Num));
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

Procedure TLab.OnChange(Sender: TObject);
Begin
    If CheckFields() Then
    Begin
        ResultSinEdit.Text := '';
        ResultNEdit.Text := '';
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

Procedure TLab.EPSOnClick(Sender: TObject);
Begin
    OnClick(Sender, EPSEdit);
End;

Procedure TLab.EPSOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Const
    MIN_EPS = 0;
    MAX_EPS = 1;
Begin
    OnContextPopup(Sender, MousePos, Handled, EPSEdit, MIN_EPS, MAX_EPS)
End;

Procedure TLab.EPSOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Const
    MIN_EPS = 0;
    MAX_EPS = 1;
Begin
    OnKeyDown(Sender, Key, Shift, EPSEdit, MIN_EPS, MAX_EPS);
End;

Procedure TLab.EPSOnKeyPress(Sender: TObject; Var Key: Char);
Const
    MIN_EPS = 0;
    MAX_EPS = 1;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If (Key <> BACKSPACE) And (Key <> ENTER) And Not CtrlPressed Then
    Begin
        OnClick(Sender, EPSEdit);
        IsValidInput := IsValidEditPositiveNum(EPSEdit.Text, Key);
        If IsValidInput Then
            IsValidInput := IsValidRange(EPSEdit.Text + Key, MIN_EPS, MAX_EPS);
    End;
    If Not IsValidInput Then
        Key := NONE;
End;

Procedure TLab.EPSOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    OnKeyUp(Sender, Key, Shift);
End;

Procedure TLab.EPSOnChange(Sender: TObject);
Begin
    OnChange(Sender);
End;

Procedure TLab.EPSOnExit(Sender: TObject);
Var
    Num: Double;
Begin
    OnExit(Sender, EPSEdit);
    If TryStrToFloat(EPSEdit.Text, Num) And (Num = 0) Then
    Begin
        EPSEdit.Text := '';
        ShowMessage('�������� EPS �� ����� ���� ����� 0!');
    End;
End;

Procedure TLab.XOnClick(Sender: TObject);
Begin
    OnClick(Sender, XEdit);
End;

Procedure TLab.XOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Const
    MIN_X = -1000;
    MAX_X = 1000;
Begin
    OnContextPopup(Sender, MousePos, Handled, XEdit, MIN_X, MAX_X)
End;

Procedure TLab.XOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Const
    MIN_X = -1000;
    MAX_X = 1000;
Begin
    OnKeyDown(Sender, Key, Shift, XEdit, MIN_X, MAX_X);
End;

Procedure TLab.XOnKeyPress(Sender: TObject; Var Key: Char);
Const
    MIN_X = -1000;
    MAX_X = 1000;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If (Key <> BACKSPACE) And (Key <> ENTER) And Not CtrlPressed Then
    Begin
        OnClick(Sender, XEdit);
        IsValidInput := IsValidEditNum(XEdit.Text, Key);
        If IsValidInput And (Key <> '-') Then
            IsValidInput := IsValidRange(XEdit.Text + Key, MIN_X, MAX_X);
    End;
    If Not IsValidInput Then
        Key := NONE;
End;

Procedure TLab.XOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    OnKeyUp(Sender, Key, Shift);
End;

Procedure TLab.XOnChange(Sender: TObject);
Begin
    OnChange(Sender);
End;

Procedure TLab.XOnExit(Sender: TObject);
Begin
    OnExit(Sender, XEdit);
End;


Function CalcSin(EPS, X: Real; Var N: Integer) : Real;
Var
    Member, Part, Sin: Real;
Begin
    N := 0;
    Sin := 0;
    Member := X * X;
    Part := -4 * X * X / 2;
    While (Abs(Member) > EPS) Do
    Begin
        Sin := Sin + Member;
        Inc(N);
        Part := Part / (2 * n * (2 * n - 1));
        Member := Member * Part;
    End;
    CalcSin := Sin;
End;

Procedure TLab.ResultButtonOnClick(Sender: TObject);
Var
    EPS, X, Sin: Real;
    N: Integer;
Begin
    EPS := StrToFloat(EPSEdit.Text);
    X := StrToFloat(XEdit.Text);
    Sin := CalcSin(EPS, X, N);
    ResultSinEdit.Text := FloatToStr(Sin);
    ResultNEdit.Text := FloatToStr(N);
End;


Var
    IsSaved: TSAVE = SAVE;

Procedure TLab.ResultSinEditOnChange(Sender: TObject);
Begin
    If ResultSinEdit.Text = '' Then
    Begin
        IsSaved := SAVE;
        SaveOption.Enabled := False;
        ResultSinEdit.Enabled := False;
        ResultNEdit.Enabled := False;
    End
    Else
    Begin
        IsSaved := UNSAVE;
        SaveOption.Enabled := True;
        ResultSinEdit.Enabled := True;
        ResultNEdit.Enabled := True;
    End;
End;

Procedure TLab.ResultSinOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    CheckControlButtons(Sender, ResultSinEdit, Key);
End;

Procedure TLab.ResultNOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Begin
    CheckControlButtons(Sender, ResultNEdit, Key);
End;


Procedure TLab.WriteFileData(Var F: TextFile; Sender: TObject);
Begin
    ReWrite(F);
    Write(F, 'Sin: ', ResultSinEdit.Text, '; n: ', ResultNEdit.Text);
    CloseFile(F);
End;

Procedure TLab.SaveOptionOnClick(Sender: TObject);
Var
    IsExist: Boolean;
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
