with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;     use Ada.Float_Text_IO;
with Ada.Command_Line;      use Ada.Command_Line;

procedure adao81 is

        procName : String := "adao81";

    function check_Arg return Boolean is
        begin

        if Argument(2) = Argument(1) then
            Put("Error! Output file """);
            Put(Argument(2));
            Put(""" cannot be same as input file!");
            return false;
        end if;

        for I in 1..2 loop
            if Argument(I) = procName or Argument(I) = ("./" & procName) then
                if I = 1 then
                    Put("Error! Input file""");
                    Put(Argument(1));
                elsif I = 2 then
                    Put("Error! Output file """); 
                    Put(Argument(2));
                end if;

                Put(""" cannot be same as the program itself!");
                return false;
            end if;
        end loop;

        if Argument_Count = 0 or Argument_Count > 2 then
            Put("Error! Incorrect number of arguments!");
            return false;
        end if;

        return true;

    end check_Arg;



begin

    if check_Arg then
        Put("Arguments okay!");
    end if;

    exception
        when Name_Error =>
        Put("Error! Input file """); 
        Put(Argument(1));
        Put(""" does not exist!");

        when Status_Error =>
        Put("Error! Output file """); 
        Put(Argument(2));
        Put(""" already exist!");

end adao81;