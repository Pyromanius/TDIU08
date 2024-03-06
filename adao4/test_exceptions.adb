--Antgu873: Arbetat enskilt
with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

procedure Test_Exceptions is

   Length : Integer;
   Length_Error : exception;

   
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
   procedure Get_Safe (Value    :    out Integer;
                       Min, Max : in     Integer) is
                                             
   begin
      loop
         begin
            Put("Mata in värde (");
            Put(Min, Width=>1);
            Put(" - ");
            Put(Max, Width=>1);
            Put("): ");

            Get(Value);

            if Value not in Min..Max then
               Put("För ");

               if Value > Max then
                  Put("stort ");
               elsif Value < Min then
                  Put("litet ");
               end if;

               Put("värde. ");

            else
               exit;
            end if;

         exception 
            when Data_Error => 
               Put("Fel datatyp. ");
               Skip_Line;
         end;
      end loop;
   end Get_Safe; 

   procedure Upg1 is

      Value, Min, Max : Integer;

   begin      
      Put("Mata in Min och Max: ");
      Get(Min);
      Get(Max);

      Get_Safe(Value, Min, Max);
      
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
 
   procedure Get_Correct_String(S :    out String) is
   
      C : Character;
      EOL : Boolean;
      I : Integer := 1;

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

      if I < S'Length then
         raise Length_Error;
      end if;
    end Get_Correct_string;

   procedure Upg2(Length : in     Integer) is
      
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

      procedure addZero(I : in    Integer) is

      begin
         if I < 10 then
            Put("0");
         end if;
            Put(I, Width => 1);
      end addZero;

      procedure Put(Item : in     Date_Type) is

      begin

         Put(Item.Year, Width=>0);
         Put("-");

         addZero(Item.Month);

         Put("-");

         addZero(Item.Day);
      end Put;

      function LeapYear_Check(Item : in     Date_Type) return Boolean is

      begin
         if Item.Day = 29 and Item.Month = 2 then
            if ((Item.Year rem 4 = 0) and (Item.Year rem 100 /= 0)) or (Item.Year rem 400 = 0) then
               return true;
            else
               return false;
            end if;
         else
            return true;
         end if;         
      end LeapYear_Check;
      
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

      procedure Format_Check (S    : in     String; 
                              X, Y : in     Integer) is
      begin

         for I in X..Y loop
            if S(I) < '0' or S(I) > '9' then
               raise Format_Error;
            end if;
         end loop;

      end Format_Check;

      procedure Get(Item :    out Date_Type) is

      begin
         Get_Correct_String(S);

         if (S(5) /= '-') or (S(8) /= '-') then
            raise Format_Error;
         end if;

         Format_Check(S, 1, 4);
         Format_Check(S, 6, 7);
         Format_Check(S, 9, 10);

         Item.Year := Integer'Value(S(1..4));
         Item.Month := Integer'Value(S(6..7));
         Item.Day := Integer'Value(S(9..10));

         Date_Check(Item);

         if not LeapYear_Check(Item) then
               raise Day_Error;
         end if;

      exception
         when Length_Error =>
--             Put("Felaktig längd! ");
            raise Format_Error;
      end Get;

   begin      

      loop
         begin
            Put("Mata in ett datum: ");

--            New_Line;
--            Put(S);
--            New_Line;

            Get(Date);

            Put("Du matade in ");
            Put(Date);
            New_Line;
            exit;
   
         exception
            when Day_Error => 
               Put("Felaktig dag! ");
            when Month_Error => 
               Put("Felaktig månad! ");
            when Year_Error => 
               Put("Felaktigt år! ");
            when Format_Error=> 
               Put("Felaktigt format! ");
         end;  
      end loop;      
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
end Test_Exceptions;
