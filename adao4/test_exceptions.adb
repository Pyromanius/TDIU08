--Antgu873: Arbetat enskilt
with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Ada.Strings.Fixed;    use Ada.Strings.Fixed;

procedure Test_Exceptions is

      Length : Integer;
      Length_Error : exception;

   procedure Get_Correct_String(S : in out String) is

      C : Character;
      End_Of_Line : Boolean := false;
      I : Integer;

   begin
      I := 1;
      Get(C);

      while C = ' ' or End_Of_Line = true loop
         Look_Ahead(C, End_Of_Line);
         Get(C);
      end loop;

      S(1) := C;

      for X in 2..Length loop
         Look_Ahead(C, End_Of_Line);
            if End_Of_Line = false then
               Get(C);
               S(X) := C;
               I := I + 1;
            end if;
      end loop;

      if I < Length then
         raise Length_Error;
      end if;
      
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
      Put(" - ");
      Put(Max, Width=>1);
      Put("): ");
      Get(Value);

      if Value < Min then
         Put("För litet värde. ");
         Get_Safe(Value, Min, Max);
      elsif Value > Max then
         Put("För stort värde. ");
         Get_Safe(Value, Min, Max);
      end if;

   exception 
      when Data_Error => 
         Put("Fel datatyp. ");
         Skip_Line;
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
      
   begin      
      Put("Mata in en sträng med exakt ");
      Put(Length, Width => 0);
      Put(" tecken: ");
      
      Get_Correct_String(S);
      
      Skip_Line;
      Put_Line("Du matade in strängen " & S & ".");

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
      Format_Error, Day_Error, Month_Error, Year_Error : exception;
      S : String(1..10);

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

      procedure Get(Item : in out Date_Type) is

         function LeapYear_Check (Item : in Date_Type) return Boolean is         
         begin
            if Item.Day = 29 and Item.Month = 2 then
               if ((Item.Year rem 4 = 0) and (Item.Year rem 100 /= 0)) or Item.Year rem 400 = 0 then
                  return True;
               else
                  return False;
               end if;
            else
               return True;
            end if;         
         end LeapYear_Check;

         procedure Date_Check (Item : in Date_Type) is
         begin
            if Item.Year < 1532 or Item.Year > 9000 then
               raise Year_Error; 
            end if;

            if Item.Month < 1 or Item.Month > 12 then
               raise Month_Error;
            end if; 

            if (Item.Day < 1 or Item.Day > 31) or ((Item.Day = 31) and (Item.Month = 4 or Item.Month = 6 or Item.Month = 9 or Item.Month = 11)) or ((LeapYear_Check(Item) = false) or (Item.Month = 2 and Item.Day > 29)) then
               raise Day_Error;
            end if;   
         end Date_Check;

      begin
         Length := 10;

         Get_Correct_String(S);

         if S(5) /= '-' or S(8) /= '-' then
            raise Format_Error;
         end if;

         for I in 1..4 loop
            if S(I) < '0' or S(I) > '9' then
               raise Format_Error;
            end if;
         end loop;
         
         Item.Year := Integer'Value(S(1..4));

         for I in 1..2 loop
            if S(I+5) < '0' or S(I+5) > '9' then
               raise Format_Error;
            end if;
         end loop;
         Item.Month := Integer'Value(S(6..7));

         for I in 1..2 loop
            if S(I+8) < '0' or S(I+8) > '9' then
               raise Format_Error;
            end if;
         end loop;
         Item.Day := Integer'Value(S(9..10));

         Date_Check(Item);

      end Get;

   begin 
      Put("Mata in ett datum: ");
      Get(Date);
      
      Put("Du matade in ");
      Put(Date);
      New_Line;

   exception
      when Day_Error => 
         Put("Felaktig dag! ");
         Skip_Line; 
         Upg3;
      when Month_Error => 
         Put("Felaktig månad! ");
         Skip_Line;
         Upg3;
      when Year_Error => 
         Put("Felaktigt år! ");
         Skip_Line;
         Upg3;
      when Format_Error | Length_Error =>
         Put("Felaktigt format! ");
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
   Choice : Integer;
   
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

exception
   when Length_Error =>
      Put("För få inmatade tecken!");
      New_Line;       
         
end Test_Exceptions;
