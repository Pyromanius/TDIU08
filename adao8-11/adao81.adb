with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;     use Ada.Float_Text_IO;
with Ada.Command_Line;      use Ada.Command_Line;

procedure run is

        procName : String := "adao81";

    subtype RGB_Value is Integer range 0..256;

    type Pixel_Type is
        record
            R, G, B : RGB_Value;
            Alpha : Boolean;
        end record;

    type Image_Area_Type is
        array (1..30, 1..30) of Pixel_Type;

    type Image_Type is
        record
            X_Dim, Y_Dim : Integer := 30;
            Image_Area : Image_Area_Type;
        end record;

    function check_Arg return Boolean is
    begin

        if Argument(2) = Argument(1) then
            Put("Error! Output file """);
            Put(Argument(2));
            Put(""" cannot be same as input file!");
            return false;
        end if;

        for I in 1..2 loop
            if Argument(I) = procName or Argument(I) = Command_Name then
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

    procedure Get (Item :    out Image_Type) is
        
        Input_File : File_Type;
        C : Character;

    begin
    
    Ada.Text_IO.Open (File => Input_File, Mode => Ada.Text_IO.In_File, Name => Argument(1));

        for I in 1..4 loop
            while not End_OF_Line (Input_File) loop
                    Ada.Text_IO.Get (File => Input_File, Item => C);
            end loop;
        end loop;

        for I in 1..30 loop
            for X in 1..30 loop
                Ada.Text_IO.Get (File => Input_File, Item => C);
                Ada.Text_IO.Put (Item => C);
                if End_OF_Line (Input_File) then
                    New_Line;
                end if;
            end loop;    
        end loop;

    end Get;

    Image : Image_Type;

begin

    Put("Code here");
    New_Line;
    Get(Image);


    exception
        when Name_Error =>
        Put("Error! Input file """); 
        Put(Argument(1));
        Put(""" does not exist!");

        when Status_Error =>
        Put("Error! Output file """); 
        Put(Argument(2));
        Put(""" already exist!");

end run;

----------------- FROM TEST CODE ---------------------------

--  with Ada.Text_IO;           use Ada.Text_IO;
--  with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
--  with Ada.Command_Line;      use Ada.Command_Line;

--  procedure test is 

--      subtype RGB_Value is Integer range 0..255;

--      type Pixel_Type is
--          record
--              R, G, B : RGB_Value;
--              Alpha : Boolean;
--          end record;

--      type Image_Area_Type is
--          array (1..30, 1..30) of Pixel_Type;

--      type Image_Type is
--          record
--              X_Dim, Y_Dim : Integer := 30;
--              Image_Area : Image_Area_Type;
--          end record;

--      Input_File : File_Type;
--      S : String(1..30);
--      Image : Image_Type;

--      procedure Set_Black (Item :    out Pixel_Type) is
--      begin
--              Item.R := 0;
--              Item.G := 0;
--              Item.B := 0;
--              Item.Alpha := false;
--      end Set_Black;

--      procedure Set_White (Item :    out Pixel_Type) is
--      begin
--              Item.R := 255;
--              Item.G := 255;
--              Item.B := 255;
--              Item.Alpha := true;
--      end Set_White;

--      procedure Set (Item     :    out Image_Area_Type;
--                     Is_White : in     Boolean) is
--      begin
--          for I in 1..30 loop
--              for Z in 1..30 loop
--                  if Is_White then
--                      Set_White(Item(I, Z));
--                  else
--                      Set_Black(Item(I, Z));
--                  end if;
--              end loop;
--          end loop;
--      end Set;

--      procedure Set (Item     :    out Image_Type;
--                     Is_White : in     Boolean) is
--      begin
--          for I in 1..30 loop
--              Set(Item.Image_Area, Is_White);
--          end loop;
--      end Set;

--      procedure Put (Item : in     Pixel_Type) is
--      begin
--          Put(Item.R, Width=>0);
--          Put(",");
--          Put(Item.G, Width=>0);
--          Put(",");
--          Put(Item.B, Width=>0);
--          Put(",");
--          Put(Item.Alpha'Image);
--          Put("; ");
--      end Put;

--      procedure Put (Item : in     Image_Area_Type) is
--      begin
--          for I in 1..30 loop
--              for Z in 1..30 loop
--                  Put(Item(I, Z));
--              end loop;
--              New_Line;
--          end loop;
--      end Put;

--      procedure Put (Item : in     Image_Type) is
--      begin
--          Put(Item.Image_Area);
--      end Put;

--      procedure Read_File (File : in     File_Type;
--                           Item :    out Image_Type) is

--          C : Character;
--          Is_White : Boolean;

--      begin
--              S := Get_Line(Input_File);

--              for I in 1..30 loop
--                  C := S(I);
--                  if C = '0' then
--                      Is_White := true;
--                      Set(Item, Is_White);
--                  elsif C = '1' then
--                      Is_White := false;
--                      Set(Item, Is_White);
--                  end if;
--              end loop;

--      exception 
--          when Constraint_Error =>
--              S := "---------- --------- ---------";
--      end Read_File;

--  begin

--      Ada.Text_IO.Open (File => Input_File, Mode => Ada.Text_IO.In_File, Name => "object.pbm");
--      while not End_OF_File (Input_File) loop
--          Read_File(Input_File, Image);
--      end loop;

--      Put(Image);
    
--      Ada.Text_IO.Close (File => Input_File);


--  end test;