--Antgu873: Arbetat enskilt

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;


procedure adao113 is
   
   Min : Float;
   Max : Float;
   Number_Of_Integers : Integer;
   Number_Of_Characters : Integer;
   
   subtype Mitt_Flytintervall is Float range Min .. Max;
   subtype Mitt_Sifferintervall is Integer range 1 .. 6;
   subtype Mitt_Bokstavsintervall is Character range 'A' .. 'Z';
   
   
   package Mitt_SlumppaketA is new Ada.Numerics.Discrete_Random(Mitt_Sifferintervall); 
   
   use Mitt_SlumppaketA;
   
   G : Mitt_SlumppaketA.Generator;
   
   procedure SlumpaHeltal is 
   begin
      Put(Random(G), Width=>1);
   end SlumpaHeltal;
   
   procedure SlumpaAntalBokstaver is
   begin
      Number_Of_Characters := Random(G);
   end SlumpaAntalBokstaver;
 
   
   
   package Mitt_SlumppaketB is new Ada.Numerics.Discrete_Random(Mitt_Bokstavsintervall);
   
   use Mitt_SlumppaketB;
   
   K : Mitt_SlumppaketB.Generator;
   
   procedure SlumpaBokstav is
   begin
      Put(Random(K));
   end SlumpaBokstav;
   
      
   
   use Ada.Numerics.Float_Random;
   
   J : Ada.Numerics.Float_Random.Generator;
   
   procedure SlumpaFlyttal (Slumpflyttal : out Float) is
   begin
      Get(Min);
      Get(Max);
      Put("Slumpat flyttal mellan ");
      Put(Min, Fore=>1, Aft=>2, Exp=>0);
      Put(" och ");
      Put(Max, Fore=>1, Aft=>2, Exp=>0);
      Put(": ");
      Slumpflyttal := Random(J) * (Max - Min) + Min;
   end SlumpaFlyttal;
   
   
   
   Slumpflyttal : Float; 
   
begin
--   Reset(G);
--   Reset(K);
--   Reset(J);
   Put("Mata in antalet heltal som ska slumpas: ");
   Get(Number_Of_Integers);
   Put(Number_Of_Integers, Width=>1);
   if Number_Of_Integers = 1 then
      Put(" slumpat heltal:");
   elsif Number_Of_Integers > 1 then
      Put(" slumpade heltal:");
   end if;
   for I in 1 .. Number_Of_Integers loop
      Put(" ");
      SlumpaHeltal;
   end loop;
   New_Line;
   SlumpaAntalBokstaver;
   Put(Number_Of_Characters, Width=>1);
   if Number_Of_Characters = 1 then
      Put(" slumpat tecken:");
   elsif Number_Of_Characters > 1 then
      Put(" slumpade tecken:");
   end if;
   for I in 1 .. Number_Of_Characters loop
      Put(" ");
      SlumpaBokstav;
   end loop;
   New_Line; 
   Put("Mata in två flyttal: ");
   SlumpaFlyttal(SlumpFlyttal);
   Put(SlumpFlyttal, Fore=>1, Aft=>2, Exp=>0);
end adao113;
