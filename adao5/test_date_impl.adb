--Antgu873: Arbetat enskilt
with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

package body test_date_impl is

   function String_Length_Check(I : in     Integer; 
                                S : in     String) return Boolean is
   begin
      if I < S'Length then
         return true;
      else
         return false;
      end if;
   end String_Length_Check;

   procedure Get_Correct_String(S :    out String) is
      I : Integer := 1;
      C : Character;
      EOL : Boolean;
   begin
      Get(C);
      while C =' ' loop
         Look_Ahead(C, EOL);
         Get(C);
      end loop;
      S(I) := C;

      for X in 2..S'Length loop     
         Look_Ahead(C, EOL);
         if not EOL then
            Get(C);
            S(X) := C;
            I := I + 1;
         end if;
      end loop;

      if String_Length_Check(I, S) then
         raise Length_Error;
      end if;

   exception
      when Length_Error =>
         Put("För få inmatade tecken!"); 
   end Get_Correct_string;

   procedure add_Zero(I : in    Integer) is
   begin
      if I < 10 then
         Put("0");
      end if;
         Put(I, Width => 1);
   end add_Zero;

   procedure Put(Item : in     Date_Type) is
   begin
      Put(Item.Year, Width=>0);
      Put("-");
      add_Zero(Item.Month);
      Put("-");
      add_Zero(Item.Day);
   end Put;

   function Leap_Year_Check(Item : in     Date_Type) return Boolean is
   begin
      if (((Item.Year rem 4 = 0) and (Item.Year rem 100 /= 0)) or (Item.Year rem 400 = 0)) then
         return true;
      else
         return false;
      end if;      
   end Leap_Year_Check;
   
   procedure Date_Check(Item : in     Date_Type) is
   begin
      if Item.Year not in 1532..9000 then
         raise Year_Error; 
      end if;
      if Item.Month not in 1..12 then
         raise Month_Error;
      end if; 
      if Item.Day not in 1..31 then
         raise Day_Error;
      end if;
      if (Item.Day = 31) and (Item.Month = 4 or Item.Month = 6 or Item.Month = 9 or Item.Month = 11) then
         raise Day_Error;
      end if;
      if (Item.Month = 2 and Item.Day > 29) then 
         raise Day_Error;
      end if;                       
   end Date_Check;

   function Format_Check (S : in     String) return Boolean is
   begin
      if (S(S'First +  4) /= '-') or (S(S'First +  7) /= '-') then
         return false;
      end if;

      for I in 1..10 loop
         if (I /= 5 and I /= 8) then
            if S(I) < '0' or S(I) > '9' then
               return false;
            end if;
         end if;
      end loop;

      return true;
   end Format_Check;

   procedure Get(Item :    out Date_Type) is
      S : String(1..10);
   begin
      Get_Correct_String(S);
      
      if not Format_Check(S) then
         raise Format_Error;
      end if;
      
      Item.Year := Integer'Value(S(1..4));
      Item.Month := Integer'Value(S(6..7));
      Item.Day := Integer'Value(S(9..10));
      Date_Check(Item);

      if ((Item.Month = 2 and Item.Day = 29) and not Leap_Year_Check(Item)) then
         raise Day_Error;
      end if;

   exception
      when Length_Error =>
         raise Format_Error;
   end Get;

   function Next_Date(Item : in     Date_Type) return Date_Type is
      Next_Day : Date_Type;
   begin
      Next_Day := Item;
      if (((Item.Day = 30) and (Item.Month = 4 or Item.Month = 6 or Item.Month = 9 or Item.Month = 11)) or ((Item.Day = 31) and (Item.Month = 1 or Item.Month = 3 or Item.Month = 5 or Item.Month = 7 or Item.Month = 8 or Item.Month = 10))) then
         Next_Day.Month := Item.Month+1;
         Next_Day.Day := 01;
      elsif ((Item.Month = 12) and (Item.Day = 31)) then
         Next_Day.Day := 01;
         Next_Day.Month := 01;
         Next_Day.Year := Item.Year+1;
      elsif ((Item.Month = 2 and Leap_Year_Check(Item) = false and Item.Day = 28) or (Item.Month = 2 and Item.Day = 29)) then
         Next_Day.Day := 01;
         Next_Day.Month := 03;
      else
         Next_Day.Day := Next_Day.Day+1;
      end if;
      
      Date_Check(Next_Day);
      return Next_Day;
   end Next_Date;

   function Previous_Date(Item : in     Date_Type) return Date_Type is
      Previous_Day : Date_Type := Item;
   begin
      if Item.Day = 1 then
         if Item.Month = 1 then
            Previous_Day.Month := 12;
            Previous_Day.Year := Previous_Day.Year - 1;
         else
            Previous_Day.Month := Item.Month - 1;
         end if;

         if (Previous_Day.Month = 1 or Previous_Day.Month = 3 or Previous_Day.Month = 5 or Previous_Day.Month = 7 or Previous_Day.Month = 8 or Previous_Day.Month = 10 or Previous_Day.Month = 12) then
            Previous_Day.Day := 31;
         elsif (Previous_Day.Month = 4 or Previous_Day.Month = 6 or Previous_Day.Month = 9 or Previous_Day.Month = 11) then 
            Previous_Day.Day := 30;
         else
            if Leap_Year_Check(Item) then
               Previous_Day.Day := 29;
            else
               Previous_Day.Day := 28;
            end if;
         end if;
      else
         Previous_Day.Day := Item.Day - 1;
      end if;

      Date_Check(Previous_Day);
      return Previous_Day;
   end Previous_Date;

   function "="(lhs, rhs : in     Date_Type) return Boolean is
   begin
      if (lhs.Year = rhs.Year) and (lhs.Month = rhs.Month) and (lhs.Day = rhs.Day) then
         return true;
      else 
         return false;
      end if;
   end "=";

   function ">"(lhs, rhs : in     Date_Type) return Boolean is
   begin
      if (lhs.Year > rhs.Year) or (lhs.Year = rhs.Year and lhs.Month > rhs.Month) then
         return true;
      elsif lhs.Year < rhs.Year then
         return false;
      else
         if (lhs.Month > rhs.Month) or (lhs.Month = rhs.Month and lhs.Day > rhs.Day) then
            return true;
         else
            return false;
         end if;
      end if;
   end ">";

   function "<"(lhs, rhs : in     Date_Type) return Boolean is
   begin
      if (lhs > rhs) or (lhs = rhs) then
         return false;
      else 
         return true;
      end if;
   end "<";
end test_date_impl;