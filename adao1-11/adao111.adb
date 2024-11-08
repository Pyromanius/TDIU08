with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Numerics; use Ada.Numerics;

procedure adao111 is
   
   procedure Menu_Selection(Selection : out Integer) is

   begin
      Put_Line("=== HUVUDMENY ===");
      Put_Line("1. Beräkna hypotenusa");
      Put_Line("2. Beräkna triangelvinklar");     
      Put_Line("3. Beräkna N-fakultet");
      Put_Line("4. Avsluta programmet");
      Put("Val: ");
      loop
	 Get(Selection);
	 if Selection > 4 or Selection < 1  then
	    Put_Line("Felaktigt val!");
	    Put("Val: ");
	 else
	    exit;
	 end if;
      end loop;
   end Menu_Selection;
   
   
   
   -- KALKYLERA HYPOTENUSAN
   
   function Calculate_Hypothenuse(A : in Integer; B : in Integer) return Float is
      
      Hypo : Float;
      
   begin
      Hypo := Float(A ** 2 + B **2) ** 0.5;
      return Hypo;      
   end Calculate_Hypothenuse;

   
   procedure Hypothenuse_Program is
      
      Hypo : Float;
      A : Integer;
      B : Integer;   
      
   begin
      Put("Mata in kateternas längder: ");
      Get(A);
      Get(B);
      Hypo := Calculate_Hypothenuse(A, B);
      Put("Hypotenusan är ");
      Put(Hypo, Fore=>1, Aft=>2, Exp=>0);
   end Hypothenuse_Program;
   
   
   
   
   -- KALKYLERA VINKLAR
   
   procedure Calculate_Angles(Hc : in Float; Sa : in Float; Va : out Float; Vb : out Float) is

   begin
      Va := arcsin ( Sa / Hc );
      Va := Va * (180.0 / 3.14);
      Vb := (180.0 - Va - 90.0);
   end Calculate_Angles;
   
   
   procedure Angles_Program is
      
      Va : Float;
      Vb : Float;
      Hc : Float;
      Sa : Float;
      
   begin
      Put("Mata in hypotenusans längd: ");
      Get(Hc);
      Put("Mata in vertikala katetens längd: ");
      Get(Sa);
      Calculate_Angles(Hc, Sa, Va, Vb);
      Put("Va: ");
      Put(Va, Fore=>1, Aft=>1, Exp=>0);
      Put_Line(" grader");
      Put("Vb: ");
      Put(Vb, Fore=>1, Aft=>1, Exp=>0);
      Put_Line(" grader");
      Put("Vc: 90.0 grader");
   end Angles_Program;
   
   
   
   -- KALKYLERA N-FAKULTET
   
   function Calculate_Factorial(N : in Integer) return Integer is
      
      LoopCount : Integer;
      Nfac : INteger;
      
   begin
      Nfac := 1;
      LoopCount := N;
      for I in 1..LoopCount loop
	 Nfac := LoopCount * Nfac;
	 LoopCount := (Loopcount - 1);
      end loop;
      return NFac;     
   end Calculate_Factorial;

   
   procedure Factorial_Program is
      
      N : Integer;
      Nfac : Integer;
      
   begin
      Put("Mata in N: ");
      Get(N);
      Put(N, Width=>1);
      Put("-fakultet = ");
      Nfac := Calculate_Factorial(N);
      Put(Nfac, Width=>1);
   end Factorial_Program;
   
   
   
   -- HUVUDPROGRAM
   
   Selection : Integer;
   
begin
   Put_Line("Välkommen till miniräknaren!");
   loop 
      Menu_Selection(Selection);
      if Selection = 1 then
	 Hypothenuse_Program;
	 New_Line(2);
      elsif Selection = 2 then
	 Angles_Program;
	 New_Line(2);
      elsif Selection = 3 then
	 Factorial_Program;
	 New_Line(2);
      elsif Selection = 4 then
	 Put("Ha en bra dag!");
	 exit;
      end if;
   end loop;
end adao111;


