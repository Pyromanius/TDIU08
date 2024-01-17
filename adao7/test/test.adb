with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;

procedure test is

    type Element_Type;

    type List_Type is 
        access Element_Type;

    type Element_Type is 
        record
            I : Integer;
            V : Integer;
            NextPtr : List_Type;
        end record;

procedure Insert(I     :        Integer;
                 V     :        Integer;
                 L_New : in out List_Type) is
begin
    if L_New = null then
        L_New := new Element_Type'(I, V, null);
    else
        if L_New.NextPtr /= null then
            Insert(I, V, L_New.NextPtr);
        else
            L_New.NextPtr := new Element_Type'(I, V, null);
        end if;
    end if;
end Insert;

procedure Put(Element_Type : in      List_Type) is
begin
    if Element_Type /= null then
        Put("L nr ");
        Put(Element_Type.I, Width=>0);
        Put(": ");
        Put(Element_Type.V, Width=>0);
        New_Line;
        Put(Element_Type.NextPtr);
    else
        Put("----------");
    end if;
end Put;

    L : List_Type := null;
    N : Integer;

begin

    Put("Mata in L: ");
    for I in 1..3 loop
        Get(N);
        Insert(I, N, L);
    end loop;
    New_Line;

    Put(L);

end test;