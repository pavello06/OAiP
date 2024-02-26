Unit SearchUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

Type
    TSearchForm = Class(TForm)

    SearchLabel: TLabel;
    SearchDateTimePicker: TDateTimePicker;

    SearchButton: TButton;
    CancelButton: TButton;

    Procedure SearchFormCreate(Sender: TObject);
    Procedure SearchFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);

    Procedure ComponentKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);

    Procedure SearchButtonClick(Sender: TObject);
    Procedure CloseButtonClick(Sender: TObject);

    Private
      { Private declarations }
    Public
      { Public declarations }
    End;

Var
  SearchForm: TSearchForm;

Implementation

{$R *.dfm}

Uses MainUnit;

Procedure TSearchForm.SearchFormCreate(Sender: TObject);
Begin
    SearchDateTimePicker.DateTime := Now;
End;

Procedure TSearchForm.SearchFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;



Procedure TSearchForm.ComponentKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Const
    ENTER = Ord(#13);
Begin
    If Key = VK_UP Then
        SelectNext(TWinControl(Sender), False, True)
    Else If Key = VK_DOWN Then
        SelectNext(TWinControl(Sender), True, True)
    Else If (Key = ENTER) Then
        SearchButtonClick(SearchButton);
End;



Procedure TSearchForm.SearchButtonClick(Sender: TObject);
Var
    TypedFile: TFileShows;
    TempShow: TShow;
    I, ClosestDateIndex: Integer;
    MinDifference, Difference: Double;
    FoundDateAfter: Boolean;
Begin
    AssignFile(TypedFile, PathToTypedFile);
    Reset(TypedFile);
    FoundDateAfter := False;
    ClosestDateIndex := 0;
    MinDifference := MaxInt;
    I := 1;
    While Not EOF(TypedFile) Do
    Begin
        Read(TypedFile, TempShow);
        Difference := TempShow.Date - SearchDateTimePicker.Date + TempShow.Time - SearchDateTimePicker.Time;
        If Difference >= 0 Then
        Begin
            If Difference < MinDifference Then
            Begin
              MinDifference := Difference;
              ClosestDateIndex := I;
              FoundDateAfter := True;
            End;
        End;
        Inc(I);
    End;
    CloseFile(TypedFile);
    If FoundDateAfter Then
    Begin
        MainForm.ShowsStringGrid.Row := ClosestDateIndex;
        Application.MessageBox('��� ��������� �������!', '���������', MB_OK + MB_ICONINFORMATION);
        Close;
    End
    Else
        Application.MessageBox('��� ��������� ���������� �� �����������!', '�����', MB_OK + MB_ICONHAND);
End;

Procedure TSearchForm.CloseButtonClick(Sender: TObject);
Begin
    Close;
End;


End.                    
