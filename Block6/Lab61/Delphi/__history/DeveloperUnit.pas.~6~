Unit DeveloperUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

Type
    TDeveloperForm = Class(TForm)
        DeveloperLabel: TLabel;

        Procedure DeveloperFormCreate(Sender: TObject);
        Procedure DeveloperFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);

    Private
      { Private declarations }
    Public
      { Public declarations }
    End;

Var
    DeveloperForm: TDeveloperForm;

Implementation

{$R *.dfm}

Procedure TDeveloperForm.DeveloperFormCreate(Sender: TObject);
Begin
    DeveloperLabel.Caption := 'Группа: 351005'#13#10 +
                              'Разработчик: Галуха Павел Александрович'#13#10 +
                              'Телеграмм: @pavello06';
    DeveloperLabel.Left := (ClientWidth - DeveloperLabel.Width) Div 2;
    DeveloperLabel.Top := (ClientHeight - DeveloperLabel.Height) Div 2;
End;

Procedure TDeveloperForm.DeveloperFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;

End.
