with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Fixed;   use Ada.Strings.Fixed;

procedure Test_Exceptions is

   function Get_Correct_String(S      : in out String;
                                 Length : in     Integer) return Boolean is
      C : Character;
      End_Of_Line : Boolean;
      SL : Integer;
   begin
      Look_Ahead(C, End_Of_Line);
      while C = ' ' and End_Of_Line = false loop 
         Get(C);
         Look_Ahead(C, End_Of_Line);
      end loop;
      S(1) := C;
      SL := 0; 
      for I in 2 .. Length loop
         Get(S(I));
         SL := SL + 1;
         Look_Ahead(S(I), End_Of_Line);
         if End_Of_Line = true and SL < Length then
            return false;
         elsif End_Of_Line = true and SL = Length then
            return true;
         end if;
      end loop;
      return true;
   end Get_Correct_String;
   
   ----------------------------------------------------------------------
   -- Underprogram för att skriva ut meny och hantera menyval          --
   --                                                                  --
   -- Underprogrammet skriver ut de menyval som finns tillgängliga.    --
   -- Användaren får mata in menyval tills denne matat in ett          --
   -- korrekt menyval.                                                 --
   ----------------------------------------------------------------------
   function Menu_Selection return Integer is
      
      N : Integer;
      
   begin
      Put_Line("1. Felkontrollerad heltalsinläsning");
      Put_Line("2. Längdkontrollerad stränginläsning");
      Put_Line("3. Felkontrollerad datuminläsning");
      Put_Line("4. Avsluta programmet");
      
      loop
	 Put("Mata in N: ");
	 Get(N);
	 exit when N in 1 .. 4;	 
	 Put_Line("Felaktigt N, mata in igen!");
      end loop;
      
      return N;
   end Menu_Selection;


   
   ----------------------------------------------------------------------
   -- Underprogram för menyval 1: "felhantering av heltalsinmatning"   --
   --                                                                  --
   -- Underprogrammet låter användaren mata in ett intervall angivet   --
   -- med två heltal Min och Max. Get_Safe anropas                     --
   -- sedan med detta intervall och sköter felhanteringen av           --
   -- heltalsinläsningen där användaren får mata in värden tills       --
   -- korrekt värde matas in.                                          --
   ----------------------------------------------------------------------
   procedure Upg1 is
      
      Value, Min, Max : Integer;

   procedure Get_Safe (Value    : in out Integer;
                       Min, Max : in     Integer) is
                      
   begin
      Put("Mata in värde (");
      Put(Min, Width=>1);
      Put(" ");
      Put(Max, Width=>1);
      Put("): ");
      Get(Value);
      if Value > Max or Value < Min then
         Get_Safe(Value, Min, Max);
      end if;
         exception 
            when Data_Error => 
            Put("Fel datatyp inmatat");
            Skip_Line;
            New_Line;
            Get_Safe(Value, Min, Max);

   end Get_Safe; 

   begin      
      Put("Mata in Min och Max: ");
      Get(Min);
      Get(Max);
      
      Get_Safe(Value, Min, Max);
      Skip_Line;
      
      Put("Du matade in heltalet ");
      Put(Value, Width => 0);
      Put_Line(".");
end Upg1;


   ----------------------------------------------------------------------
   -- Underprogram för menyval 2: "felhantering av stränginmatning"    --
   --                                                                  --
   -- Underprogrammet skapar en sträng som är lika lång som parametern --
   -- Length. Underprogrammet skickar denna sträng till                --
   -- Get_Correct_String där felhanteringen av stränginmatningen sker. --
   -- Om användaren matar in en för kort sträng kommer                 --
   -- Get_Correct_String kasta/resa undantag vilket inte ska           --
   -- fångas här utan i huvudprogrammet.                               --
   ----------------------------------------------------------------------
   procedure Upg2(Length : in Integer) is
      
      S : String(1 .. Length);
      Length_Error : exception;
      
   begin      
      Put("Mata in en sträng med exakt ");
      Put(Length, Width => 0);
      Put(" tecken: ");
      
      if Get_Correct_String(S, Length) = false then
         raise Length_Error;
      end if;
      Skip_Line;
      
      Put_Line("Du matade in strängen " & S & ".");

      exception
         when Length_Error =>
            Put("För få inmatade tecken!");
            New_Line;
            Skip_Line;      
   end Upg2;
   
   ----------------------------------------------------------------------
   -- Underprogram för menyval 3: "felhantering av datuminmatning"     --
   --                                                                  --
   -- Underprogrammet anropar Get som i sin tur kommer läsa in och     -- 
   -- kontrollera ett datums format och rimlighet. Om datumet är       --
   -- felaktigt kommer Get kasta/resa undantag vilket detta            --
   -- underprogram ska fånga, skriva ut felmeddelande för och sedan    --
   -- anropa Get igen.                                                 --
   ----------------------------------------------------------------------
   procedure Upg3 is
      
      type Date_Type is
         record
            Year, Month, Day  : Integer;
      end record;

      Date : Date_Type;
      Day_Error, Month_Error, Year_Error, Length_Error, Format_Error : exception;

   procedure Put(Item : in Date_Type) is
      begin
         Put(Item.Year, Width=>0);
         Put("-");
         if Item.Month < 10 then
	         Put("0");
         end if;
         Put(Item.Month, Width=>0);
         Put("-");
         if Item.Day < 10 then
	         Put("0");
         end if;
         Put(Item.Day, Width=>0);
   end Put;

   procedure Get(Item : out Date_Type) is

         S : String(1..10);

         function SkottAr_Kontroll (Item : in Date_Type) return Boolean is         
            begin
               if Item.Day = 29 and Item.Month = 2 then
                  if (Item.Year rem 4 = 0) and (Item.Year rem 100 /= 0) then
                        return True;
                     else
                        return False;
                  end if;
               else
                  return True;
               end if;         
         end SkottAr_Kontroll;

         procedure Dag_Kontroll(Item : in Date_Type) is 
            begin 
               if (Item.Day < 1 or Item.Day > 31) or ((Item.Day = 31) and (Item.Month = 4 or Item.Month = 6 or Item.Month = 9 or Item.Month = 11)) or ((SkottAr_Kontroll(Item) = false) or (Item.Month = 2 and Item.Day > 29)) then
                  raise Day_Error;
               end if;           
         end Dag_Kontroll;

         procedure Manad_Kontroll (Month : in Integer) is
            begin
               if Month < 1 or Month > 12 then
                  raise Month_Error;
               end if; 
         end Manad_Kontroll;

         procedure Ar_Kontroll (Year : in Integer) is
            begin               
               if Year < 1532 or Year > 9000 then
                  raise Year_Error; 
               end if;         
         end Ar_Kontroll;

         procedure Kontrollera_Datum (Item : in Date_Type) is
            begin
               Ar_Kontroll(Item.Year);
               Manad_Kontroll(Item.Month);
               Dag_Kontroll(Item);
         end Kontrollera_Datum;

      begin
         Get(S);
         if S'Length /= 10 then
            raise Format_Error;
         end if;
            Item.Year := Integer'Value(S(1..4));
            Item.Month := Integer'Value(S(6..7)); 
            Item.Day := Integer'Value(S(9..10)); 
            Kontrollera_Datum(Item);
         if Get_Correct_String(S, 10) = false then
            raise Format_Error;
         end if;
   end Get;

   begin      
      Put("Mata in ett datum: ");
      Get(Date);
      Skip_Line;
      
      Put("Du matade in ");
      Put(Date);
      New_Line;

         exception 
      when Length_Error =>
         raise Format_Error;
      when Format_Error =>
         Put("Felaktigt format! ");
         Skip_Line;
         Upg3;
      when Year_Error => 
         Put("Felaktigt år! ");
         Skip_Line;
         Upg3;
      when Month_Error => 
         Put("Felaktig månad! ");
         Skip_Line;
         Upg3;
      when Day_Error => 
         Put("Felaktig dag! "); 
         Skip_Line;
         Upg3;       
   end Upg3;
   
   ----------------------------------------------------------------------
   -- Huvudprogram                                                     --
   --                                                                  --
   -- Huvudprogrammet skriver ut och låter användaren välja val i en   --
   -- meny via underprogrammet Menu_Selection. Beroende på vilket      --
   -- menyval användaren valt kommer olika underprogram anropas.       --
   -- Observera att för menyval 2 kommer användaren få mata in längden -- 
   -- av en sträng vilket skickas vidare till underporgrammet Upg2 där --
   -- strängen i sig skapas.                                           --
   ----------------------------------------------------------------------
   Choice, Length : Integer;
   
begin 
   loop
      Choice := Menu_Selection;
      
      if Choice = 1 then
	 Upg1;
	 
      elsif Choice = 2 then
	 Put("Mata in en stränglängd: ");
	 Get(Length);
	 Skip_Line;
	 
	 Upg2(Length);
	 
      elsif Choice = 3 then
	 Upg3;
	 
      else
	 Put_Line("Programmet avslutas.");
	 exit;
      end if;      
   end loop;
end Test_Exceptions;
