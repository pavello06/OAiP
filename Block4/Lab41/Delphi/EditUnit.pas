Unit EditUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask;

Type
    TEditForm = Class(TForm)

    NameLabel: TLabel;
    NameEdit: TEdit;
    AuthorLabel: TLabel;
    AuthorEdit: TEdit;
    DirectorLabel: TLabel;
    DirectorEdit: TEdit;
    DateLabel: TLabel;
    DatePicker: TDateTimePicker;
    TimeLabel: TLabel;
    TimePicker: TDateTimePicker;

    OkButton: TButton;
    CancelButton: TButton;

    Procedure EditFormCreate(Sender: TObject);
    Procedure EditFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);

    Procedure ComponentKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure ComponentChange(Sender: TObject);

    Procedure OkButtonClick(Sender: TObject);
    Procedure CloseButtonClick(Sender: TObject);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;
Var
    EditForm: TEditForm;

Implementation

{$R *.dfm}

Uses MainUnit;

Procedure TEditForm.EditFormCreate(Sender: TObject);
Begin
    DatePicker.Date := Now;
    TimePicker.Time := Now;
End;

Procedure TEditForm.EditFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;



Function IsFullFields() : Boolean;
Begin
    IsFullFields := (EditForm.NameEdit.Text <> '') And (EditForm.AuthorEdit.Text <> '') And (EditForm.DirectorEdit.Text <> '');
End;



Procedure TEditForm.ComponentKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Const
    ENTER = Ord(#13);
Begin
    If Key = VK_UP Then
        SelectNext(TWinControl(Sender), False, True)
    Else If Key = VK_DOWN Then
        SelectNext(TWinControl(Sender), True, True)
    Else If (Key = ENTER) And OkButton.Enabled Then
        OkButtonClick(OkButton);
End;

Procedure TEditForm.ComponentChange(Sender: TObject);
Begin
    If IsFullFields() Then
        OkButton.Enabled := True
    Else
        OkButton.Enabled := False;
End;



Procedure TEditForm.OkButtonClick(Sender: TObject);
Var
    TypedFile: TFileShows;
    TempShow: TShow;
Begin
    TempShow.Name := ShortString('"' + NameEdit.Text + '"');
    TempShow.Author := ShortString(AuthorEdit.Text);
    TempShow.Director := ShortString(DirectorEdit.Text);
    TempShow.Date := DatePicker.Date;
    TempShow.Time := TimePicker.Time;

    AssignFile(TypedFile, PathToTypedFile);
    Reset(TypedFile);
    Seek(TypedFile, FileSize(TypedFile));
    Write(TypedFile, TempShow);
    CloseFile(TypedFile);

    IsEdited := True;
    Close;
End;

Procedure TEditForm.CloseButtonClick(Sender: TObject);
Begin
    Close;
End;

End.
