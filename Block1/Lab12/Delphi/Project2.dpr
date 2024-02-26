Program Project2;

Uses
    System.SysUtils;

Const
    MIN_N = 0;
    MAX_N = 1000;

Var
    N, I, Value1, Value2: Integer;
    IsIncorrect: Boolean;

Begin
    N := 0;
    Writeln('������ ��������� ���������, �������� �� ������� 1 + 2 + ... + N = N * (N + 1) / 2.');
    Writeln;

    IsIncorrect := True;
    While(IsIncorrect) Do
    Begin
        Write('������� ����������� ����� N(0; 1000) ��� ��������: ');
        Try
            Readln(N);
            IsIncorrect := False;
        Except
            Writeln('��������� ������������ ����� ������!');
        End;
        If (Not IsIncorrect And ((N <= MIN_N) Or (N >= MAX_N))) Then
        Begin
            Writeln('�������� �� �������� � ��������!');
            IsIncorrect := True;
        End;
    End;

    Value1 := 0;
    For I := 1 To N Do
         Value1 := Value1 + I;

    Value2 := N * (N + 1) Div 2;

    If (Value1 = Value2) Then
    Begin
        Writeln('������� ��������!');
    End
    Else
    Begin
        Writeln('������� �� ��������!');
    End;

    Readln;
End.
