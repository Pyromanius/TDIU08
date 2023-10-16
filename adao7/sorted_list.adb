--Antgu873: Arbetat enskilt
with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;

package body sorted_list is

    function Empty(List : in List_Type) return Boolean is

    begin
        return List = null;
    end Empty;
      
    procedure Insert(List : in out List_Type; Input : in Integer) is

        procedure InsertProcess(List : in out List_Type; Input : in Integer) is
	        Tmp : List_Type;
        begin
            Tmp := new E_Type;
            Tmp.Data := Input;
            Tmp.Next := List;
            List := Tmp; 
	        --List := new E_Type'(Tmp, Input);
        end InsertProcess;

    begin
        if Empty(List) then
            InsertProcess(List, Input);
        elsif Input < List.Data then
            InsertProcess(List, Input);
        elsif Input /= List.Data then
            Insert(List.Next, Input);
        end if;
    end Insert;
      
    procedure Put(List : in List_Type) is

    begin
        if not Empty(List) then
            Put(List.Data, Width=>0);
            New_Line;
            Put(List.Next);
        end if;
    end Put;
      
    function Length(List : in List_Type) return Integer is

    begin
	    if Empty(List) then
	        return 0;
        end if;
        
        return 1 + Length(List.Next);
    end Length;
      
    function Member(List : in List_Type; SearchString : in Integer) return Boolean is
    
    begin
        if Empty(List) then
            return False;
        elsif List.Data = SearchString then
            return True;
        end if;
        
        return Member(List.Next, SearchString);
    end Member;
      
    procedure Free is new Ada.Unchecked_Deallocation(E_Type, List_Type);
      
    procedure Remove(List : in out List_Type; SearchString : in Integer) is

        Tmp : List_Type;

    begin
	    if not Empty(List) then
            if List.Data = SearchString then
                Tmp := List.Next;
                Free(List);
                List := Tmp;
            else
               Remove(Item.Next, Input);
            end if;
	    end if;
    end Remove;
   
    procedure Delete(List : in out List_Type) is

    begin
	    if not Empty(List) then
	        Delete(List.Next);
	        Free(List);
        end if; 
    end Delete;

--  exception
--      when No_Such_Element_Error =>
--          Put("Felaktigt element angivet, programmet avslutas.");

end sorted_list;