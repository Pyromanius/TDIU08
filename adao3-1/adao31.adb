--Antgu873: Arbetat enskilt
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;   use Ada.Float_Text_IO;

procedure adao31 is
   
   ----------------------DS1 Type-------------------

   type DS1_Type is 
      record 
	 W : Character;
	 P : String(1 .. 4);
      end record;
   
   ----------------------DS2 Type-------------------
   
   type D_U_Type is
      record
	 S : Float;
	 Z : String(1 .. 4);
      end record;
   
   type DS2_Type is
      record
	 D, U : D_U_Type;
      end record;
   
   ----------------------DS3 Type-------------------
   
   type J_B_Type is
      record
	 Y : Character;
	 Q : Character;
      end record;
   
   type O_Type is
      record
	 T : Boolean := False;
	 L : Integer;
      end record;
   
   type DS3_Type is
      record
	 J, B : J_B_Type;
	 O : O_Type;
      end record;
   
   ----------------------DS1 Get/Put----------------

   procedure Get (Item : out DS1_Type) is
      Mellanslag : Character := ' ';
   begin
      Get(Item.W);
      Get(Mellanslag);
      Get(Item.P);
   end Get;
   
   procedure Put (Item : in DS1_Type) is
   begin
      Put(Item.W);
      Put(" ");
      Put(Item.P);
   end Put; 
   
   ----------------------DS2 Get/Put----------------

   procedure Get (Item : out D_U_Type) is
      Mellanslag : Character := ' ';
   begin
      Get(Item.S);
      Get(Mellanslag);
      Get(Item.Z);
   end Get;
   
   procedure Get (Item : out DS2_Type) is 
      Mellanslag : Character := ' ';
   begin
      Get(Item.D);
      Get(Mellanslag);
      Get(Item.U);
   end Get; 
   
   procedure Put (Item : in D_U_Type) is
   begin
      Put(Item.S, Fore=>1, Aft=>3, Exp=>0);
      Put(" ");
      Put(Item.Z);
   end Put;
  
   procedure Put (Item : in DS2_Type) is
   begin
      Put(Item.D);
      Put(" ");
      Put(Item.U);
   end Put;
   
   ----------------------DS3 Get/Put----------------
   
   procedure Get (Item : out J_B_Type) is
      Mellanslag : Character := ' ';
   begin
      Get(Item.Y);
      Get(Mellanslag);
      Get(Item.Q);
   end Get;

   procedure Get (Item : out O_Type) is
      BooleanChar : Character;
      Mellanslag : Character := ' ';
   begin
      Get(BooleanChar);
      if BooleanChar = 'T' then
   	 Item.T := True;
      end if;
      Get(Mellanslag);
      Get(Item.L);
   end Get;
   
   procedure Get (Item : out DS3_Type) is
      Mellanslag : Character := ' ';
   begin
      Get(Item.J);
      Get(Mellanslag);
      Get(Item.B);
      Get(Mellanslag);
      Get(Item.O);
   end Get;
   
   procedure Put (Item : in J_B_Type) is
   begin
      Put(Item.Y);
      Put(" ");
      Put(Item.Q);
   end Put;
  
   procedure Put (Item : in O_Type) is
   begin
      if Item.T then
	 Put("True");
      else
	 Put("False");
      end if;
      Put(" ");
      Put(Item.L, Width=>1);
   end Put;
   
   procedure Put (Item : in DS3_Type) is
   begin
      Put(Item.J);
      Put(" ");
      Put(Item.B);
      Put(" ");
      Put(Item.O);
   end Put;
   
   ----------------------HUVUDPROGR.----------------
   
   
   DS1 : DS1_Type;
   DS2 : DS2_Type;
   DS3 : DS3_Type;
begin
   
   Put_Line("För DS1:");
   Put("Mata in datamängd: ");
   Get(DS1); 
   Put("Inmatad datamängd: ");
   Put(DS1);
   
   Skip_Line;
   New_Line(2);
   
   Put_Line("För DS2:");
   Put("Mata in datamängd: ");
   Get(DS2); 
   Put("Inmatad datamängd: ");
   Put(DS2);
   
   Skip_Line;
   New_Line(2);
   
   Put_Line("För DS3:");
   Put("Mata in datamängd: ");
   Get(DS3); 
   Put("Inmatad datamängd: ");
   Put(DS3);
   
end adao31;
