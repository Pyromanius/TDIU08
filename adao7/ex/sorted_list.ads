package sorted_list is

    type List_Type is private;

    function Empty(List : in     List_Type) return Boolean;
    procedure Insert(List : in out List_type; Input : in Integer);
    procedure Put(List : in     List_Type);
    function Member(List : in     List_Type; SearchString : in Integer) return Boolean; 
    procedure Remove(List : in out List_Type; SearchString : in Integer);
    procedure Delete(List : in out List_Type);
    function Length(List : in     List_Type) return Integer;

    No_Such_Element_Error : exception;

    --  function Find(List : in List_Type; SearchString : in Integer) return Integer;
    --  procedure Find(List : in List_Type; SearchString : in Integer; Result : out Integer);  

private
    type E_Type;

    type List_Type is 
        access E_Type;

    type E_Type is 
        record
            Data : Integer;
            Next : List_Type;
        end record;

end sorted_list;