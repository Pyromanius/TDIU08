with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;

procedure test is

    type List_Type;

    type List_Ptr is 
        access List_Type;

    type List_Type is 
        record
            I : Integer;
            NextPtr : List_Ptr;
        end record;

    procedure Insert(I     :        Integer;
                     L_New : in out List_Ptr) is

    begin

        if L_New = null then
                -- HÄR SKAPAS FÖRSTA PEKAREN --
            L_New := new List_Type'(I, null);
                Put("-------- Creating first pointer: ");
                Put(L_New.I, Width=>0);
                Put(" --------");
                New_Line(2);

        else
                -- HÄR SKAPAS FÖlJANDE PEKARE --
            Insert(I, L_New.NextPtr);
                Put("-------- Creating new pointer:   ");
                Put(L_New.I, Width=>0);
                Put(" --------");
                New_Line(2);
        end if;
    end Insert;

    procedure Put(List_Type : in      List_Ptr) is

    begin

        if List_Type /= null then
            Put("  L: ");
            Put(List_Type.I, Width=>0);
            New_Line;
            Put(List_Type.NextPtr);
        else
            Put("---------");
        end if;

    end Put;

        L : List_Ptr;
        N : Integer;

begin

    Put("Mata in L: ");

    loop
        begin
            Get(N);
            if N = -1 then
                exit;
            end if;
            Insert(N, L);
        end;
    end loop;
    
    New_Line;

    Put(L);

end test;