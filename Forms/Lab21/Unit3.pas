unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TDeveloperForm = class(TForm)
    DeveloperLabel: TLabel;
    DeveloperExitButton: TButton;
    procedure DeveloperFormOnCreate(Sender: TObject);
    procedure DeveloperExitButtonOnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DeveloperForm: TDeveloperForm;

implementation

{$R *.dfm}



procedure TDeveloperForm.DeveloperFormOnCreate(Sender: TObject);
begin
    DeveloperLabel.Caption := 'Разработчик: Галуха Павел Александрович'#13#10'Группа: 351005'#13#10'tg: @pavello06';
    DeveloperLabel.Width := 400;
    DeveloperLabel.Left := (ClientWidth - DeveloperLabel.Width) Div 2;
end;

procedure TDeveloperForm.DeveloperExitButtonOnClick(Sender: TObject);
begin
    Close;
end;

end.
