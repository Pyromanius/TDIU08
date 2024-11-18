--Antgu873: Arbetat enskilt
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure phi_calc is

    function Fib (N : in     Integer) return Integer is
    begin
        if N = 1 or N = 2 then
            return 1;
        else
            return Fib(N - 1) + Fib(N - 2);
        end if;
    end Fib;

    function Pyramid (H : in     Integer) return Integer is
        X, N : Integer;
    begin
        if H = 0 then
            return 0;
        else
            N := H - 1;
            X := 3 + (N - 2) * 2;
            return N * X + (Pyramid(H-1));
        end if;
    end Pyramid;

    N, H : Integer;
begin
    Put("Mata in H");
    Get(N);
    Get(H);

    N := 1;
    Put("Fibonacci-tal nummer ");
    Put(N, Width=>1);
    Put(" är ");
    Put(Fib(N), Width=>1);
    Put(".");
    New_Line;

    Put("Det behövs ");
    Put(Pyramid(H), Width=>1);
    Put(" stenar för att bygga trappan.");
    New_Line;
end phi_calc;