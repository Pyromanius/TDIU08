with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with sorted_list;           use sorted_list;

procedure adao7 is

    type List_Type;

    type List_Ptr is 
        access List_Type;

    type List_Type is 
        record
            I : Integer;
            NextPtr : List_Ptr;
        end record;

    function Empty(List : in List_Ptr) return Boolean is
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

    function Member(N : in Integer;
                    L : in List_Ptr) return Boolean is

    begin
        if Empty(L) then
            return false;
        elsif N = L.I then
            return true;
        end if;

        return Member(N, L.NextPtr);
    end Member;

    procedure Free is new Ada.Unchecked_Deallocation(List_Type, List_Ptr);

    procedure Remove(N : in     Integer;
                     L : in out List_Ptr) is

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

    procedure Insert(N :        Integer;
                     L : in out List_Ptr) is

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

--###################--
--    HUVUDPROGRAM   --
--###################--

        L : List_Ptr;
        N : Integer;

begin
    Put("Mata in heltal. Avsluta med -1: ");

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
    Put("Listan innehåller nu elementen ");
    Put(L);
    New_Line;
    Put("Listan är ");
        if Length(L) /= 0 then
            Put("inte ");
        end if;
    Put("tom.");
    New_Line;

    for X in 0..1 loop
        Put("Mata in ett ");
        if X = 1 then
            Put("till ");
        end if;
        Put("värde: ");
        Get(N);
        Put("Listan innehåller ");
            if not Member(N, L) then
                Put("inte ");
            end if;
        Put("värdet ");
        Put(N, Width=>0);
        Put(".");
        New_Line;
    end loop;

    Put("Mata in ett värde att ta bort: ");
    Get(N);
    Remove(N, L);

    Put("Listan innehåller elementen ");
    Put(L);
    New_Line;
    Put("Listan innehåller nu ");
    Put(Length(L), Width=>0);
    Put(" element.");
    New_Line;
    Put("Rensar listan.");
    Delete(L);

end adao7;