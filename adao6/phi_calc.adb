--Antgu873: Arbetat enskilt
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure phi_calc is
    N, H : Integer;

    function Fib (N : in     Integer) return Integer is
        Fib1, Fib2 : Integer := 1;
        Fib3 : Integer := 2;
    begin
        if N = 3 then
            return Fib3;
        elsif N = 2 then
            return Fib2;
        elsif N = 1 then
            return Fib1;
        end if;

        for I in 3..N loop
            Fib3 := Fib1 + Fib2;
            Fib1 := Fib2;
            Fib2 := Fib3;
        end loop;

        return Fib3;
    end Fib;

    function Pyramid (H : in     integer) return Integer is

        X : Integer := 1;

    begin
        if H = 0 then
            return 0;
        end if;

        X := 3 + (H - 2) * 2;

        return H * X + Pyramid(H - 1);
    end Pyramid;

begin
    Put("Mata in N och H: ");
    Get(N);
    Get(H);

    Put("Fibonacci-tal nummer ");
    Put(N, Width=>1);
    Put(" är ");
    Put(Fib(N), Width=>1);
    Put(".");

    New_Line;

    Put("Det behövs ");
    Put(Pyramid(H-1), Width=>1);
    Put(" stenar för att bygga trappan.");

    New_Line;

end phi_calc;