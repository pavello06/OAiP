Unit BackEndUnit;

Interface

Procedure CalcMoves();

Implementation

Uses MainUnit;

Type
    TPosition = Record
        Col, Row: Integer;
    End;

Const
    Moves: Array [1 .. 8] Of TPosition = ((Col: 2; Row: 1), (Col: 1; Row: 2), (Col: -1; Row: 2), (Col: -2; Row: 1),
                                          (Col: -2; Row: -1), (Col: -1; Row: -2), (Col: 1; Row: -2), (Col: 2; Row: -1));

Procedure InitializeBoard();
Var
    Col, Row: Integer;
Begin
    For Col := 0 To BOARD_CELLS_AMOUNT - 1 Do
        For Row := 0 To BOARD_CELLS_AMOUNT - 1 Do
            Board[Col, Row] := 0;
End;

Function IsInsideBoard(Col, Row: Integer): Boolean;
Begin
    Result := (Col >= 0) And (Col < BOARD_CELLS_AMOUNT) And (Row >= 0) And (Row < BOARD_CELLS_AMOUNT);
End;

Function IsNotVisited(Col, Row: Integer): Boolean;
Begin
    Result := Board[Col, Row] = 0;
End;

Function CountAvailableMoves(Col, Row: Integer): Integer;
Var
    MoveIndex, NextCol, NextRow: Integer;
Begin
    Result := 0;
    For MoveIndex := Low(Moves) To High(Moves) Do
    Begin
        NextCol := Col + Moves[MoveIndex].Col;
        NextRow := Row + Moves[MoveIndex].Row;
        If IsInsideBoard(NextCol, NextRow) And IsNotVisited(NextCol, NextRow) Then
            Inc(Result);
    End;
End;

Function FindNextOptimalMove(Col, Row: Integer): TPosition;
Var
    MoveIndex, NextCol, NextRow, MinMoves, MinMovesIndex: Integer;
Begin
    MinMoves := Length(Moves) + 1;
    MinMovesIndex := -1;

    For MoveIndex := Low(Moves) To High(Moves) Do
    Begin
        NextCol := Col + Moves[MoveIndex].Col;
        NextRow := Row + Moves[MoveIndex].Row;
        If IsInsideBoard(NextCol, NextRow) And IsNotVisited(NextCol, NextRow) Then
        Begin
            If CountAvailableMoves(NextCol, NextRow) < MinMoves Then
            Begin
                MinMoves := CountAvailableMoves(NextCol, NextRow);
                MinMovesIndex := MoveIndex;
            End;
        End;
    End;

    NextCol := Col + Moves[MinMovesIndex].Col;
    NextRow := Row + Moves[MinMovesIndex].Row;
    Result.Col := NextCol;
    Result.Row := NextRow;
End;

Procedure KnightTour(Col, Row, MoveCount: Integer);
Var
    NextPosition: TPosition;
    NextCol, NextRow: Integer;
Begin
    Board[Col, Row] := MoveCount;

    If MoveCount = BOARD_CELLS_AMOUNT * BOARD_CELLS_AMOUNT Then
        Exit;

    NextPosition := FindNextOptimalMove(Col, Row);
    NextCol := NextPosition.Col;
    NextRow := NextPosition.Row;

    KnightTour(NextCol, NextRow, MoveCount + 1);
End;


Procedure CalcMoves();
Begin
    InitializeBoard();
    KnightTour(CurrentCol, CurrentRow, 1);
End;

End.
