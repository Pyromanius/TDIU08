--Antgu873: Arbetat enskilt
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure phi_calc is

        N, H : Integer;

    function Fib (N : in     Integer) return Integer is

    begin
        if N = 1 or N = 2 then
            return 1;
        else
            return Fib(N - 1) + Fib(N - 2);
        end if;
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