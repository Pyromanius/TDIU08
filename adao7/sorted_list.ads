package sorted_list is

    type List_Ptr is private;

    function Empty(L : in     List_Ptr) return Boolean;
    procedure Put(L : in     List_Ptr);
    function Length(L : in     List_Ptr) return Integer;
    function Member(L : in     List_Ptr; N : in     Integer) return Boolean;
    procedure Remove(L : in out List_Ptr; N : in     Integer);
    procedure Delete(L : in out List_Ptr);
    procedure Insert(L : in out List_Ptr; N :        Integer);

private
    type List_Type;

    type List_Ptr is 
        access List_Type;

    type List_Type is 
        record
            I : Integer;
            NextPtr : List_Ptr;
        end record;
end sorted_list;