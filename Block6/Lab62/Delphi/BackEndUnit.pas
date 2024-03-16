Unit BackEndUnit;

Interface

Procedure CalcMoves();

Implementation

Uses MainUnit;

Type
    TPosition = Record
        Col, Row: Integer;
    End;

Var
    Moves: Array [1 .. 8] Of TPosition = ((Col: 2; Row: 1), (Col: 1; Row: 2), (Col: -1; Row: 2), (Col: -2; Row: 1),
                                          (Col: -2; Row: -1), (Col: -1; Row: -2), (Col: 1; Row: -2), (Col: 2; Row: -1));

Procedure InitializeField();
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

Function CalcAvailableMoves(Col, Row: Integer): Integer;
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

Function CalcNextMove(Col, Row: Integer): TPosition;
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
            If CalcAvailableMoves(NextCol, NextRow) < MinMoves Then
            Begin
                MinMoves := CalcAvailableMoves(NextCol, NextRow);
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
    NextCol, NextRow: Integer;
Begin
    Board[Col, Row] := MoveCount;

    If MoveCount = BOARD_CELLS_AMOUNT * BOARD_CELLS_AMOUNT Then
        Exit;

    NextCol := CalcNextMove(Col, Row).Col;
    NextRow := CalcNextMove(Col, Row).Row;

    KnightTour(NextCol, NextRow, MoveCount + 1);
End;

Procedure CalcMoves();
Begin
    InitializeField();
    KnightTour(CurrentCol, CurrentRow, 1);
End;

End.
