Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Menus, Vcl.ExtDlgs, InstructionUnit, DeveloperUnit, AddUnit;

Type
    TMainForm = Class(TForm)
        TabsMainMenu: TMainMenu;
        FileMenuItem: TMenuItem;
        OpenMenuItem: TMenuItem;
        SaveMenuItem: TMenuItem;
        SeparatorMenuItem: TMenuItem;
        ExitMenuItem: TMenuItem;
        InstructionMenuItem: TMenuItem;
        DeveloperMenuItem: TMenuItem;

        SaveDialog: TSaveTextFileDialog;
        OpenDialog: TOpenTextFileDialog;

        AddButton: TButton;
        DeleteButton: TButton;
        ReverseButton: TButton;
        NumberStringGrid: TStringGrid;

        Procedure MainFormCreate(Sender: TObject);
        Function MainFormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;

        Procedure InstructionMenuItemClick(Sender: TObject);
        Procedure DeveloperMenuItemClick(Sender: TObject);

        Procedure OpenMenuItemClick(Sender: TObject);

        Procedure AddButtonClick(Sender: TObject);
        Procedure DeleteButtonClick(Sender: TObject);
        Procedure ReverseButtonClick(Sender: TObject);

        Procedure SaveMenuItemClick(Sender: TObject);

        Procedure ExitMenuItemClick(Sender: TObject);
        Procedure MainFormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Type
    ERRORS_CODE = (CORRECT,
                   INCORRECT_NUMBER,
                   EXTRA_DATA);
    TLimitedString = String[NUMBER_LENGTH];

Const
    ERRORS: Array [ERRORS_CODE] Of String = ( '',
                                              'Некорректный номер в файле!',
                                              'Количество номеров не превышает 100!');
    MAX_AMOUNT_NUMBERS = 100;
    NUMBER_LENGTH = 13;

Var
    MainForm: TMainForm;
    IsEdited: Boolean = False;
    IsSaved: Boolean = True;

Implementation

{$R *.dfm}

Procedure Make(); Stdcall; External 'LinkedList.dll';

Procedure Add(Data: TLimitedString); Stdcall; External 'LinkedList.dll';

Procedure Remove(Number: Integer); Stdcall; External 'LinkedList.dll';

Procedure Reverse(); Stdcall; External 'LinkedList.dll';

Procedure Clear(); Stdcall; External 'LinkedList.dll';

Procedure WriteLinkedList(StringGrid: TStringGrid); External 'LinkedList.dll';



Procedure TMainForm.MainFormCreate(Sender: TObject);
Begin
    Make();
    NumberStringGrid.Cells[0, 0] := 'Список номеров';
End;

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



Procedure DrawStringGrid(StringGrid: TStringGrid);
Begin
    StringGrid.ScrollBars := ssNone;
    StringGrid.Width := 450; //StringGrid.DefaultColWidth + 2 * StringGrid.GridLineWidth
    If StringGrid.RowCount > 8 Then
        StringGrid.Height := 252 //(StringGrid.DefaultRowHeight + StringGrid.GridLineWidth) * 8 + StringGrid.GridLineWidth
    Else
        StringGrid.Height := (StringGrid.DefaultRowHeight + StringGrid.GridLineWidth) * StringGrid.RowCount + 5;

    MainForm.SaveMenuItem.Enabled := StringGrid.RowCount > 1;
    IsSaved := StringGrid.RowCount = 1;
End;

Procedure ClearStringGrid(StringGrid: TStringGrid);
Var
    Row: Integer;
Begin
    For Row := 1 To StringGrid.RowCount - 1 Do
        StringGrid.Cells[0, Row] := '';
    StringGrid.RowCount := 1;
End;



Function ReadFileNumber(Var InputFile: TextFile; NumberStringGrid: TStringGrid) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
    Temp: String;
    Num: Integer;
Begin
    Error := CORRECT;
    ReadLn(InputFile, Temp);
    If (Copy(Temp, 1, 4) = '+375') And (Length(Temp) = NUMBER_LENGTH) And TryStrToInt(Copy(String(Temp), 5), Num) And CharInSet(Temp[5],['0'..'9']) Then
    Begin
        Add(TLimitedString(Temp));
        NumberStringGrid.RowCount := NumberStringGrid.RowCount + 1;
    End
    Else
        Error := INCORRECT_NUMBER;
    ReadFileNumber := Error;
End;

Function ReadFileData(Var InputFile: TextFile; NumberStringGrid: TStringGrid) : ERRORS_CODE;
Var
    Error: ERRORS_CODE;
    I: Integer;
Begin
    Reset(InputFile);
    Error := CORRECT;
    I := 1;
    While (Error = CORRECT) And Not seekEOF(InputFile) And (I <= MAX_AMOUNT_NUMBERS) Do
    Begin
        Error := ReadFileNumber(InputFile, NumberStringGrid);
        Inc(I);
    End;
    If (Error = CORRECT) And Not seekEOF(InputFile) Then
        Error := EXTRA_DATA;
    CloseFile(InputFile);
    ReadFileData := Error;
End;

Procedure TMainForm.OpenMenuItemClick(Sender: TObject);
Var
    InputFile: TextFile;
    Error: ERRORS_CODE;
Begin
    If OpenDialog.Execute Then
    Begin
        AssignFile(InputFile, OpenDialog.FileName);
        Clear();
        ClearStringGrid(NumberStringGrid);
        Error := ReadFileData(InputFile, NumberStringGrid);
        If Error = CORRECT Then
        Begin
            WriteLinkedList(NumberStringGrid);
            DrawStringGrid(NumberStringGrid);
        End
        Else
        Begin
            Clear();
            ClearStringGrid(NumberStringGrid);
            DrawStringGrid(NumberStringGrid);
            Application.MessageBox(PWideChar(ERRORS[Error]), 'Ошибка', MB_OK + MB_ICONERROR);
        End;
    End;
End;



Procedure TMainForm.AddButtonClick(Sender: TObject);
Begin
    If NumberStringGrid.RowCount <= MAX_AMOUNT_NUMBERS Then
    Begin
        AddForm := TAddForm.Create(Self);
        AddForm.Icon := MainForm.Icon;
        AddForm.ShowModal;
        AddForm.Free;

        If IsEdited Then
        Begin
            DrawStringGrid(NumberStringGrid);

            IsEdited := False;
        End;
    End
    Else
        Application.MessageBox('Слишком много номеров!', 'Ошибка', MB_OK + MB_ICONERROR);
End;

Procedure TMainForm.DeleteButtonClick(Sender: TObject);
Var
    Confirmation: Integer;
Begin
    If NumberStringGrid.Row > 0 Then
    Begin
        Confirmation := Application.MessageBox('Вы действительно хотите удалить телефон?', 'Удаление', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
        If Confirmation = IDYES Then
        Begin
            Remove(NumberStringGrid.Row);
            NumberStringGrid.Cells[0, NumberStringGrid.RowCount - 1] := '';
            NumberStringGrid.RowCount := NumberStringGrid.RowCount - 1;
            WriteLinkedList(NumberStringGrid);
            DrawStringGrid(NumberStringGrid);
        End;
    End
    Else
        Application.MessageBox('Не выбрано редактируемое поле!', 'Ошибка', MB_OK + MB_ICONERROR);
End;

Procedure TMainForm.ReverseButtonClick(Sender: TObject);
Begin
    If NumberStringGrid.RowCount > 1 Then
    Begin
        Reverse();
        WriteLinkedList(NumberStringGrid);

        MainForm.SaveMenuItem.Enabled := True;
        IsSaved := False;
    End
    Else
        Application.MessageBox('Не добавлено номеров!', 'Ошибка', MB_OK + MB_ICONERROR);
End;



Procedure WriteFileData(Var OutputFile: TextFile; NumberStringGrid: TStringGrid);
Var
    I: Integer;
Begin
    ReWrite(OutputFile);
    For I := 1 To NumberStringGrid.RowCount - 1 Do
        WriteLn(OutputFile, NumberStringGrid.Cells[0, I]);
    CloseFile(OutputFile);
End;

Procedure TMainForm.SaveMenuItemClick(Sender: TObject);
Var
    OutputFile: TextFile;
Begin
    If SaveDialog.Execute Then
    Begin
        AssignFile(OutputFile, SaveDialog.FileName);
        WriteFileData(OutputFile, NumberStringGrid);
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
        Confirmation := Application.MessageBox('Вы действительно хотите выйти?', 'Выход', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
        CanClose := Confirmation = IDYES;
    End
    Else
    Begin
        Confirmation := Application.MessageBox('Вы не сохранили файл, хотите ли сохранить?', 'Выход', MB_YESNOCANCEl + MB_ICONQUESTION + MB_DEFBUTTON2);
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
