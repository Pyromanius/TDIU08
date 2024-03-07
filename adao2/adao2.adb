--Antgu873: Arbetat enskilt

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

procedure adao2 is
   
   
   --DIFFERENSFUNKTION
   
   function "-" (Left  : in Integer; 
		 Right : in Float) return Float is
      
   begin
      
      return (Float(Left) - Right);
      
   end "-";
   
   
   --KONTROLLERA SUBSTANTIV
   
   procedure Decide_Noun (Mojligt_Plural : in out String; 
			  STecken_Bool   :    out Boolean) is
      
   begin
      
      if Character(Mojligt_Plural(Mojligt_Plural'Last)) = 's' then
	 Stecken_Bool := True;
      elsif Character(Mojligt_Plural(Mojligt_Plural'Last)) /= 's' then
	 Stecken_bool := False;
	 Mojligt_Plural(Mojligt_Plural'Last) := 's';
      end if;
      
   end Decide_Noun;
   
   
   --KONTROLLERA S
   
   function BoolCheck_Stecken (Tecken_Att_Kolla : in Character) return Boolean is
      
      S_Bool : Boolean := False;
      
   begin
      
      if Tecken_Att_Kolla = 's' or Tecken_Att_Kolla = 'S' then
	 S_Bool := True;
      end if;     
      return S_Bool;
      
   end BoolCheck_Stecken;
   
   
   --HUVUDPROGRAM
   
   Heltal : Integer;
   Flyttal : Float;
   Eng_Substantiv : String(1..5);
   Plural_Bool : Boolean;
   S_Tecken : Character;

   
begin
   
   Put("Mata in ett heltal och ett flyttal: ");
   Get(Heltal);
   Get(Flyttal);
   Put("Differensen mellan dem är ");
   Put((Heltal - Flyttal), Fore=>1, Aft=>2, Exp=>0);
   
   New_Line(2);
   
   Put("Skriv in ett 5 tecken långt engelskt substantiv: ");   
   Get(Eng_Substantiv);
   Decide_Noun(Eng_Substantiv, Plural_Bool);
   Put("Ordet ");
   Put(Eng_Substantiv);
   Put(" var troligtvis ");
   if not Plural_Bool then
      Put("inte ");
   end if;
   Put_Line("i plural från början");
   
   Skip_Line;
   New_Line;
   
   Put("Mata in ett tecken: ");
   Get(S_Tecken);
   Put("Tecknet var");
   if not BoolCheck_Stecken(S_Tecken) then
      Put(" inte");
   end if;
   Put(" sant");

end adao2;
