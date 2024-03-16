Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
    Vcl.Imaging.pngimage, FrontEndUnit, BackEndUnit, Vcl.ComCtrls;

Const
    BOARD_CELLS_AMOUNT = 8;

Type
    TMainForm = Class(TForm)
        BoardImage: TImage;
        HorseFigureImage: TImage;
        StartButton: TButton;
        HorseFigureTimer: TTimer;
        SpeedTrackBar: TTrackBar;

        Function FormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
        Procedure FormResize(Sender: TObject);

        Procedure HorseFigureImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
        Procedure HorseFigureImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
        Procedure HorseFigureImageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

        Procedure StartButtonClick(Sender: TObject);

        Procedure HorseFigureTimerTimer(Sender: TObject);


    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    MainForm: TMainForm;
    CellSize, BorderSize: Integer;
    CurrentCol: Integer = 0;
    CurrentRow: Integer = 0;
    Board: Array [0..BOARD_CELLS_AMOUNT - 1, 0..BOARD_CELLS_AMOUNT - 1] Of Integer;
    MoveCount: Integer;

Implementation

{$R *.dfm}

Var
    IsDragging: Boolean;
    StartX, StartY: Integer;

Function TMainForm.FormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    FormHelp := False;
End;

Procedure TMainForm.FormResize(Sender: TObject);
Begin
    DrawBoard(BoardImage);
    DrawHorse(BoardImage, HorseFigureImage, CurrentCol, CurrentRow);
    DrawButton(BoardImage, StartButton);
    DrawSpeedBar(BoardImage, SpeedTrackBar);
    HorseFigureTimer.Enabled := False;
End;


Procedure TMainForm.HorseFigureImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Begin
    If Button = mbLeft Then
    Begin
        DrawBoard(BoardImage);
        HorseFigureTimer.Enabled := False;
        IsDragging := True;
        StartX := X;
        StartY := Y;
    End;
End;

Procedure TMainForm.HorseFigureImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
    If IsDragging Then
    Begin
        HorseFigureImage.Left := HorseFigureImage.Left + (X - StartX);
        HorseFigureImage.Top := HorseFigureImage.Top + (Y - StartY);
    End;
End;

Procedure TMainForm.HorseFigureImageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Begin
    If Button = mbLeft Then
    Begin
        IsDragging := False;
        CurrentCol := Round((HorseFigureImage.Left - BoardImage.Left - BorderSize) / CellSize);
        CurrentRow := Round((HorseFigureImage.Top - BoardImage.Top - BorderSize) / CellSize);
        If CurrentCol < 0 Then
            CurrentCol := 0
        Else If CurrentCol > BOARD_CELLS_AMOUNT - 1 Then
            CurrentCol := BOARD_CELLS_AMOUNT - 1;
        If CurrentRow < 0 Then
            CurrentRow := 0
        Else If CurrentRow > BOARD_CELLS_AMOUNT - 1 Then
            CurrentRow := BOARD_CELLS_AMOUNT - 1;

        DrawHorse(BoardImage, HorseFigureImage, CurrentCol, CurrentRow);
    End;
End;


Procedure TMainForm.StartButtonClick(Sender: TObject);
Begin
    HorseFigureTimer.Enabled := False;
    DrawBoard(BoardImage);
    MoveCount := 1;
    CalcMoves();
    HorseFigureTimer.Enabled := True;
End;


Procedure TMainForm.HorseFigureTimerTimer(Sender: TObject);
Begin
    HorseFigureTimer.Interval := SpeedTrackBar.Position * 100;
    DrawHorseStep(BoardImage, HorseFigureImage);
    CurrentCol := Round((HorseFigureImage.Left - BoardImage.Left - BorderSize) / CellSize);
    CurrentRow := Round((HorseFigureImage.Top - BoardImage.Top - BorderSize) / CellSize);
    If MoveCount = BOARD_CELLS_AMOUNT * BOARD_CELLS_AMOUNT + 1 Then
        HorseFigureTimer.Enabled := False;
End;

End.
