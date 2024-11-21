package test_date_impl is
   type Date_Type is private;

   function String_Length_Check(I : in     Integer; S : in     String) return Boolean;
   procedure Get_Correct_String(S :    out String);
   procedure add_Zero(I : in     Integer);
   procedure Put(Item : in     Date_Type);
   function Leap_Year_Check(Item : in     Date_Type) return Boolean;
   procedure Date_Check(Item : in     Date_Type);
   function Format_Check (S    : in     String) return Boolean;
   procedure Get(Item :    out Date_Type);
   function Next_Date(Item : in      Date_Type) return Date_Type;
   function Previous_Date(Item : in      Date_Type) return Date_Type;
   function "="(lhs, rhs : in     Date_Type) return Boolean;
   function ">"(lhs, rhs : in     Date_Type) return Boolean;
   function "<"(lhs, rhs : in     Date_Type) return Boolean;
    
   Format_Error, Day_Error, Month_Error, Year_Error, Length_Error : exception;

private
    type Date_Type is
        record
        Year, Month, Day  : Integer;
        end record;
   -- S : String(1..10);
end test_date_impl;