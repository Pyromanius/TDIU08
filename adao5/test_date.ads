with Ada.Integer_Text_IO;		use Ada.Integer_Text_IO;	

package test_date is
   type Date_Type is private;

   procedure Get(Time: out Date_Type);
   procedure Put(Time: in Date_Type);
   function Next_Date(Time: in Date_Type) return Date_Type;
   function Previous_Date(Time: in Date_Type) return Date_Type;
   function "<"(Left, Right: in Date_Type) return Boolean;
   function ">"(Left, Right: in Date_Type) return Boolean;
   function "="(Left, Right: in Date_Type) return Boolean;
   
   Format_Error, Format_Error_Day, Format_Error_Month, Format_Error_Year : exception;

   private

   type Date_Type is
   record
      Y, M, D: Integer;
   end record;
      
end test_date;
