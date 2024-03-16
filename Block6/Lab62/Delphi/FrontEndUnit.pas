Unit FrontEndUnit;

Interface

Uses
    System.SysUtils, Vcl.Graphics, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ComCtrls;

Procedure DrawBoard(BoardImage: TImage);
Procedure DrawHorse(BoardImage, HorseFigureImage: TImage; Col, Row: Integer);
Procedure DrawButton(BoardImage: TImage; StartButton: TButton);
Procedure DrawSpeedBar(BoardImage: TImage; SpeedTrackBar: TTrackBar);
Procedure DrawHorseStep(BoardImage, HorseFigureImage: TImage);

Implementation

Uses MainUnit;

Const
    BASED_CLIENT_WIDTH : Integer = 800;
    BASED_CLIENT_HEIGHT : Integer = 600;
    BASED_FORM_MARGINS_TOP_BOTTOM : Integer = 25;

    BASED_BOARD_SIZE : Integer = 450;
    BASED_BOARD_FONT_SIZE : Integer = 10;
    BASED_BOARD_BORDER_SIZE : Integer = 10;

    BASED_START_BUTTON_WIDTH : Integer = 200;
    BASED_START_BUTTON_HEIGHT : Integer = 50;
    BASED_START_BUTTON_FONT_SIZE : Integer = 20;


    BOARD_BRUSH_BORDER_COLOR: TColor = $1B60A5;
    BOARD_BRUSH_LIGHT_COLOR: TColor = $9ECEFF;
    BOARD_BRUSH_DARK_COLOR: TColor = $478CD2;

Procedure ChangeBrushColor(BoardImage: TImage);
Begin
    With BoardImage.Canvas.Brush Do
    Begin
        If Color = BOARD_BRUSH_LIGHT_COLOR Then
            Color := BOARD_BRUSH_DARK_COLOR
        Else
            Color := BOARD_BRUSH_LIGHT_COLOR;
    End;
End;

Procedure DrawBoard(BoardImage: TImage);
Var
    BoardSize, Col, Row: Integer;
    X, Y: Integer;
Begin
    With BoardImage Do
    Begin
        If (MainForm.ClientWidth / MainForm.ClientHeight) < (BASED_CLIENT_WIDTH / BASED_CLIENT_HEIGHT) Then
        Begin
            BoardSize := BASED_BOARD_SIZE * MainForm.ClientWidth Div BASED_CLIENT_WIDTH;
            BorderSize := BASED_BOARD_BORDER_SIZE * MainForm.ClientWidth Div BASED_CLIENT_WIDTH;
        End
        Else
        Begin
            BoardSize := BASED_BOARD_SIZE * MainForm.ClientHeight Div BASED_CLIENT_HEIGHT;
            BorderSize := BASED_BOARD_BORDER_SIZE * MainForm.ClientHeight Div BASED_CLIENT_HEIGHT;
        End;
        CellSize := (BoardSize - 2 * BorderSize) Div BOARD_CELLS_AMOUNT;

        Width := BoardSize;
        Height := BoardSize;
        Left := (MainForm.ClientWidth - Width) Div 2;
        Top := BASED_FORM_MARGINS_TOP_BOTTOM * MainForm.ClientHeight Div BASED_CLIENT_HEIGHT;
    End;

    With BoardImage.Canvas Do
    Begin
        Brush.Color := BOARD_BRUSH_BORDER_COLOR;
        Rectangle(0, 0, BoardSize, BoardSize);

        Brush.Color := BOARD_BRUSH_LIGHT_COLOR;
        For Col := 0 To BOARD_CELLS_AMOUNT - 1 Do
        Begin
            X := Col * CellSize + BorderSize;
            For Row := 0 To BOARD_CELLS_AMOUNT - 1 Do
            Begin
                Y := Row * CellSize + BorderSize;
                Rectangle(X, Y, X + CellSize, Y + CellSize);
                ChangeBrushColor(BoardImage);
            End;
            ChangeBrushColor(BoardImage);
        End;

        Brush.Style := bsClear;
        Font.Size := BASED_BOARD_FONT_SIZE * MainForm.ClientWidth Div BASED_CLIENT_WIDTH;
    End;
End;


Procedure DrawHorse(BoardImage, HorseFigureImage: TImage; Col, Row: Integer);
Begin
    With HorseFigureImage Do
    Begin
        Width := CellSize;
        Height := CellSize;
        Left := BoardImage.Left + BorderSize + Col * CellSize;
        Top := BoardImage.Top + BorderSize + Row * CellSize;
    End;
End;


Procedure DrawButton(BoardImage: TImage; StartButton: TButton);
Begin
    With StartButton Do
    Begin
        Width := BASED_START_BUTTON_WIDTH * MainForm.ClientWidth Div BASED_CLIENT_WIDTH;
        Height := BASED_START_BUTTON_HEIGHT * MainForm.ClientHeight Div BASED_CLIENT_HEIGHT;
        Left := (MainForm.ClientWidth - Width) Div 2;
        Top := MainForm.ClientHeight - BASED_FORM_MARGINS_TOP_BOTTOM * MainForm.ClientHeight Div BASED_CLIENT_HEIGHT - Height;
        If (MainForm.ClientWidth / MainForm.ClientHeight) < (BASED_CLIENT_WIDTH / BASED_CLIENT_HEIGHT) Then
            Font.Size := BASED_START_BUTTON_FONT_SIZE * MainForm.ClientWidth Div BASED_CLIENT_WIDTH
        Else
            Font.Size := BASED_START_BUTTON_FONT_SIZE * MainForm.ClientHeight Div BASED_CLIENT_HEIGHT;
    End;
End;


Procedure DrawSpeedBar(BoardImage: TImage; SpeedTrackBar: TTrackBar);
Begin
    With SpeedTrackBar Do
    Begin
        Height := BoardImage.Height;

        Left := BoardImage.Left + BoardImage.Width;
        Top := BoardImage.Top;
    End;
End;


Procedure DrawHorseStep(BoardImage, HorseFigureImage: TImage);
Var
    Col, Row: Integer;
Begin
    For Col := 0 To BOARD_CELLS_AMOUNT - 1 Do
        For Row := 0 To BOARD_CELLS_AMOUNT - 1 Do
            If Board[Col, Row] = MoveCount Then
            Begin
                DrawHorse(BoardImage, HorseFigureImage, Col, Row);
                With BoardImage.Canvas Do
                    TextOut(Col * CellSize + (CellSize - TextWidth(IntToStr(MoveCount))) Div 2 + BorderSize, Row * CellSize + (CellSize - TextHeight(IntToStr(MoveCount))) Div 2 + BorderSize, IntToStr(MoveCount));
                Inc(MoveCount);
                Exit;
            End;
End;

End.
