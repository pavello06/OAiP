Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.Menus, InstructionUnit, DeveloperUnit, EditUnit, SearchUnit,
    Vcl.ExtDlgs, System.ImageList, Vcl.ImgList, Vcl.ExtCtrls,
    Vcl.Imaging.pngimage;

Type
    TMainForm = Class(TForm)

    TabsMainMenu: TMainMenu;
    FileMenuItem: TMenuItem;
    SaveMenuItem: TMenuItem;
    SeparatorMenuItem: TMenuItem;
    ExitMenuItem: TMenuItem;
    InstructionMenuItem: TMenuItem;
    DeveloperMenuItem: TMenuItem;
    SaveTextFileDialog1: TSaveTextFileDialog;

    AddImage: TImage;
    DeleteImage: TImage;
    EditImage: TImage;
    SearchImage: TImage;

    SortLabel: TLabel;
    DataSortComboBox: TComboBox;
    OrderSortComboBox: TComboBox;

    DataEdit: TEdit;
    ShowsStringGrid: TStringGrid;

    Procedure MainFormCreate(Sender: TObject);
    Function MainFormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
    Procedure MainFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);

    Procedure InstructionMenuItemClick(Sender: TObject);
    Procedure DeveloperMenuItemClick(Sender: TObject);

    Procedure SaveMenuItemClick(Sender: TObject);

    Procedure ShowsStringGridSellectCell(Sender: TObject; ACol, ARow: Integer; Var CanSelect: Boolean);

    Procedure ComboBoxChange(Sender: TObject);

    Procedure AddImageClick(Sender: TObject);
    Procedure DeleteImageClick(Sender: TObject);
    Procedure ShowsStringGridKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure EditImageClick(Sender: TObject);
    Procedure ShowsStringGridDblClick(Sender: TObject);
    Procedure SearchImageClick(Sender: TObject);

    Procedure ExitMenuItemClick(Sender: TObject);
    Procedure MainFormCloseQuery(Sender: TObject; Var CanClose: Boolean);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Type
    TShow = Record
        Name: String[32];
        Author: String[32];
        Director: String[32];
        Date: TDate;
        Time: TTime;
    End;
    TShows = Array Of TShow;
    TFileShows = File Of TShow;
    TDataCriterion = (Name, Author, Director, Date, Time);
    TOrderCriterion = (ToHigh, ToLow);

Const
    PathToTypedFile = 'TypedFile.txt';
    PathToCorrectFile = 'CorrectFile.txt';
    MAX_SHOWS = 100;

Var
    MainForm: TMainForm;
    IsEdited: Boolean = False;
    IsSaved: Boolean = True;

Implementation

{$R *.dfm}

Procedure DrawShowsStringGrid(ShowsStringGrid: TStringGrid);
Begin
    If ShowsStringGrid.RowCount > 8 Then
    Begin
        ShowsStringGrid.Height := 415; //(ShowsStringGrid.DefaultRowHeight + ShowsStringGrid.GridLineWidth) * 8 + ShowsStringGrid.GridLineWidth
        ShowsStringGrid.Width := 995; //(ShowsStringGrid.DefaultColWidth + ShowsStringGrid.GridLineWidth) * 5 + ShowsStringGrid.GridLineWidth + 20
    End
    Else
    Begin
        ShowsStringGrid.Height := (ShowsStringGrid.DefaultRowHeight + ShowsStringGrid.GridLineWidth) * ShowsStringGrid.RowCount + 4;
        ShowsStringGrid.Width := 975; //(ShowsStringGrid.DefaultColWidth + ShowsStringGrid.GridLineWidth) * 5 + ShowsStringGrid.GridLineWidth
    End;
End;

Procedure ClearShowsStringGrid(ShowsStringGrid: TStringGrid);
Var
    Row, Col: Integer;
Begin
    For Row := 1 To ShowsStringGrid.RowCount - 1 Do
        For Col := 0 To ShowsStringGrid.ColCount - 1 Do
            ShowsStringGrid.Cells[Col, Row] := '';
    ShowsStringGrid.RowCount := 1;
End;



Function IsReadable(Var TypedFile: TFileShows) : Boolean;
Var
    IsCorrect: Boolean;
Begin
    IsCorrect := True;
    Try
        Try
            Reset(TypedFile);
        Finally
            CloseFile(TypedFile);
        End;
    Except
        IsCorrect := False;
    End;
    IsReadable := IsCorrect;
End;

Function IsNormalTypedFile(Var TypedFile: TFileShows) : Boolean;
Var
    IsCorrect: Boolean;
Begin
    IsCorrect := FileExists(PathToTypedFile);
    If IsCorrect Then
        IsCorrect := IsReadable(TypedFile);
    IsNormalTypedFile := IsCorrect;
End;

Procedure FillShowsStringGrid(Row: Integer; TempShow: TShow);
Begin
    MainForm.ShowsStringGrid.Cells[0, Row] := String(TempShow.Name);
    MainForm.ShowsStringGrid.Cells[1, Row] := String(TempShow.Author);
    MainForm.ShowsStringGrid.Cells[2, Row] := String(TempShow.Director);
    MainForm.ShowsStringGrid.Cells[3, Row] := DateToStr(TempShow.Date);
    MainForm.ShowsStringGrid.Cells[4, Row] := FormatDateTime('HH:mm', TempShow.Time);
End;

Procedure ReadTypedFile();
Var
    TypedFile: TFileShows;
    TempShow: TShow;
    IsCorrect: Boolean;
    CanSelect: Boolean;
Begin
    AssignFile(TypedFile, PathToTypedFile);
    IsCorrect := IsNormalTypedFile(TypedFile);
    MainForm.ShowsStringGrid.RowCount := 1;
    If IsCorrect Then
    Begin
        Reset(TypedFile);
        While Not EOF(TypedFile) Do
        Begin
            MainForm.ShowsStringGrid.RowCount := MainForm.ShowsStringGrid.RowCount + 1;
            Try
                Read(TypedFile, TempShow);
                DateToStr(TempShow.Date);
                TimeToStr(TempShow.Time);
            Except
                IsCorrect := False;
            End;
            If IsCorrect And (Length(TempShow.Name) <= 32) And (Length(TempShow.Author) <= 32) And (Length(TempShow.Director) <= 32) Then
                FillShowsStringGrid(MainForm.ShowsStringGrid.RowCount - 1, TempShow)
            Else
                IsCorrect := False;
        End;
        CloseFile(TypedFile);
    End;
    If Not IsCorrect Then
    Begin
        ReWrite(TypedFile);
        Close(TypedFile);
        ClearShowsStringGrid(MainForm.ShowsStringGrid);
    End;
    DrawShowsStringGrid(MainForm.ShowsStringGrid);
    MainForm.SaveMenuItem.Enabled := MainForm.ShowsStringGrid.RowCount > 1;
    IsSaved := MainForm.ShowsStringGrid.RowCount = 1;
    CanSelect := True;
    MainForm.ShowsStringGridSellectCell(MainForm.ShowsStringGrid, MainForm.ShowsStringGrid.Col, MainForm.ShowsStringGrid.Row, CanSelect);
End;



Procedure TMainForm.MainFormCreate(Sender: TObject);
Const
    TitleRow = 0;
Begin
    ShowsStringGrid.Cells[0, TitleRow] := '��������';
    ShowsStringGrid.Cells[1, TitleRow] := '�����';
    ShowsStringGrid.Cells[2, TitleRow] := '�������';
    ShowsStringGrid.Cells[3, TitleRow] := '����';
    ShowsStringGrid.Cells[4, TitleRow] := '�����';
    ReadTypedFile();
End;

Function TMainForm.MainFormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    InstructionMenuItemClick(InstructionMenuItem);
    MainFormHelp := False;
End;

Procedure TMainForm.MainFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_INSERT Then
        AddImageClick(AddImage);
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



Procedure WriteFileData(Var OutputFile: TextFile);
Var
    TypedFile: TFileShows;
    TempShow: TShow;
Begin
    AssignFile(TypedFile, PathToTypedFile);
    Reset(TypedFile);
    ReWrite(OutputFile);
    While Not EOF(TypedFile) Do
    Begin
        Read(TypedFile, TempShow);
        WriteLn(OutputFile, '��������: ', TempShow.Name);
        WriteLn(OutputFile, '�����: ', TempShow.Author);
        WriteLn(OutputFile, '�������', TempShow.Director);
        WriteLn(OutputFile, '����: ', DateToStr(TempShow.Date));
        WriteLn(OutputFile, '�����: ', FormatDateTime('HH:mm', TempShow.Time));
        WriteLn(OutputFile);
    End;
    CloseFile(OutputFile);
    CloseFile(TypedFile);
End;

Procedure TMainForm.SaveMenuItemClick(Sender: TObject);
Var
    OutputFile: TextFile;
Begin
    If SaveTextFileDialog1.Execute Then
    Begin
        If ExpandFileName(PathToTypedFile) = SaveTextFileDialog1.FileName Then
            Application.MessageBox('�� ��� ���� �������!', '������', MB_OK + MB_ICONERROR)
        Else
        Begin
            AssignFile(OutputFile, SaveTextFileDialog1.FileName);
            WriteFileData(OutputFile);
            IsSaved := True;
        End;
    End;
End;



Procedure TMainForm.ShowsStringGridSellectCell(Sender: TObject; ACol, ARow: Integer; Var CanSelect: Boolean);
Begin
    If ARow > 0 Then
        DataEdit.Text := ShowsStringGrid.Cells[ACol, ARow]
    Else
        DataEdit.Text := '';
End;



Procedure ReadTypedFileInArray(Var ShowsArr: TShows);
Var
    TypedFile: TFileShows;
    I: Integer;
Begin
    AssignFile(TypedFile, PathToTypedFile);
    Reset(TypedFile);
    I := 0;
    While Not EOF(TypedFile) Do
    Begin
        SetLength(ShowsArr, Length(ShowsArr) + 1);
        Read(TypedFile, ShowsArr[I]);
        Inc(I);
    End;
    CloseFile(TypedFile);
End;

Function CompareShows(Show1, Show2: TShow; DataCriterion: TDataCriterion; OrderCriterion: TOrderCriterion) : Boolean;
Var
    ResCompareShows: Boolean;
Begin
    ResCompareShows := False;
    Case DataCriterion Of
        Name:
            ResCompareShows := AnsiUpperCase(String(Show1.Name)) > AnsiUpperCase(String(Show2.Name));
        Author:
            ResCompareShows := AnsiUpperCase(String(Show1.Author)) > AnsiUpperCase(String(Show2.Author));
        Director:
            ResCompareShows := AnsiUpperCase(String(Show1.Director)) > AnsiUpperCase(String(Show2.Director));
        Date:
            ResCompareShows := Show1.Date > Show2.Date;
        Time:
            ResCompareShows := Show1.Time > Show2.Time;
    End;
    If OrderCriterion = ToLow Then
        ResCompareShows := Not ResCompareShows;
    CompareShows := ResCompareShows;
End;

Procedure RecordArrayInTypedFile(ShowsArr: TShows);
Var
    TypedFile: TFileShows;
    I: Integer;
Begin
    AssignFile(TypedFile, PathToTypedFile);
    ReWrite(TypedFile);
    I := 0;
    While I < Length(ShowsArr) Do
    Begin
        Write(TypedFile, ShowsArr[I]);
        Inc(I);
    End;
    CloseFile(TypedFile);
End;

Procedure SortShows(DataCriterion: TDataCriterion; OrderCriterion: TOrderCriterion);
Var
    ShowsArr: TShows;
    Key: TShow;
    I, J: Integer;
Begin
    SetLength(ShowsArr, 0);
    ReadTypedFileInArray(ShowsArr);
    For I := 1 To High(ShowsArr) Do
    Begin
        Key := ShowsArr[I];
        J := I - 1;
        While (J >= 0) And CompareShows(ShowsArr[J], Key, DataCriterion, OrderCriterion) Do
        Begin
            ShowsArr[J + 1] := ShowsArr[J];
            Dec(J);
        End;
        ShowsArr[J + 1] := Key;
    End;
    RecordArrayInTypedFile(ShowsArr);
End;



Procedure TMainForm.ComboBoxChange(Sender: TObject);
Begin
    SortShows(TDataCriterion(DataSortComboBox.ItemIndex), TOrderCriterion(OrderSortComboBox.ItemIndex));
    ReadTypedFile();
End;



Procedure DeleteRecord(CurrentRow: Integer);
Var
    TypedFile: TFileShows;
    CorrectFile: TFileShows;
    TempShow: TShow;
    I: Integer;
Begin
    AssignFile(TypedFile, PathToTypedFile);
    Reset(TypedFile);
    AssignFile(CorrectFile, PathToCorrectFile);
    ReWrite(CorrectFile);
    For I := 1 To CurrentRow - 1 Do
    Begin
        Read(TypedFile, TempShow);
        Write(CorrectFile, TempShow);
    End;
    Read(TypedFile, TempShow);
    While Not EOF(TypedFile) Do
    Begin
        Read(TypedFile, TempShow);
        Write(CorrectFile, TempShow);
    End;
    CloseFile(CorrectFile);
    CloseFile(TypedFile);

    DeleteFile(PathToTypedFile);
    RenameFile(PathToCorrectFile, PathToTypedFile);
End;

Procedure TMainForm.AddImageClick(Sender: TObject);
Begin
    If ShowsStringGrid.RowCount <= MAX_SHOWS Then
    Begin
        EditForm := TEditForm.Create(Self);
        EditForm.Icon := MainForm.Icon;
        EditForm.Caption := '���������� ���������';
        EditForm.OkButton.Caption := '��������';
        EditForm.OkButton.Enabled := False;
        EditForm.ShowModal;
        EditForm.Free;

        If IsEdited Then
        Begin
            SortShows(TDataCriterion(DataSortComboBox.ItemIndex), TOrderCriterion(OrderSortComboBox.ItemIndex));
            ReadTypedFile();
            IsEdited := False;
        End
    End
    Else
        Application.MessageBox('������� ����� ����������!', '������', MB_OK + MB_ICONERROR);
End;

Procedure TMainForm.DeleteImageClick(Sender: TObject);
Var
    Confirmation: Integer;
Begin
    If ShowsStringGrid.Row > 0 Then
    Begin
        Confirmation := Application.MessageBox('�� ������������� ������ ������� ���������?', '��������', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
        If Confirmation = IDYES Then
        Begin
            DeleteRecord(ShowsStringGrid.Row);
            ReadTypedFile();
        End;
    End
    Else
        Application.MessageBox('�� ������� ������������� ����!', '������', MB_OK + MB_ICONERROR);
End;

Procedure TMainForm.ShowsStringGridKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_DELETE Then
        DeleteImageClick(DeleteImage);
End;

Procedure TMainForm.EditImageClick(Sender: TObject);
Begin
    If ShowsStringGrid.Row > 0 Then
    Begin
        EditForm := TEditForm.Create(Self);
        EditForm.Icon := MainForm.Icon;
        EditForm.Caption := '�������������� ���������';
        EditForm.OkButton.Caption := '�������������';
        EditForm.OkButton.Enabled := True;

        EditForm.NameEdit.Text := Copy(ShowsStringGrid.Cells[0, ShowsStringGrid.Row], 2, Length(ShowsStringGrid.Cells[0, ShowsStringGrid.Row]) - 2);
        EditForm.AuthorEdit.Text := ShowsStringGrid.Cells[1, ShowsStringGrid.Row];
        EditForm.DirectorEdit.Text := ShowsStringGrid.Cells[2, ShowsStringGrid.Row];
        EditForm.DatePicker.Date := StrToDate(ShowsStringGrid.Cells[3, ShowsStringGrid.Row]);
        EditForm.TimePicker.Time := StrToTime(ShowsStringGrid.Cells[4, ShowsStringGrid.Row]);

        EditForm.ShowModal;
        EditForm.Free;

        If IsEdited Then
        Begin
            DeleteRecord(ShowsStringGrid.Row);
            SortShows(TDataCriterion(DataSortComboBox.ItemIndex), TOrderCriterion(OrderSortComboBox.ItemIndex));
            ReadTypedFile();
            IsEdited := False;
        End
    End
    Else
        Application.MessageBox('�� ������� ������������� ����!', '������', MB_OK + MB_ICONERROR);
End;

Procedure TMainForm.ShowsStringGridDblClick(Sender: TObject);
Begin
    EditImageClick(EditImage);
End;

Procedure TMainForm.SearchImageClick(Sender: TObject);
Begin
    If ShowsStringGrid.RowCount > 1 Then
    Begin
        SearchForm := TSearchForm.Create(Self);
        SearchForm.Icon := MainForm.Icon;
        SearchForm.ShowModal;
        SearchForm.Free;
    End
    Else
        Application.MessageBox('��� ������������� �����!', '������', MB_OK + MB_ICONERROR);
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
        Confirmation := Application.MessageBox('�� ������������� ������ �����?', '�����', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
        CanClose := Confirmation = IDYES;
    End
    Else
    Begin
        Confirmation := Application.MessageBox('�� �� ��������� ����, ������ �� ��������� � .txt ����?', '�����', MB_YESNOCANCEl + MB_ICONQUESTION + MB_DEFBUTTON2);
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
