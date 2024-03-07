-- antgu873: Arbetat enskilt

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_Line; use Ada.Command_Line;


procedure Command_Name is

   
begin  
   if Argument_Count = 2 then
      Put("Meddelande: ");
      for I in 1..Integer'Value(Argument(1)) loop
	 Put(Argument(2));
      end loop;
      New_Line;
      Put("Programmet """);
      Put(Command_Name);
      Put(""" avslutas.");
      
   elsif Argument_Count /= 2 and Argument_Count /= 0 then
      Put("Fel antal argument angivna.");
      
   elsif Argument_Count = 0 then
      Put("Inga argument angivna.");
      
   end if;

end Command_Name;
