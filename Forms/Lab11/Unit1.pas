Unit Unit1;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Unit2, Unit3;

Type
    ERRORS_CODE = (CORRECT,
                   INCORRECT_RANGE,
                   INCORRECT_NUM,
                   INCORRECT_AMOUNT_LINES,
                   IS_NOT_READABLE,
                   IS_NOT_WRITEABLE);
    TSAVE = (SAVE, UNSAVE, PROBLEMSAVE);
    TLab11 = Class(TForm)
        Tabs: TMainMenu;
        FileTab: TMenuItem;
        OpenOption: TMenuItem;
        SaveOption: TMenuItem;
        ExitOption: TMenuItem;
        InstructionTab: TMenuItem;
        DeveloperTab: TMenuItem;
        Task: TLabel;
        EnterXLabel: TLabel;
        EnterYLabel: TLabel;
        EnterRLabel: TLabel;
        ResultButton: TButton;
        OpenFile: TOpenDialog;
        EnterXEdit: TEdit;
        EnterYEdit: TEdit;
        EnterREdit: TEdit;
        ResultEdit: TEdit;
    ResultLabel: TLabel;
    Procedure InstructionOnClick(Sender: TObject);
    Procedure DeveloperOnClick(Sender: TObject);
    Procedure ExitOnClick(Sender: TObject);
    Procedure ExitOnCloseQuery(Sender: TObject; Var CanClose: Boolean);
    Function ReadFileData(Var F: TextFile; Sender: TObject) : ERRORS_CODE;
    Procedure OpenOnClick(Sender: TObject);
    Procedure CheckHelpButtons(Sender: TObject; CurrentEdit: TEdit; Var Key: Word; Shift: TShiftState);
    Procedure XOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure YOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure ROnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure XOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
    Procedure YOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
    Procedure ROnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
    Procedure XOnClick(Sender: TObject);
    Procedure YOnClick(Sender: TObject);
    Procedure ROnClick(Sender: TObject);
    Procedure XOnKeyPress(Sender: TObject; Var Key: Char);
    Procedure YOnKeyPress(Sender: TObject; Var Key: Char);
    Procedure ROnKeyPress(Sender: TObject; Var Key: Char);
    Procedure CheckFields();
    Procedure XOnChange(Sender: TObject);
    Procedure YOnChange(Sender: TObject);
    Procedure ROnChange(Sender: TObject);
    procedure XOnExit(Sender: TObject);
    procedure YOnExit(Sender: TObject);
    procedure ROnExit(Sender: TObject);
    Procedure ResultButtonOnClick(Sender: TObject);
    Procedure ResultOnChange(Sender: TObject);
    Procedure WriteFileData(Var F: TextFile; Sender: TObject);
    Procedure SaveOnClick(Sender: TObject);
    procedure ResultOnKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    Lab11: TLab11;

Implementation

{$R *.dfm}


Procedure TLab11.InstructionOnClick(Sender: TObject);
Var
    InstructionForm: TInstructionForm;
Begin
    InstructionForm := TInstructionForm.Create(Self);
    InstructionForm.Icon := Lab11.Icon;
    InstructionForm.ShowModal;
    InstructionForm.Free;
End;
 
Procedure TLab11.DeveloperOnClick(Sender: TObject);
Var
    DeveloperForm: TDeveloperForm;
Begin
    DeveloperForm := TDeveloperForm.Create(Self);
    DeveloperForm.Icon := Lab11.Icon;
    DeveloperForm.ShowModal;
    DeveloperForm.Free;
End;

Var
    PerformCloseQuery: Boolean = True;
    IsSaved: TSAVE = SAVE;

Procedure TLab11.ExitOnClick(Sender: TObject);
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
                SaveOnClick(Sender);
                If IsSaved = SAVE Then
                    Close
                Else
                    ExitOnClick(Sender);
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

Procedure TLab11.ExitOnCloseQuery(Sender: TObject; Var CanClose: Boolean);
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
                    SaveOnClick(Sender);
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

Const
    ERRORS: Array [ERRORS_CODE] Of String = ( '',
                                              'Значение не попадает в диапазон!',
                                              'Введено не число!',
                                              'Неправильное число строк в файле!',
                                              'Файл закрыт для чтения!',
                                              'Файл закрыт для записи!');

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

Function IsValidFileAmountLines(StreamReader: TStringList) : ERRORS_CODE;
Const
    MAX_LINE = 3;
Var
    Error: ERRORS_CODE;
    I: Integer;
Begin
    I := 1;
    Error := CORRECT;
    While (Error = CORRECT) And (I <= StreamReader.Count) Do
    Begin
        If I > MAX_LINE Then
            Error := INCORRECT_AMOUNT_LINES;
        Inc(I);
    End;
    If (Error = CORRECT) And (I - 1 <> MAX_LINE) Then
        Error := INCORRECT_AMOUNT_LINES;
    IsValidFileAmountLines := Error;
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

Function TLab11.ReadFileData(Var F: TextFile; Sender: TObject) : ERRORS_CODE;
Const
    MIN_R = 0;
    MAX_R = 50000;
    MIN_COOR = -30000;
    MAX_COOR = 30000;
Var
    Error: ERRORS_CODE;
    SNum: String;
Begin
    Reset(F);
    Error := ReadFileNum(F, SNum, MIN_COOR, MAX_COOR);
    If Error = CORRECT Then
    Begin
        EnterXEdit.Text := SNum;
        Error := ReadFileNum(F, SNum, MIN_COOR, MAX_COOR);
    End;
    If Error = CORRECT Then
    Begin
        EnterYEdit.Text := SNum;
        Error := ReadFileNum(F, SNum, MIN_COOR, MAX_COOR);
    End;
    If Error = CORRECT Then
        EnterREdit.Text := SNum;
    If (Error = CORRECT) And Not EOF(F) Then
        Error := INCORRECT_AMOUNT_LINES;
    CloseFile(F);
    ReadFileData := Error;
End;

Procedure TLab11.OpenOnClick(Sender: TObject);
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
            Error := ReadFileData(F, Sender);
        If Error <> CORRECT Then
            Application.MessageBox(PWideChar(ERRORS[Error]), 'Ошибка', MB_OK Or MB_ICONINFORMATION);
    End;
End;


Const
    DIGITS = ['0'..'9'];
    BACKSPACE = #8;
    NONE = #0;

Function IsValidEditInputNum(Text: String; Key: Char) : Boolean;
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
    IsValidEditInputNum := IsValidInput;
End;

Function IsValidEditInputPositiveNum(Text: String; Key: Char) : Boolean;
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
    IsValidEditInputPositiveNum := IsValidInput;
End;

Function IsValidEditRange(Text: String; Key: Char; Const MIN, MAX: Integer) : Boolean;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := True;
    If (Key <> BACKSPACE) And CharInSet(Key, DIGITS) Then
        IsValidInput := IsValidRange(Text + Key, MIN, MAX);
    IsValidEditRange := IsValidInput;
End;

Function IsValidEditCoor(Text: String; Key: Char) : Boolean;
Const
    MIN_COOR = -30000;
    MAX_COOR = 30000;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := IsValidEditInputNum(Text, Key);
    If IsValidInput Then
        IsValidInput := IsValidEditRange(Text, Key, MIN_COOR, MAX_COOR);
    IsValidEditCoor := IsValidInput;
End;

Function IsValidEditRadius(Text: String; Key: Char) : Boolean;
Const    
    MIN_R = 0;
    MAX_R = 50000;
Var
    IsValidInput: Boolean;
Begin
    IsValidInput := IsValidEditInputPositiveNum(Text, Key);
    If IsValidInput Then
        IsValidInput := IsValidEditRange(Text, Key, MIN_R, MAX_R);
    IsValidEditRadius := IsValidInput;
End;

Procedure TLab11.CheckHelpButtons(Sender: TObject; CurrentEdit: TEdit; Var Key: Word; Shift: TShiftState);
Begin
    If (ssCtrl In Shift) Or (ssShift In Shift) Then
        Key := 0;
    If (Key = VK_LEFT) Or (Key = VK_UP) Then
        SelectNext(CurrentEdit, False, True)
    Else If (Key = VK_RIGHT) Or (Key = VK_DOWN) Then
        SelectNext(CurrentEdit, True, True);
End;

Procedure TLab11.XOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    CheckHelpButtons(Sender, EnterXEdit, Key, Shift);
End;

Procedure TLab11.XOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Begin
    Handled := True;
End;

Procedure TLab11.XOnClick(Sender: TObject);
Begin
    If EnterXEdit.SelStart <> Length(EnterXEdit.Text) Then
        EnterXEdit.SelStart := Length(EnterXEdit.Text);
End;

Procedure TLab11.XOnKeyPress(Sender: TObject; Var Key: Char);
Var
    Text: String;
    IsValidInput: Boolean;
Begin
    Text := EnterXEdit.Text;
    IsValidInput := IsValidEditCoor(Text, Key);
    If Not IsValidInput Then
        Key := NONE;
End;

Procedure TLab11.YOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    CheckHelpButtons(Sender, EnterYEdit, Key, Shift);
End;

Procedure TLab11.YOnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Begin
    Handled := True;
End;

Procedure TLab11.YOnClick(Sender: TObject);
Begin
    If EnterYEdit.SelStart <> Length(EnterYEdit.Text) Then
        EnterYEdit.SelStart := Length(EnterYEdit.Text);
End;

Procedure TLab11.YOnKeyPress(Sender: TObject; Var Key: Char);
Var
    Text: String;
    IsValidInput: Boolean;
Begin
    Text := EnterYEdit.Text;
    IsValidInput := IsValidEditCoor(Text, Key);
    If Not IsValidInput Then
        Key := NONE;
End;

Procedure TLab11.ROnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    CheckHelpButtons(Sender, EnterREdit, Key, Shift);
End;

Procedure TLab11.ROnContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Begin
    Handled := True;
End;

Procedure TLab11.ROnClick(Sender: TObject);
Begin
    If EnterREdit.SelStart <> Length(EnterREdit.Text) Then
        EnterREdit.SelStart := Length(EnterREdit.Text);
End;

Procedure TLab11.ROnKeyPress(Sender: TObject; Var Key: Char);
Var
    Text: String;
    IsValidInput: Boolean;
Begin
    Text := EnterREdit.Text;
    IsValidInput := IsValidEditRadius(Text, Key);
    If Not IsValidInput Then
        Key := NONE;
End;


Procedure TLab11.CheckFields();
Var
    Num: Double;
Begin
    If (TryStrToFloat(EnterXEdit.Text, Num)) And
       (TryStrToFloat(EnterYEdit.Text, Num)) And
       (TryStrToFloat(EnterREdit.Text, Num)) Then
        ResultButton.Enabled := True
    Else
        ResultButton.Enabled := False;
End;

Procedure TLab11.XOnChange(Sender: TObject);
Begin
    CheckFields();
    ResultEdit.Text := '';
End;

Procedure TLab11.XOnExit(Sender: TObject);
Var
    Num: Double;
Begin
    If TryStrToFloat(EnterXEdit.Text, Num) And (Num = 0) Then
    Begin
        EnterXEdit.Text := '0';
    End;
    If (Length(EnterXEdit.Text) > 1) And (EnterXEdit.Text[Length(EnterXEdit.Text)] = ',') Then
        EnterXEdit.Text := EnterXEdit.Text + '0';
End;

Procedure TLab11.YOnChange(Sender: TObject);
Begin
    CheckFields();
    ResultEdit.Text := '';
End;

Procedure TLab11.YOnExit(Sender: TObject);
Var
    Num: Double;
Begin
    If TryStrToFloat(EnterYEdit.Text, Num) And (Num = 0) Then
    Begin
        EnterYEdit.Text := '0';
    End;
    If (Length(EnterYEdit.Text) > 1) And (EnterYEdit.Text[Length(EnterYEdit.Text)] = ',') Then
        EnterYEdit.Text := EnterYEdit.Text + '0';
End;

Procedure TLab11.ROnChange(Sender: TObject);
Var
    Num: Double;
Begin
    CheckFields();
    If TryStrToFloat(EnterREdit.Text, Num) And (Num = 0) Then
        ResultButton.Enabled := False;
    ResultEdit.Text := '';
End;

Procedure TLab11.ROnExit(Sender: TObject);
Var
    Num: Double;
Begin
    If TryStrToFloat(EnterREdit.Text, Num) And (Num = 0) Then
    Begin
        EnterREdit.Text := '';
        ShowMessage('Значение радиуса не может быть равно 0!');
    End;
    If (Length(EnterREdit.Text) > 1) And (EnterREdit.Text[Length(EnterREdit.Text)] = ',') Then
        EnterREdit.Text := EnterREdit.Text + '0';
End;

Procedure TLab11.ResultButtonOnClick(Sender: TObject);
Const
    EPS = 0.00001;
Var
    X, Y, R: Real;
Begin
    X := Round(StrToFloat(EnterXEdit.Text) * 1000) / 1000;
    Y := Round(StrToFloat(EnterYEdit.Text) * 1000) / 1000;
    R := Round(StrToFloat(EnterREdit.Text) * 1000) / 1000;
    If (Abs(R * R - (X * X + Y * Y)) < EPS) Then
        ResultEdit.Text := 'Точка принадлежит окружности.'
    Else
        ResultEdit.Text := 'Точка не принадлежит окружности.';
End;

Procedure TLab11.ResultOnChange(Sender: TObject);
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

procedure TLab11.ResultOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    If (Key = VK_LEFT) Or (Key = VK_UP) Then
        SelectNext(ResultEdit, False, True)
    Else If (Key = VK_RIGHT) Or (Key = VK_DOWN) Then
        SelectNext(ResultEdit, True, True);
end;

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

Procedure TLab11.WriteFileData(Var F: TextFile; Sender: TObject);
Begin
    Append(F);
    Write(F, ResultEdit.Text);
    CloseFile(F);
End;

Procedure TLab11.SaveOnClick(Sender: TObject);
Var
    Error: ERRORS_CODE;
    F: TextFile;
    FileName: String;
Begin
    If OpenFile.Execute Then
    Begin
        FileName := OpenFile.FileName;
        FileName := OpenFile.FileName;
        AssignFile(F, FileName);
        Error := IsWriteable(F);
        If Error = CORRECT Then
        Begin
            WriteFileData(F, Sender);
            IsSaved := SAVE;
        End;
        If Error <> CORRECT Then
        Begin
            Application.MessageBox(PWideChar(ERRORS[Error]), 'Ошибка', MB_OK Or MB_ICONINFORMATION);
            IsSaved := UNSAVE;
        End;
    End;
End;

End.
