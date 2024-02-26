unit Unit1;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Unit2, Unit3, Clipbrd, Vcl.ExtDlgs;

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
        OpenFile: TOpenTextFileDialog;
        SaveFile: TSaveTextFileDialog;
        PNumLabel: TLabel;
        PNumEdit: TEdit;
        ResultButton: TButton;
        ResultLabel: TLabel;
        ResultEdit: TEdit;
    N1: TMenuItem;
        Procedure InstructionTabOnClick(Sender: TObject);
        Procedure DeveloperTabOnClick(Sender: TObject);

        Procedure CheckControlButtons(Sender: TObject; CurrentEdit: TEdit; Var Key: Word);

        Function ReadFileData(Sender: TObject; Var F: TextFile) : ERRORS_CODE;
        Procedure OpenOptionOnClick(Sender: TObject);

        Function CheckFields() : Boolean;
        Procedure OnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean; Edit: TEdit; Const MIN, MAX: Integer);
        Procedure OnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState; Edit: TEdit; Const MIN, MAX: Integer);
        Procedure OnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure OnChange(Sender: TObject);

        Procedure PNumEditOnChange(Sender: TObject);
        Procedure PNumEditOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure PNumEditOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure PNumEditOnKeyPress(Sender: TObject; Var Key: Char);
        Procedure PNumEditOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);

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
    CONTROL = [VK_UP, VK_DOWN];
    ENTER = #13;
    BACKSPACE = #8;
    DELETE = VK_DELETE;
    NONE = #0;
    ERRORS: Array [ERRORS_CODE] Of String = ( '',
                                              'Неправильное число в файле!',
                                              'Неправильный диапазон!',
                                              'Неправильное число строк в файле!',
                                              'Файл закрыт для чтения!',
                                              'Файл закрыт для записи!');
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
    If Key = VK_UP Then
        SelectNext(CurrentEdit, False, True)
    Else If Key = VK_DOWN Then
        SelectNext(CurrentEdit, True, True);
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
    MIN_P = 1;
    MAX_P = 999999;
Var
    Error: ERRORS_CODE;
    SNum: String;
Begin
    Reset(F);
    Error := ReadFileNum(F, SNum, MIN_P, MAX_P);
    If Error = CORRECT Then
        PNumEdit.Text := SNum;
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
            Application.MessageBox(PWideChar(ERRORS[Error]), 'Ошибка', MB_OK Or MB_ICONINFORMATION);
    End;
End;


Function IsBufferCorrect() : Boolean;
Var
    Num: Integer;
Begin
    IsBufferCorrect := Clipboard.HasFormat(CF_TEXT) And (Length(ClipBoard.AsText) <> 0) And TryStrToInt(Clipboard.AsText, Num);
End;

Function IsPossiblePaste(Edit: TEdit; Const MIN, MAX: Integer) : Boolean;
Var
    Num: Integer;

Begin
    If (Edit.SelStart = 0) And (Length(ClipBoard.AsText) <> 0) And (ClipBoard.AsText[1] = '0') Then
        IsPossiblePaste := False
    Else
        IsPossiblePaste := IsBufferCorrect And
                       (Length(Edit.Text + ClipBoard.AsText) - Edit.SelLength < Edit.MaxLength + 1)

End;

Function TLab.CheckFields() : Boolean;
Begin
    CheckFields := PNumEdit.Text <> '';
End;

Function IsValidEditPositiveNum(Edit: TEdit; Key: Char) : Boolean;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If (Edit.SelStart = 0) And Not CharInSet(Key, DIGITS_WITHOUT_ZERO) Then
        IsValidInput := False
    Else If Not CharInSet(Key, DIGITS) Then
        IsValidInput := False;
    IsValidEditPositiveNum := IsValidInput;
End;

Procedure TLab.OnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean; Edit: TEdit; Const MIN, MAX: Integer);
Begin
    If Not IsPossiblePaste(Edit, MIN, MAX) Then
        Handled := True;
End;

Var
    CtrlPressed: Boolean;

Procedure TLab.OnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState; Edit: TEdit; Const MIN, MAX: Integer);
Begin
    If Key In CONTROL Then
        CheckControlButtons(Sender, Edit, Key)
    Else If (Chr(Key) = ENTER) And (Length(Edit.Text) <> 0) And CheckFields() Then
        ResultButtonOnClick(Sender)
    Else If Key = DELETE Then
        Key := Ord(NONE)
    Else If (Shift = [ssCtrl]) And (UpperCase(Chr(Key)) = 'V') Or (Shift = [ssShift]) And (Key = VK_INSERT) Then
    Begin
        If Not IsPossiblePaste(Edit, MIN, MAX) Then
            Key := Ord(NONE)
    End;
    If (Shift = [ssCtrl]) And CharInSet(Chr(Key), ALPHABET) Then
        CtrlPressed := True;
End;

Procedure TLab.OnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If (Shift = [ssCtrl]) Then
        CtrlPressed := False;
End;

Procedure TLab.OnChange(Sender: TObject);
Begin
    ResultEdit.Text := '';
    If CheckFields() Then
    Begin
        ResultButton.Enabled := True;
    End
    Else
        ResultButton.Enabled := False;
End;


Procedure TLab.PNumEditOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Const
    MIN_P = 1;
    MAX_P = 999999;
Begin
    OnContextPopup(Sender, MousePos, Handled, PNumEdit, MIN_P, MAX_P);
End;

Procedure TLab.PNumEditOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Const
    MIN_P = 1;
    MAX_P = 999999;
Begin
    OnKeyDown(Sender, Key, Shift, PNumEdit, MIN_P, MAX_P);
End;

Procedure TLab.PNumEditOnKeyPress(Sender: TObject; Var Key: Char);
Const
    MIN_P = 1;
    MAX_P = 999999;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If Key = BACKSPACE Then
    Begin
        If (PNumEdit.SelLength = 0) And (PNumEdit.SelStart = 1) And (Length(PNumEdit.Text) > 1) And (PNumEdit.Text[2] = '0') Then
            Key := NONE
        Else If (PNumEdit.SelLength > 0) And (PNumEdit.SelLength <> Length(PNumEdit.Text)) And (PNumEdit.SelStart = 0) And (PNumEdit.Text[PNumEdit.SelLength + 1] = '0') Then
            Key := NONE
    End
    Else If (Key <> ENTER) And Not CtrlPressed Then
        IsValidInput := IsValidEditPositiveNum(PNumEdit, Key);
    If Not IsValidInput Then
        Key := NONE;
End;

Procedure TLab.PNumEditOnKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    OnKeyUp(Sender, Key, Shift);
End;

Procedure TLab.PNumEditOnChange(Sender: TObject);
Begin
    OnChange(Sender);
End;


Var
    IsSaved: TSAVE = SAVE;

Function CalcSumOfNums(Num : Integer) : Integer;
Const
    DIGIT = 10;
Var
    Sum: Integer;
Begin
    Sum := 0;
    While (Num > 0) Do
    Begin
        Sum := Sum + Num Mod 10;
        Num := Num Div DIGIT;
    End;
    CalcSumOfNums := Sum;
End;

procedure TLab.ResultButtonOnClick(Sender: TObject);
Var
    Num, Sum: Integer;
begin
    Num := StrToInt(PNumEdit.Text);
    Sum := CalcSumOfNums(Num);
    ResultEdit.Text := IntToStr(Sum);
end;

procedure TLab.ResultEditOnChange(Sender: TObject);
begin
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
end;


Procedure TLab.WriteFileData(Var F: TextFile; Sender: TObject);
Begin
    ReWrite(F);
    Write(F, 'Сумма цифр: ', ResultEdit.Text);
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
        Confirmation := Application.MessageBox('Вы не сохранили файл, хотите ли сохранить?', 'Выход', MB_YESNOCANCEl + MB_ICONQUESTION + MB_DEFBUTTON2);
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
        Confirmation := Application.MessageBox('Вы действительно хотите выйти?', 'Выход', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
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
            Confirmation := Application.MessageBox('Вы не сохранили файл, хотите ли сохранить?', 'Выход', MB_YESNOCANCEl + MB_ICONQUESTION + MB_DEFBUTTON2);
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
            Confirmation := Application.MessageBox('Вы действительно хотите выйти?', 'Выход', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
            CanClose := Confirmation = IDYES;
        End;
    End;
End;

End.
