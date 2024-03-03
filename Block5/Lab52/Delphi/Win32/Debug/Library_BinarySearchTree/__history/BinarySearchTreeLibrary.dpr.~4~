Library BinarySearchTreeLibrary;

uses
  SysUtils,
  Vcl.Graphics,
  Vcl.ExtCtrls;

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
                                             'Слишком много узлов');

    MAX_DEPTH = 7;
    DEGREES_OF_TWO: Array [0 .. (MAX_DEPTH - 1)] Of Integer = (1, 2, 4, 8, 16, 32, 64);
    Diametr = 50;

Var
    Root: TBinarySearchTree;
    Depth: Integer = 0;
    SingleParentLevels: Array[1..7] Of Integer;

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

Procedure Make(Data: TData);
Begin
    New(Root);
    Root.Data := Data;
    Root.Left := Nil;
    Root.Right := Nil;
    Depth := 1;
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
                Dispose(BinarySearchTree);
        End;
    End;
    RemoveNode := BinarySearchTree;
End;

Procedure RemoveFirstNode(Var Error: ERRORS_CODE);
Begin
    Error := CORRECT;
    If Root = Nil Then
        Error := NOT_EXIST_NODE
    Else
    Begin
        If (Root.Left <> Nil) And (Root.Right <> Nil) Then
        Begin
            Root.Data := FindMinNode(Root.Right).Data;
            Root.Right := RemoveNode(Root.Right, Root.Data);
        End
        Else
        Begin
            If Root.Left <> Nil Then
                Root := Root.Left
            Else If Root.Right <> Nil Then
                Root := Root.Right
            Else
                Dispose(Root);
        End;
        Depth := FindDepth(Root);
    End;
End;

Procedure Remove(Data: TData; Var Error: ERRORS_CODE);
Begin
    Error := CORRECT;
    If Root = Nil Then
        Error := NOT_EXIST_NODE
    Else
    Begin
        If (FindNode(Root, Data) = Nil) Then
            Error := NOT_EXIST_NODE
        Else
        Begin
            RemoveNode(Root, Data);
            Depth := FindDepth(Root);
        End;
    End;
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

Procedure Insert(Data: TData; Var Error: ERRORS_CODE);
Begin
    Error := CORRECT;
    If FindNode(Root, Data) = Nil Then
    Begin
        InsertNode(Root, Data);
        Depth := FindDepth(Root);
        If Depth > MAX_DEPTH Then
        Begin
            Remove(Data, Error);
            Error := TOO_MANY_NODES;
        End;
    End
    Else
        Error := ALREADY_INSERT_NODE;
End;

Procedure FindSingleParentLevels(Root: TBinarySearchTree; Level: Integer);
Begin
    If Root <> Nil Then
    Begin
        FindSingleParentLevels(Root.Left, Level + 1);
        FindSingleParentLevels(Root.Right, Level + 1);
        If (Root.Left <> Nil) Or (Root.Right <> Nil) Then
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

Procedure Draw(PaintBox: TPaintBox);
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
        DrawBinarySearchTree(Root, PaintBox, XRoot, YRoot, Depth);
    End;
End;



Procedure Clear(Root: TBinarySearchTree);
Begin
    If Root <> Nil Then
    Begin
        Clear(Root.Left);
        Clear(Root.Right);
        Dispose(Root);
    End;
End;

End.
