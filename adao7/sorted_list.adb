with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;

package body sorted_list is
    function Empty(L : in List_Type) return Boolean is
    begin
        if L = null then
            return true;
        else 
            return false;
        end if;
    end Empty;

    procedure Put(L : in List_Type) is
    begin
        if not Empty(L) then
            Put(" ");
            Put(L.I, Width=>0);
            Put(L.NextPtr);
        end if;
    end Put;

    function Length(L : in List_Type) return Integer is
    begin
        if Empty(L) then
            return 0;
        end if;

        return 1 + Length(L.NextPtr);
    end Length;

    function Member(L : in List_Type;
                    N : in Integer) return Boolean is
    begin
        if Empty(L) then
            return false;
        elsif N = L.I then
            return true;
        end if;

        return Member(L.NextPtr, N);
    end Member;

    procedure Free is new Ada.Unchecked_Deallocation(Elemental_Type, List_Type);

    procedure Remove(L : in out List_Type;
                     N : in     Integer) is
        Temp_List : List_Type;
    begin
        if not Empty(L) then
            if N = L.I then
                Temp_List := L.NextPtr;
                Free(L);
                L := Temp_List;
            elsif N /= L.I then
                Remove(L.NextPtr, N);
            end if;

            if L.NextPtr = null then
                raise No_Such_Element_Error;
            end if;
        end if;        
    end Remove;

    procedure Delete(L : in out List_Type) is
    begin
	    if not Empty(L) then
	        Delete(L.NextPtr);
	        Free(L);
        end if; 
    end Delete;

    procedure Insert(L : in out List_Type;
                     N :        Integer) is
        Temp_List : List_Type;   
    begin
        if L = null then
            L := new Elemental_Type'(N, null);
        else
            if N > L.I then
                Insert(L.NextPtr, N);
            elsif N < L.I then
                if Temp_List = null then
                    Temp_List := new Elemental_Type'(N, null);
                end if;
                Temp_List.I := N;
                Temp_List.NextPtr := L;
                L := Temp_List;
            end if;
        end if;
    end Insert;
end sorted_list;