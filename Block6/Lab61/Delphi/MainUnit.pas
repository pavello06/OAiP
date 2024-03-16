Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

Const
    WATCH_IMAGE_PADDING_LEFT_RIGHT = 80;
    WATCH_IMAGE_PADDING_TOP_BOTTOM = 20;
    WATCH_IMAGE_BOX_PEN_WIDTH = 10;
    SAND_LEVEL_FALLING = 10;

Type
    TMainForm = Class(TForm)
        StartButton: TButton;
        WatchTimer: TTimer;
        WatchImage: TImage;

        Procedure MainFormCreate(Sender: TObject);
        Function MainFormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;

        Procedure StartButtonClick(Sender: TObject);
        Procedure WatchTimerTimer(Sender: TObject);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    MainForm: TMainForm;

Implementation

{$R *.dfm}

Var
    WatchLeftSide, WatchTopSide: Integer;
    TopHalfSandLevel, BottomHalfSandLevel, TopHalfLeftSandLevel, TopHalfRightSandLevel, SandLineBottom: Integer;

Procedure PaintWatch(WatchImage: TImage);
Begin
    With WatchImage.Canvas Do
    Begin
        Pen.Width := WATCH_IMAGE_BOX_PEN_WIDTH;
        Pen.Color := clRed;
        Brush.Color := clWhite;
        Polygon([Point(WatchLeftSide, WatchTopSide),
                 Point(WatchImage.Width - WatchLeftSide, WatchTopSide),
                 Point(WatchLeftSide, WatchImage.Height - WatchTopSide),
                 Point(WatchImage.Width - WatchLeftSide, WatchImage.Height - WatchTopSide)]);
    End;
End;

Procedure TMainForm.MainFormCreate(Sender: TObject);
Begin
    WatchLeftSide := WATCH_IMAGE_PADDING_LEFT_RIGHT;
    WatchTopSide := WATCH_IMAGE_PADDING_TOP_BOTTOM;

    PaintWatch(WatchImage);

    WatchTimer.Enabled := False;
End;



Procedure PaintSand(WatchImage: TImage);
Begin
    With WatchImage.Canvas Do
    Begin
        PaintWatch(WatchImage);
        Pen.Width := 0;
        Brush.Color := clYellow;
        Polygon([Point(TopHalfLeftSandLevel,
                       TopHalfSandLevel),
                 Point(TopHalfRightSandLevel,
                       TopHalfSandLevel),
                 Point(WatchImage.Width Div 2,
                       (WatchImage.Height - WATCH_IMAGE_BOX_PEN_WIDTH) Div 2)]);

        Polygon([Point(WatchLeftSide + WATCH_IMAGE_BOX_PEN_WIDTH,
                       WatchImage.Height - WatchTopSide - WATCH_IMAGE_BOX_PEN_WIDTH Div 2),
                 Point(WatchImage.Width - WatchLeftSide - WATCH_IMAGE_BOX_PEN_WIDTH,
                       WatchImage.Height - WatchTopSide - WATCH_IMAGE_BOX_PEN_WIDTH Div 2),
                 Point(WatchImage.Width Div 2,
                       BottomHalfSandLevel)]);
    End;
End;

Function TMainForm.MainFormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    MainFormHelp := False;
End;

Procedure TMainForm.StartButtonClick(Sender: TObject);
Begin
    TopHalfSandLevel := 0 + WATCH_IMAGE_PADDING_TOP_BOTTOM + WATCH_IMAGE_BOX_PEN_WIDTH Div 2;
    BottomHalfSandLevel := WatchImage.Height - WATCH_IMAGE_PADDING_TOP_BOTTOM - WATCH_IMAGE_BOX_PEN_WIDTH Div 2;
    TopHalfLeftSandLevel := WatchLeftSide + WATCH_IMAGE_BOX_PEN_WIDTH;
    TopHalfRightSandLevel := WatchImage.Width - WatchLeftSide - WATCH_IMAGE_BOX_PEN_WIDTH;

    SandLineBottom := WatchImage.Height Div 2 + WATCH_IMAGE_BOX_PEN_WIDTH;

    WatchTimer.Enabled := True;
End;



Procedure TMainForm.WatchTimerTimer(Sender: TObject);
Begin
    If TopHalfSandLevel < WatchImage.Height Div 2 Then
    Begin

        PaintSand(WatchImage);
        WatchImage.Canvas.Pen.Color := clYellow;
        WatchImage.Canvas.Polygon([Point(WatchImage.Width Div 2 - 2, WatchImage.Height Div 2 + WATCH_IMAGE_BOX_PEN_WIDTH),
                                   Point(WatchImage.Width Div 2 + 2, WatchImage.Height Div 2 + WATCH_IMAGE_BOX_PEN_WIDTH),
                                   Point(WatchImage.Width Div 2 + 2, SandLineBottom),
                                   Point(WatchImage.Width Div 2 - 2, SandLineBottom)]);
        If SandLineBottom + 30 < WatchImage.Height - WatchTopSide - WATCH_IMAGE_BOX_PEN_WIDTH Then
            Inc(SandLineBottom, 30)
        Else
        Begin
            SandLineBottom := WatchImage.Height - WatchTopSide - WATCH_IMAGE_BOX_PEN_WIDTH;
            Inc(TopHalfSandLevel, SAND_LEVEL_FALLING);
            Dec(BottomHalfSandLevel, SAND_LEVEL_FALLING);
            Inc(TopHalfLeftSandLevel, SAND_LEVEL_FALLING * (WatchImage.Width - 2 * (WatchLeftSide - WATCH_IMAGE_BOX_PEN_WIDTH)) Div (WatchImage.Height - 2 * WatchTopSide));
            Dec(TopHalfRightSandLevel, SAND_LEVEL_FALLING * (WatchImage.Width - 2 * (WatchLeftSide - WATCH_IMAGE_BOX_PEN_WIDTH)) Div (WatchImage.Height - 2 * WatchTopSide));

        End;
    End
    Else
        WatchTimer.Enabled := False;
End;

End.
