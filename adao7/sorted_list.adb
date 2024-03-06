
package body sorted_list is

    function Empty(L : in List_Ptr) return Boolean is
    begin
        if List = null then
            return true;
        else 
            return false;
        end if;

    end Empty;

    procedure Put(L : in List_Ptr) is
    begin
        
        if not Empty(L) then
            Put(L.I, Width=>0);
            Put(" ");
            Put(L.NextPtr);
        end if;
    end Put;

    function Length(L : in List_Ptr) return Integer is

    begin
        if Empty(L) then
            return 0;
        end if;

        return 1 + Length(L.NextPtr);
    end Length;

    function Member(L : in List_Ptr;
                    N : in Integer) return Boolean is

    begin
        if Empty(L) then
            return false;
        elsif N = L.I then
            return true;
        end if;

        return Member(N, L.NextPtr);
    end Member;

    procedure Free is new Ada.Unchecked_Deallocation(List_Type, List_Ptr);

    procedure Remove(L : in out List_Ptr;
                     N : in     Integer) is

        Temp_List : List_Ptr;

    begin
        if not Empty(L) then
            if N = L.I then
                Temp_List := L.NextPtr;
                Free(L);
                L := Temp_List;
            else
                Remove(N, L.NextPtr);
            end if;
        end if;        
    end Remove;

    procedure Delete(L : in out List_Ptr) is

    begin
	    if not Empty(L) then
	        Delete(L.NextPtr);
	        Free(L);
        end if; 
    end Delete;

    procedure Insert(L : in out List_Ptr;
                     N :        Integer) is

        Temp_List : List_Ptr;
    
    begin

        if L = null then
            L := new List_Type'(N, null);
        else
            if N > L.I then
                Insert(N, L.NextPtr);
            elsif N < L.I then
                if Temp_List = null then
                    Temp_List := new List_Type'(N, null);
                end if;
                Temp_List.I := N;
                Temp_List.NextPtr := L;
                L := Temp_List;
            end if;
        end if;
    end Insert;

end sorted_list;