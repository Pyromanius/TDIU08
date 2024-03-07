--ej samarbete

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;



procedure adao12 is
   
   Pris1 : Float;
   Pris2 : Float;
   PrisInkrement : Float;
   Moms : Float;
   MomsProc : Float;
   Momskostnad : Float;
   
begin
   loop
      Put("Första pris: ");
      Get(Pris1);
      if Pris1 < 0.0 then
	 Put("Felaktigt värde!");
	 New_Line;
      else
	 exit;
      end if;
   end loop;
   
   loop
      Put("Sista pris: ");
      Get(Pris2);
      if Pris2 < Pris1 then
	 Put("Felaktigt värde!");
	 New_Line;
      else
	 exit;
      end if;
   end loop;
   
   
   loop
      Put("Steg: ");
      Get(PrisInkrement);
      if PrisInkrement <= 0.0 then
	 Put("Felaktigt värde!");
	 New_Line;
      else
	 exit;
      end if;
   end loop;
   
   
   loop
      Put("Momsprocent: ");
      Get(Moms);
      if Moms < 0.0 or Moms > 100.0  then
	 Put("Felaktigt värde!");
	 New_Line;
      else
	 exit;
      end if;
   end loop;
   
   MomsProc := Moms / 100.0;
   New_Line;
   Put_Line("============ Momstabell ============");
   Put_Line("Pris utan moms  Moms   Pris med moms");
   for I in 0..(Integer(Float'Floor((Pris2 - Pris1) / Prisinkrement))) loop
      Put(Pris1, Fore=>6, Aft=>2, Exp=>0);
      Put("      ");
      Put(Momsproc * Pris1, Fore=>2, Aft=>2, Exp=>0);
      Momskostnad := Momsproc * Pris1;
      Put("  ");
      Put(Momskostnad + Pris1, Fore=>7, Aft=>2, Exp=>0);
      Pris1 := Pris1 + PrisInkrement;
      New_Line;
   end loop;

end adao12;
