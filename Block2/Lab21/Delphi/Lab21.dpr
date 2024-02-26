Program Lab21;
Uses
    System.SysUtils;
Var
    Arr: Array Of Integer;
    Length, I, CountOfOdd: Integer;
    IsIncorrect: Boolean;
Const
    MIN_L = 1;
    MAX_L = 10000;
    MIN_ARR_EL = -1000000;
    MAX_ARR_EL = 1000000;
Begin
    Writeln('������ ��������� ������������ ����� �������� ����� � �������� � ������� ����������� ��������.');
    Writeln;
    IsIncorrect := True;
    While (IsIncorrect) Do
    Begin
        Write('������� ����� ��������� � �������[1; 10000]: ');
        Try
            Readln(Length);
            IsIncorrect := False;
        Except
            Writeln('��������� ������������ ����� ������!');
        End;
        If (Not IsIncorrect And ((Length < MIN_L) Or (Length > MAX_L))) Then
        Begin
            Writeln('�������� �� �������� � ��������!');
            IsIncorrect := True;
        End;
    End;
    SetLength(Arr, Length);
    For I := Low(Arr) To High(Arr) Do
    Begin
        IsIncorrect := True;
        While (IsIncorrect) Do
        Begin
            Write('������� ', I + 1, ' ������� �������[-1000000; 1000000]: ');
            Try
                Readln(Arr[I]);
                IsIncorrect := False;
            Except
                Writeln('��������� ������������ ����� ������!');
            End;
            If (Not IsIncorrect And ((Arr[I] < MIN_ARR_EL) Or (Arr[I] > MAX_ARR_EL))) Then
            Begin
                Writeln('�������� �� �������� � ��������!');
                IsIncorrect := True;
            End;
        End;
    End;
    I := 1;
    CountOfOdd := 0;
    While (I < Length) Do
    Begin
        If (Arr[I] Mod 2 = 1) Then
            Inc(CountOfOdd);
        Inc(I, 2);
    End;
    Arr := Nil;
    Writeln;
    Write('����� �������� ����� � ������� � ������� ����������� ��������: ', CountOfOdd);
    Readln;
End.
