Program Project4;

Uses
  System.SysUtils;

Const
    MIN_H = 1;
    MIN_ALL = -1000;
    MAX_ALL = 1000;
Var
    I, Length: Integer;
    X0, Xn, X, H, Y, A, B, C: Real;
    ArrX, ArrY: Array of Real;
    IsIncorrect: Boolean;

Begin
    X0 := 0;
    Xn := 0;
    H := 0;
    A := 0;
    B := 0;
    C := 0;
    Writeln('������ ��������� ������� �������� ������� Y = A*X^2 + B*X + C, �� X0 �� Xn � ����� H.');
    Writeln;

    IsIncorrect := True;
    While (IsIncorrect) Do
    Begin
        Write('������� �������� X0[-1000; 1000]: ');
        Try
            Readln(X0);
            IsIncorrect := False;
        Except
            Writeln('��������� ������������ ����� ������!');
        End;
        If (Not IsIncorrect And ((X0 < MIN_ALL) Or (X0 > MAX_ALL))) Then
        Begin
            Writeln('�������� �� �������� � ��������!');
            IsIncorrect := True;
        End;
    End;
    IsIncorrect := True;
    While (IsIncorrect) Do
    Begin
        Write('������� �������� Xn (�������� Xn[-1000; 1000] ������ ���� ������ ��� X0): ');
        Try
            Readln(Xn);
            IsIncorrect := False;
        Except
            Writeln('��������� ������������ ����� ������!');
        End;
        If (Not IsIncorrect And ((X0 > Xn) Or ((Xn < MIN_ALL) Or (Xn > MAX_ALL)))) Then
        Begin
            Writeln('�������� �� �������� � ��������!');
            IsIncorrect := True;
        End;
    End;
    IsIncorrect := True;
    While (IsIncorrect) Do
    Begin
        Write('������� ��� H[1; 1000]: ');
        Try
            Readln(H);
            IsIncorrect := False;
        Except
            Writeln('��������� ������������ ����� ������!');
        End;
        If (Not IsIncorrect And ((H < MIN_H) Or (H > MAX_ALL))) Then
        Begin
            Writeln('�������� �� �������� � ��������!');
            IsIncorrect := True;
        End;
    End;
    IsIncorrect := True;
    While (IsIncorrect) Do
    Begin
        Write('������� ����������� A[-1000; 1000]: ');
        Try
            Readln(A);
            IsIncorrect := False;
        Except
            Writeln('��������� ������������ ����� ������!');
        End;
        If (Not IsIncorrect And ((A < MIN_ALL) Or (A > MAX_ALL))) Then
        Begin
            Writeln('�������� �� �������� � ��������!');
            IsIncorrect := True;
        End;
    End;
    IsIncorrect := True;
    While (IsIncorrect) Do
    Begin
        Write('������� ����������� B[-1000; 1000]: ');
        Try
            Readln(B);
            IsIncorrect := False;
        Except
            Writeln('��������� ������������ ����� ������!');
        End;
        If (Not IsIncorrect And ((B < MIN_ALL) Or (B > MAX_ALL))) Then
        Begin
            Writeln('�������� �� �������� � ��������!');
            IsIncorrect := True;
        End;
    End;
    IsIncorrect := True;
    While (IsIncorrect) Do
    Begin
        Write('������� ����������� C[-1000; 1000]: ');
        Try
            Readln(C);
            IsIncorrect := False;
        Except
            Writeln('��������� ������������ ����� ������!');
        End;
        If (Not IsIncorrect And ((C < MIN_ALL) Or (C > MAX_ALL))) Then
        Begin
            Writeln('�������� �� �������� � ��������!');
            IsIncorrect := True;
        End;
    End;

    Length := Round((Xn - X0 + 1) / H);
    Setlength(ArrX, Length);
    Setlength(ArrY, Length);

    X := X0;

    For I := Low(ArrX) To High(ArrX) Do
    Begin
      Y := A * X * X + B * X + C;
      ArrX[I] := X;
      ArrY[I] := Y;
      Writeln('X: ', Round(ArrX[I]), '; Y: ', Round(ArrY[I]));
      X := X + H;
    End;

    Readln;
End.
