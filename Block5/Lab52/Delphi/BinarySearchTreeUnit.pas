Unit BinarySearchTreeUnit;

Interface

Uses
    SysUtils, Vcl.Graphics, Vcl.ExtCtrls;

Type
    TData = Integer;
    TBinarySearchTree = ^TNode;

    TNode = Record
        Data: TData;
        Left, Right: TBinarySearchTree;
    End;

    ERRORS_CODE = (CORRECT,
                   ALREADY_INSERT_NODE,
                   NOT_EXIST_NODE,
                   TOO_MANY_NODES);

Const
    ERRORS: Array [ERRORS_CODE] Of String = ('',
                                             'Узел уже добавлен!',
                                             'Узел не существует',
                                             'Слишком большая глубина!');

    MAX_DEPTH = 7;
    DEGREES_OF_TWO: Array [0 .. (MAX_DEPTH - 1)] Of Integer = (1, 2, 4, 8, 16, 32, 64);
    Diametr = 50;

Var
    Depth: Integer = 0;
    SingleParentLevels: Array[1..7] Of Integer;

Procedure Make(Var BinarySearchTree: TBinarySearchTree; Data: TData);
Procedure Insert(BinarySearchTree: TBinarySearchTree; Data: TData; Var Error: ERRORS_CODE);
Procedure RemoveFirstNode(Var BinarySearchTree: TBinarySearchTree; Var Error: ERRORS_CODE);
Procedure Remove(BinarySearchTree: TBinarySearchTree; Data: TData; Var Error: ERRORS_CODE);
Procedure FindSingleParentLevels(BinarySearchTree: TBinarySearchTree; Level: Integer);
Procedure Draw(BinarySearchTree: TBinarySearchTree; PaintBox: TPaintBox);
Procedure Clear(Var BinarySearchTree: TBinarySearchTree);

Implementation

Function FindDepth(BinarySearchTree: TBinarySearchTree): Integer;
Var
    LeftDepth, RightDepth: Integer;
Begin
    If BinarySearchTree = Nil Then
        Result := 0
    Else
    Begin
        LeftDepth := FindDepth(BinarySearchTree.Left);
        RightDepth := FindDepth(BinarySearchTree.Right);
        If LeftDepth > RightDepth Then
            Result := LeftDepth + 1
        Else
            Result := RightDepth + 1;
    End;
End;

Function FindNode(BinarySearchTree: TBinarySearchTree; Data: TData) : TBinarySearchTree;
Begin
    If (BinarySearchTree = Nil) Or (BinarySearchTree.Data = Data) Then
        FindNode := BinarySearchTree
    Else If Data < BinarySearchTree.Data Then
        FindNode := FindNode(BinarySearchTree.Left, Data)
    Else
        FindNode := FindNode(BinarySearchTree.Right, Data)
End;

Procedure Make(Var BinarySearchTree: TBinarySearchTree; Data: TData);
Begin
    New(BinarySearchTree);
    BinarySearchTree.Data := Data;
    BinarySearchTree.Left := Nil;
    BinarySearchTree.Right := Nil;
    Depth := 1;
End;

Procedure InsertNode(BinarySearchTree: TBinarySearchTree; Data: TData);
Begin
    If (BinarySearchTree.Left = Nil) And (Data < BinarySearchTree.Data) Or
        (BinarySearchTree.Right = Nil) And (Data > BinarySearchTree.Data) Then
    Begin
        If Data < BinarySearchTree.Data Then
        Begin
            New(BinarySearchTree.Left);
            BinarySearchTree := BinarySearchTree.Left;
        End
        Else
        Begin
            New(BinarySearchTree.Right);
            BinarySearchTree := BinarySearchTree.Right;
        End;
        BinarySearchTree.Data := Data;
        BinarySearchTree.Left := Nil;
        BinarySearchTree.Right := Nil;
    End
    Else If Data < BinarySearchTree.Data Then
        InsertNode(BinarySearchTree.Left, Data)
    Else
        InsertNode(BinarySearchTree.Right, Data);
End;

Procedure Insert(BinarySearchTree: TBinarySearchTree; Data: TData; Var Error: ERRORS_CODE);
Begin
    Error := CORRECT;
    If FindNode(BinarySearchTree, Data) = Nil Then
    Begin
        InsertNode(BinarySearchTree, Data);
        Depth := FindDepth(BinarySearchTree);
        If Depth > MAX_DEPTH Then
        Begin
            Remove(BinarySearchTree, Data, Error);
            Error := TOO_MANY_NODES;
        End;
    End
    Else
        Error := ALREADY_INSERT_NODE;
End;

Function FindMinNode(BinarySearchTree: TBinarySearchTree): TBinarySearchTree;
Begin
    While BinarySearchTree.Left <> Nil Do
        BinarySearchTree := BinarySearchTree.Left;
    FindMinNode := BinarySearchTree;
End;

Function RemoveNode(BinarySearchTree: TBinarySearchTree; Data: TData) : TBinarySearchTree;
Begin
    If BinarySearchTree <> Nil Then
    Begin
        If Data < BinarySearchTree.Data Then
            BinarySearchTree.Left := RemoveNode(BinarySearchTree.Left, Data)
        Else If Data > BinarySearchTree.Data Then
            BinarySearchTree.Right := RemoveNode(BinarySearchTree.Right, Data)
        Else If (BinarySearchTree.Left <> Nil) And (BinarySearchTree.Right <> Nil) Then
        Begin
            BinarySearchTree.Data := FindMinNode(BinarySearchTree.Right).Data;
            BinarySearchTree.Right := RemoveNode(BinarySearchTree.Right, BinarySearchTree.Data);
        End
        Else
        Begin
            If BinarySearchTree.Left <> Nil Then
                BinarySearchTree := BinarySearchTree.Left
            Else If BinarySearchTree.Right <> Nil Then
                BinarySearchTree := BinarySearchTree.Right
            Else
                BinarySearchTree := Nil;
        End;
    End;
    RemoveNode := BinarySearchTree;
End;

Procedure RemoveFirstNode(Var BinarySearchTree: TBinarySearchTree; Var Error: ERRORS_CODE);
Begin
    Error := CORRECT;
    If BinarySearchTree = Nil Then
        Error := NOT_EXIST_NODE    
    Else
    Begin
        If (BinarySearchTree.Left <> Nil) And (BinarySearchTree.Right <> Nil) Then
        Begin
            BinarySearchTree.Data := FindMinNode(BinarySearchTree.Right).Data;
            BinarySearchTree.Right := RemoveNode(BinarySearchTree.Right, BinarySearchTree.Data);
        End
        Else
        Begin
            If BinarySearchTree.Left <> Nil Then
                BinarySearchTree := BinarySearchTree.Left
            Else If BinarySearchTree.Right <> Nil Then
                BinarySearchTree := BinarySearchTree.Right
            Else
                BinarySearchTree := Nil;
        End;
        Depth := FindDepth(BinarySearchTree);
    End;
End;

Procedure Remove(BinarySearchTree: TBinarySearchTree; Data: TData; Var Error: ERRORS_CODE);
Begin
    Error := CORRECT;
    If BinarySearchTree = Nil Then
        Error := NOT_EXIST_NODE    
    Else
    Begin
        If (FindNode(BinarySearchTree, Data) = Nil) Then
            Error := NOT_EXIST_NODE
        Else
        Begin
            RemoveNode(BinarySearchTree, Data);
            Depth := FindDepth(BinarySearchTree);
        End;
    End;
End;

Procedure FindSingleParentLevels(BinarySearchTree: TBinarySearchTree; Level: Integer);
Begin
    If BinarySearchTree <> Nil Then
    Begin
        FindSingleParentLevels(BinarySearchTree.Left, Level + 1);
        FindSingleParentLevels(BinarySearchTree.Right, Level + 1);
        If (BinarySearchTree.Left <> Nil) Or (BinarySearchTree.Right <> Nil) Then
            Inc(SingleParentLevels[Level]);
    End;
End;



Procedure DrawBinarySearchTree(BinarySearchTree: TBinarySearchTree; PaintBox: TPaintBox; X, Y, Depth: Integer);
Var
    Offset: Integer;
Begin
    If BinarySearchTree <> Nil Then
    Begin
        With PaintBox.Canvas Do
        Begin
            Dec(Depth);
            Offset := 0;
            If Depth <> 0 Then
                Offset := DEGREES_OF_TWO[Depth - 1] * Diametr;
            If BinarySearchTree.Left <> Nil Then
            Begin
                MoveTo(X + Diametr Div 2, Y + Diametr Div 2);
                LineTo(X - Offset + Diametr Div 2, Y + Diametr + Diametr Div 2 + 20);
            End;
            If BinarySearchTree.Right <> Nil Then
            Begin
                MoveTo(X + Diametr Div 2, Y + Diametr Div 2);
                LineTo(X + Offset + Diametr Div 2, Y + Diametr + Diametr Div 2 + 20);
            End;
            Ellipse(X, Y, X + Diametr, Y + Diametr);
            TextOut(X + (Diametr - TextWidth(IntToStr(BinarySearchTree.Data)))
                    Div 2, Y +
                    (Diametr - TextHeight(IntToStr(BinarySearchTree.Data)))
                    Div 2, IntToStr(BinarySearchTree.Data));
            Inc(Y, Diametr + 20);
            DrawBinarySearchTree(BinarySearchTree.Left, PaintBox, X - Offset, Y, Depth);
            DrawBinarySearchTree(BinarySearchTree.Right, PaintBox, X + Offset, Y, Depth);
        End;
    End;
End;

Procedure Draw(BinarySearchTree: TBinarySearchTree; PaintBox: TPaintBox);
Var
    XRoot, YRoot: Integer;
Begin
    With PaintBox.Canvas Do
    Begin
        Pen.Color := clBlack;
        FillRect(ClipRect);
        XRoot := 0;
        If Depth <> 0 Then
            XRoot := (DEGREES_OF_TWO[Depth - 1] - 1) * Diametr;
        YRoot := 0;
        PaintBox.Width := 2 * XRoot + Diametr + 20;
        PaintBox.Height := (Depth + 20) * Diametr + 20;
        DrawBinarySearchTree(BinarySearchTree, PaintBox, XRoot, YRoot, Depth);
    End;
End;



Procedure Clear(Var BinarySearchTree: TBinarySearchTree);
Begin
    If BinarySearchTree <> Nil Then
    Begin
        Clear(BinarySearchTree.Left);
        Clear(BinarySearchTree.Right);
        BinarySearchTree := Nil;
        Dispose(BinarySearchTree);
    End;
End;

End.
