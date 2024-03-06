package sorted_list is

    type List_Type is private;


    function Empty(L : in     List_Type) return Boolean;
    procedure Put(L : in     List_Type);
    function Length(L : in     List_Type) return Integer;
    function Member(L : in     List_Type; N : in     Integer) return Boolean;
    procedure Remove(L : in out List_Type; N : in     Integer);
    procedure Delete(L : in out List_Type);
    procedure Insert(L : in out List_Type; N :        Integer);

    No_Such_Element_Error : exception;
    
private
    type Elemental_Type;

    type List_Type is 
        access Elemental_Type;

    type Elemental_Type is 
        record
            I : Integer;
            NextPtr : List_Type;
        end record;
end sorted_list;