Library LinkedList;

{$R *.res}

uses
  Vcl.Grids;

Const
    MAX_LENGTH = 13;

Type
    TLimitedString = String[MAX_LENGTH];

    TLinkedList = ^TNode;
    TNode = Record
        Data: TLimitedString;
        Next: TLinkedList;
    End;

Var
    List, Head: TLinkedList;

Procedure Make();
Begin
    New(Head);
    Head.Next := Nil;
End;

Procedure Add(Data: TLimitedString);
Begin
    List := Head;
    While List.Next <> Nil Do
        List := List.Next;
    New(List.Next);
    List := List.Next;
    List.Data := Data;
    List.Next := Nil;
End;

Procedure Remove(Number: Integer);
Var
    I: Integer;
    Rem: TLinkedList;
Begin
    List := Head;
    For I := 1 To Number - 1 Do
        List := List.Next;
    Rem := List.Next;
    List.Next := List.Next.Next;
    Dispose(Rem);
End;

Procedure Reverse();
Var
    PreviousNode, CurrentNode, NextNode: TLinkedList;
Begin
    PreviousNode := Nil;
    CurrentNode := Head.Next;
    While CurrentNode <> Nil Do
    Begin
        NextNode := CurrentNode.Next;
        CurrentNode.Next := PreviousNode;
        PreviousNode := CurrentNode;
        CurrentNode := NextNode;
    End;
    Head.Next  := PreviousNode;
End;

Procedure Clear();
Var
    Rem: TLinkedList;
Begin
    Rem := Head.Next;
    While Rem <> Nil Do
    Begin
        List := Rem.Next;
        Dispose(Rem);
        Rem := List;
    End;
    Head.Next := Nil;
End;

Procedure WriteLinkedList(StringGrid: TStringGrid);
Var
    I: Integer;
Begin
    List := Head.Next;
    I := 1;
    While List <> Nil Do
    Begin
        StringGrid.Cells[0, I] := String(List.Data);
        List := List.Next;
        Inc(I);
    End;
End;

Exports
    Make, Add, Remove, Reverse, Clear, WriteLinkedList;

Begin
End.
