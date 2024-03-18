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

--      File_Name : constant String := "object.pbm";
    
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
--              X_Dim : Integer := 30;
--              Y_Dim : Integer := 30;
--              Image_Area : Image_Area_Type;
--          end record;

--      Input_File : File_Type;
--      Image : Image_Type;
--      S : String(1..Image.X_Dim);

--      procedure Set_Black (Item :    out Pixel_Type) is
--      begin
--          Item.R := 0;
--          Item.G := 0;
--          Item.B := 0;
--          Item.Alpha := false;
--      end Set_Black;

--      procedure Set_White (Item :    out Pixel_Type) is
--      begin
--          Item.R := 255;
--          Item.G := 255;
--          Item.B := 255;
--          Item.Alpha := true;
--      end Set_White;


--      procedure Put (Item : in     Image_Type) is
--      begin
--          for Z in 1..Image.Y_Dim loop
--              for I in 1..Image.X_Dim loop
--                  Put(Item.Image_Area(I, Z).R, Width=>3);
--                  Put(" ");
--                  Put(Item.Image_Area(I, Z).G, Width=>3);
--                  Put(" ");
--                  Put(Item.Image_Area(I, Z).B, Width=>3);
--                  Put(" ");
--                  Put(Item.Image_Area(I, Z).Alpha'Image);
--                  Put(" ");
--                  if Item.Image_Area(I, Z).Alpha then
--                      Put(" ");
--                  end if;
--              end loop;
--              New_Line;
--          end loop;
--      end Put;

--      procedure Read_File (Item :    out Image_Type) is

--      begin

--          for Z in 1..Image.Y_Dim loop      
--              S := Get_Line(Input_File);

--                  for I in 1..Image.X_Dim loop
--                      if S(I) = '0' then
--                          Set_White(Item.Image_Area(Z, I));
--                      elsif S(I) = '1' then
--                          Set_Black(Item.Image_Area(Z, I));
--                      else
--                          raise Constraint_Error;
--                      end if;
--                  end loop;
--          end loop;

--      exception 
--          when Constraint_Error =>
--              return;
--      end Read_File;

--  begin

--      Ada.Text_IO.Open (File => Input_File, Mode => Ada.Text_IO.In_File, Name => File_Name);
--      while not End_OF_File (Input_File) loop
--          Read_File(Image);
--      end loop;

--      Put(Image);

--      Ada.Text_IO.Close (File => Input_File);

--  end test;