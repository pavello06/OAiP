unit Unit1;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Unit2, Unit3, Clipbrd, Vcl.ExtDlgs;

Type
    ERRORS_CODE = (CORRECT,
                   INCORRECT_AMOUNT_STR,
                   INCORRECT_LEN_STR);
    TChar = Array Of Char;
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
        Action1RadioButton: TRadioButton;
        Action2RadioButton: TRadioButton;
        Action3RadioButton: TRadioButton;
        String1Label: TLabel;
        String1Edit: TEdit;
        String2Label: TLabel;
        String2Edit: TEdit;
        ResultButton: TButton;
        ResultLabel: TLabel;
        ResultEdit: TEdit;
        Procedure InstructionTabOnClick(Sender: TObject);
        Procedure DeveloperTabOnClick(Sender: TObject);

        Function ReadFileData(Sender: TObject; Var F: TextFile) : ERRORS_CODE;
        Procedure OpenOptionOnClick(Sender: TObject);

        Function IsFullFields(Sender: TObject) : Boolean;

        Procedure ActionCheckButtonOnClick(Sender: TObject; NonActiveRadioButton1, NonActiveRadioButton2: TRadioButton);
        procedure Action1RadioButtonOnClick(Sender: TObject);
        procedure Action2RadioButtonOnClick(Sender: TObject);
        procedure Action3RadioButtonOnClick(Sender: TObject);

        procedure FieldsOnChange(Sender: TObject);

        procedure ResultButtonOnClick(Sender: TObject);

        Procedure WriteFileData(Sender: TObject; Var F: TextFile);
        Procedure SaveOptionOnClick(Sender: TObject);

        Procedure ExitOptionOnClick(Sender: TObject);
        Procedure ExitOnCloseQuery(Sender: TObject; Var CanClose: Boolean);
    procedure ResultEditOnChange(Sender: TObject);

    Private
      { Private declarations }
    Public
      { Public declarations }
    End;

Const
    ENTER = #13;
    BACKSPACE = #8;
    NONE = #0;
    ERRORS: Array [ERRORS_CODE] Of String = ('',
                                             '������������ ����� �����',
                                             '������������ ����� �����');
    FACTOR = 1.247;
    MIN_STR_LEN = 1;
    MAX_STR_LEN = 100;
var
    MainForm: TMainForm;
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

Function ReadString(Var F: TextFile; Var Str: String) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
Begin
    Error := CORRECT;
    If Not EOF(F) Then
        ReadLn(F, Str)
    Else
        Error := INCORRECT_AMOUNT_STR;
    If (Error = CORRECT) And ((Length(Str) < MIN_STR_LEN) Or (Length(Str) > MAX_STR_LEN)) Then
        Error := INCORRECT_LEN_STR;
    ReadString := Error;
End;

Function TMainForm.ReadFileData(Sender: TObject; Var F: TextFile) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
    Str: String;
Begin
    Reset(F);
    Error := ReadString(F, Str);
    If Error = CORRECT Then
    Begin
        String1Edit.Text := Str;
        Error := ReadString(F, Str);
    End;
    If Error = CORRECT Then
        String2Edit.Text := Str;
    If Not EOF(F) Then
        Error := INCORRECT_AMOUNT_STR;    
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
            String1Edit.Text := '';
            String2Edit.Text := '';
            Application.MessageBox(PWideChar(ERRORS[Error]), '������', MB_OK Or MB_ICONINFORMATION);
        End;
    End;
End;


Function TMainForm.IsFullFields(Sender: TObject) : Boolean;
Begin
    IsFullFields := (Action1RadioButton.Checked Or Action2RadioButton.Checked Or Action3RadioButton.Checked) And
                    (String1Edit.Text <> '') And (String2Edit.Text <> '');
End;


Procedure TMainForm.ActionCheckButtonOnClick(Sender: TObject; NonActiveRadioButton1, NonActiveRadioButton2: TRadioButton);
Begin
    NonActiveRadioButton1.Checked := False;
    NonActiveRadioButton2.Checked := False;
    FieldsOnChange(Sender);
End;

procedure TMainForm.Action1RadioButtonOnClick(Sender: TObject);
begin
    ActionCheckButtonOnClick(Sender, Action2RadioButton, Action3RadioButton);
end;

procedure TMainForm.Action2RadioButtonOnClick(Sender: TObject);
begin
    ActionCheckButtonOnClick(Sender, Action1RadioButton, Action3RadioButton);
end;

procedure TMainForm.Action3RadioButtonOnClick(Sender: TObject);
begin
    ActionCheckButtonOnClick(Sender, Action1RadioButton, Action2RadioButton);
end;


procedure TMainForm.FieldsOnChange(Sender: TObject);
begin
    ResultEdit.Text := '';
    If IsFullFields(Sender) Then
        ResultButton.Enabled := True
    Else
        ResultButton.Enabled := False;
end;


Procedure FillOneAStr(Str: String; Var AStr: TChar);
Var
    I: Integer;
Begin
    SetLength(AStr, Length(Str));
    For I := Low(AStr) To High(AStr) Do
        AStr[I] := Str[I + 1];
End;

Procedure FillAStrs(Str1: String; Str2: String; Var AStr1: TChar; Var AStr2: TChar);
Begin
    FillOneAStr(Str1, Astr1);
    FillOneAStr(Str2, Astr2);
End;

Procedure SortOneAStr(Var AStr: TChar);
Var
    Step: Real;
    I, IStep: Integer;
    Buf: Char;
Begin
    Step := Length(AStr) - 1;
    While Step >= 1 Do
    Begin
        IStep := Trunc(Step);
        I := 0;
        While Step + I < Length(AStr) Do
        Begin
            If Ord(AStr[I]) > Ord(AStr[I + IStep]) Then
            Begin
                Buf := AStr[I];
                AStr[I] := AStr[I + IStep];
                AStr[I + IStep] := Buf;
            End;
            Inc(I);
        End;
        Step := Step / FACTOR;
    End;
End;

Procedure SortAStrs(Var AStr1: TChar; Var AStr2: TChar);
Begin
    SortOneAStr(AStr1);
    SortOneAStr(AStr2);
End;

Function PlusAStr(Var CombAStr: TChar; AStr: TChar; J: Integer) : Integer;
Var
    I: Integer;
Begin
    I := 0;
    While I < High(AStr) Do
    Begin
        If AStr[I] <> AStr[I + 1] Then
        Begin
            CombAStr[J] := AStr[I];
            Inc(J);
        End;
        Inc(I);
    End;
    CombAStr[J] := AStr[High(AStr)];
    PlusAStr := J + 1;
End;

Procedure MakeCombSameAStr(Var CombAStr: TChar; AStr1: TChar; AStr2: TChar);
Var
    J: Integer;
Begin
    SetLength(CombAStr, Length(AStr1) + Length(AStr2));
    J := 0;
    J := PlusAStr(CombAStr, AStr1, J);
    J := PlusAStr(CombAStr, AStr2, J);
    SetLength(CombAStr, J);
End;

Procedure MakeCombUniqueAStr(Var CombAStr: TChar; AStr1: TChar; AStr2: TChar; AStr3: TChar);
Var
    J: Integer;
Begin
    SetLength(CombAStr, Length(AStr1) + Length(AStr2) + Length(AStr3));
    J := 0;
    J := PlusAStr(CombAStr, AStr1, J);
    J := PlusAStr(CombAStr, AStr2, J);
    J := PlusAStr(CombAStr, AStr3, J);
    SetLength(CombAStr, J);
End;

Procedure FindSame(CombAStr: TChar; Var ResAStr: TChar);
Var
    I, J: Integer;
Begin
    I := 0;
    J := 0;
    SetLength(ResAStr, Length(CombAStr));
    While I < High(CombAStr) Do
    Begin
        If CombAStr[I] = CombAStr[I + 1] Then
        Begin
            ResAStr[J] := CombAStr[I];
            Inc(J);
            Inc(I);
        End;
        Inc(I);
    End;
    If J = 0 Then
        SetLength(ResAStr, 1)
    Else
        SetLength(ResAStr, J);
End;

Procedure FindUnique(CombAStr: TChar; Var ResAStr: TChar);
Var
    I, J: Integer;
Begin
    I := 0;
    J := 0;
    SetLength(ResAStr, Length(CombAStr));
    While I < High(CombAStr) Do
    Begin
        If CombAStr[I] = CombAStr[I + 1] Then
            If (I = High(CombAStr) - 1) Or (CombAStr[I] <> CombAStr[I + 2]) Then
            Begin
                ResAStr[J] := CombAStr[I];
                Inc(J);
                Inc(I);
            End
            Else
                Inc(I, 2);
        Inc(I);
    End;
    If J = 0 Then
        SetLength(ResAStr, 1)
    Else
        SetLength(ResAStr, J);
End;

Procedure FindAnswer(Action: Integer; Str1, Str2: String; Var ResAstr: TChar);
Var
    AStr1, AStr2, CombAStr: TChar;
Begin
    FillAStrs(Str1, Str2, AStr1, AStr2);
    SortAStrs(AStr1, AStr2);
    If Action = 1 Then
    Begin
        MakeCombSameAStr(CombAStr, AStr1, AStr2);
        SortOneAStr(CombAStr);
        FindSame(CombAStr, ResAStr);
    End
    Else If Action = 2 Then
    Begin
        MakeCombUniqueAStr(CombAStr, AStr1, AStr2, AStr1);
        SortOneAStr(CombAStr);
        FindUnique(CombAStr, ResAStr);
    End
    Else
    Begin
        MakeCombUniqueAStr(CombAStr, AStr1, AStr2, AStr2);
        SortOneAStr(CombAStr);
        FindUnique(CombAStr, ResAStr);
    End;
End;

Procedure WriteWindowData(ResAstr: TChar; ResultEdit: TEdit);
Var
    I: Integer;
Begin
    If ResAStr[0] = #0 Then
        ResultEdit.Text := ResultEdit.Text + '���������, ��������������� �������, ���!'
    Else
        For I := 0 To High(ResAStr) Do
            ResultEdit.Text := ResultEdit.Text + '''' + ResAStr[I] + '''; ';
End;

procedure TMainForm.ResultButtonOnClick(Sender: TObject);
Var
    Action: Integer;
    Str1, Str2: String;
    ResAstr: TChar;
begin
    ResultEdit.Text := '';
    If Action1RadioButton.Checked Then
        Action := 1
    Else If Action2RadioButton.Checked Then
        Action := 2
    Else
        Action := 3;
    Str1 := String1Edit.Text;
    Str2 := String2Edit.Text;
    FindAnswer(Action, Str1, Str2, ResAstr);
    WriteWindowData(ResAstr, ResultEdit);
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


Procedure TMainForm.WriteFileData(Sender: TObject; Var F: TextFile);
Begin
    ReWrite(F);
    Write(F, '��������, ��������������� �������: ', ResultEdit.Text);
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
