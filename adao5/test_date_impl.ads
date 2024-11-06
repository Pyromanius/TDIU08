package test_date_impl is

    type Date_Type is private;

    procedure addZero(I : in     Integer);
    procedure Put(Item : in     Date_Type);
    function LeapYear_Check(Item : in     Date_Type) return Boolean;
    procedure Date_Check(Item : in     Date_Type);
    procedure Format_Check (S    : in     String; X, Y : in     Integer);
    procedure Get(Item :    out Date_Type);
    Format_Error, Day_Error, Month_Error, Year_Error, Length_Error : exception;
    function Next_Date(Item : in      Date_Type) return Date_Type;
    function Previous_Date(Item : in      Date_Type) return Date_Type;
    function "="(lhs : in     Date_Type; rhs : in     Date_Type) return Boolean;
    function ">"(lhs : in     Date_Type; rhs : in     Date_Type) return Boolean;
    function "<"(lhs : in     Date_Type; rhs : in     Date_Type) return Boolean;


private
    type Date_Type is
        record
        Year, Month, Day  : Integer;
        end record;
    S : String(1..10);

end test_date_impl;