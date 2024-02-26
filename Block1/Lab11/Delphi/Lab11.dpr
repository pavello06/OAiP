Program Lab11;
uses
  System.SysUtils;

Const
    MIN_R = 1;
    MIN_XY = -1000000;
    MAX_ALL = 1000000;
    EPS = 0.0000001;
Var
    R, X, Y: Real;
    OnCircle: Char;
    IsCorrect: Boolean;
Begin
    R := 0;
    X := 0;
    Y := 0;
    IsCorrect := True;
    Writeln('������ ��������� ���������, ��������� �� ����� � ������������ (X; Y) �� ���������� �������� R � ������� � ������ ���������.');
    Writeln;
    Repeat
        Write('������� ������ ���������� R[1; 100000]: ');
        Try
            Readln(R);
            IsCorrect := True;
        Except
            Writeln('��������� ������������ ����� ������!');
            IsCorrect := False;
        End;
        If (IsCorrect And ((R < MIN_R) Or (R > MAX_ALL))) Then
        Begin
            Writeln('�������� �� �������� � ��������!');
            IsCorrect := False;
        End;
    Until IsCorrect;
    Repeat
        Write('������� ���������� X[-100000; 100000] �����: ');
        Try
            Readln(X);
            IsCorrect := True;
        Except
            Writeln('��������� ������������ ����� ������!');
            IsCorrect := False;
        End;
        If (IsCorrect And ((X < MIN_XY) Or (X > MAX_ALL))) Then
        Begin
            Writeln('�������� �� �������� � ��������!');
            IsCorrect := False;
        End;
    Until IsCorrect;
    Repeat
        Write('������� ���������� Y[-100000; 100000] �����: ');
        Try
            Readln(Y);
            IsCorrect := True;
        Except
            Writeln('��������� ������������ ����� ������!');
            IsCorrect := False;
        End;
        If (IsCorrect And ((Y < MIN_XY) Or (Y > MAX_ALL))) Then
        Begin
            Writeln('�������� �� �������� � ��������!');
            IsCorrect := False;
        End;
    Until IsCorrect;
    R := Round(R * 1000) / 1000;
    X := Round(X * 1000) / 1000;
    Y := Round(Y * 1000) / 1000;
    If (abs(R * R - X * X + Y * Y) < EPS) Then
    Begin
        Writeln('����� ����������� ����������');
        OnCircle := 'T';
    End
    Else
    Begin
        Writeln('����� �� ����������� ����������');
        OnCircle := 'F';
    End;
    Readln;
End.
