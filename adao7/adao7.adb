with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;

procedure adao7 is

    type List_Type;

    type List_Ptr is 
        access List_Type;

    type List_Type is 
        record
            I : Integer;
            NextPtr : List_Ptr;
        end record;

    function Empty(List : in List_Type) return Boolean is

    begin
        return List = null;
    end Empty;



begin

end adao7;