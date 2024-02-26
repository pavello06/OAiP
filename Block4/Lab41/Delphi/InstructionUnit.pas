Unit InstructionUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

Type
    TInstructionForm = Class(TForm)

    InstructionLabel: TLabel;

    Procedure InstructionFormCreate(Sender: TObject);
    Procedure InstructionFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    InstructionForm: TInstructionForm;

Implementation

{$R *.dfm}

Uses MainUnit;

Procedure TInstructionForm.InstructionFormCreate(Sender: TObject);
Begin
    InstructionLabel.Width := 800;
    InstructionLabel.Caption := '1. Для добавления спектакля нажмите Ins или 1 кнопку сверху.'#13#10 +
                                '2. Для удаления спектакля нажмите Del или 2 кнопку сверху.'#13#10 +
                                '3. Для редактирования спектакля дважды кликните ЛКМ по спектаклю или нажмите 3 кнопку сверху.'#13#10 +
                                '4. Для поиска ближайшего спектакля нажмите 4 кнопку сверху.'#13#10 +
                                '5. Для просмотра содержимого ячейки кликните ЛКМ на неё.'#13#10 +
                                '6. Для сортировки в выпадающем списке выберите интересующие вас пункты.'#13#10 +
                                '7. Максимальное количество спектаклей равно' + IntToStr(MAX_SHOWS) + '.';
    InstructionLabel.Left := (ClientWidth - InstructionLabel.Width) Div 2;
    InstructionLabel.Top := (ClientHeight - InstructionLabel.Height) Div 2;
End;

Procedure TInstructionForm.InstructionFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;

End.
