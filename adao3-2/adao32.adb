--Antgu873: Arbetat enskilt
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;   use Ada.Float_Text_IO;



procedure adao32 is
    
   type DS1_Type is
     array (31 .. 35) of Float;
   
   subtype Char_Type1 is Character range '5'..'9';
   
   type True_False is 
     array (Char_Type1) of String(1..5);
   
   type DS2_Type is
     array (boolean) of True_False;
   
   subtype Char_Type2 is Character range '4' .. '8';
   
   type DS3_Type is
     array (73 .. 74, Char_Type2) of Integer;
   
   procedure Get (DS1 : out DS1_Type) is
   begin
      for I in reverse DS1_Type'First .. DS1_Type'Last loop
   	 Get(DS1(I));
      end loop;
   end Get;
   
   procedure Put (DS1 : in DS1_Type) is
   begin
      for I in reverse 31..35 loop
   	 Put(" ");
   	 Put(DS1(I), Fore=>1, Aft=>3, Exp=>0);
      end loop;
   end Put;
   
   procedure Get (DS2 : out DS2_Type) is
      Mellanslag : Character;
   begin
      for Z in Boolean loop
	 for I in reverse Char_Type1 loop
	    if Z = False and I ='9' then
	       Get(DS2(Z)(I));
	    else
	       Get(Mellanslag);
	       Get(DS2(Z)(I));
	    end if;
	 end loop;
      end loop;
   end Get;
   
   procedure Put (DS2 : in DS2_Type) is
    begin
      for Z in Boolean loop
	 for I in reverse Char_Type1 loop
	    Put(" ");
	    Put(DS2(Z)(I));
	 end loop;
      end loop;
    end Put;
    
    procedure Get (DS3 : out DS3_Type) is
       Mellanslag : Character;
    begin
       for I in DS3_Type'First .. DS3_Type'Last loop
	  for Z in Char_Type2'First .. Char_Type2'Last loop
	     if I = 74 and Z = '8' then
		Get(DS3(I,Z));
	     else
		Get(DS3(I,Z));
		Get(Mellanslag);
	     end if;
	  end loop;
       end loop;
    end Get;
    
    procedure Put (DS3 : in DS3_Type) is
    begin
       for I in DS3_Type'First .. DS3_Type'Last loop
	  for Z in Char_Type2'First .. Char_Type2'Last loop
	     Put(" ");
	     Put(DS3(I,Z), Width=>1);
	  end loop;
       end loop;
    end Put;
   
   DS1 : DS1_Type;
   DS2 : DS2_Type;
   DS3 : DS3_Type;
   
begin
   Put_Line("För DS1:");
   Put("Mata in datamängd: ");
   Get(DS1);
   Put("Inmatad datamängd:");
   Put(DS1);
   
   New_Line(2);
   
   Put_Line("För DS2:");
   Put("Mata in datamängd: ");
   Get(DS2);
   Put("Inmatad datamängd:");
   Put(DS2);
   
   New_Line(2);
   
   Put_Line("För DS3:");
   Put("Mata in datamängd: ");
   Get(DS3);
   Put("Inmatad datamängd:");
   Put(DS3);
   
end Adao32;
