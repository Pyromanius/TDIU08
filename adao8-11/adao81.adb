with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;     use Ada.Float_Text_IO;
with Ada.Command_Line;      use Ada.Command_Line;

procedure adao81 is

        procName : String := "adao81";
        File_Name : String := Argument(1);



    subtype RGB_Value is Integer range 0..255;

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

    procedure Print_Image_Information (Item       :    out Image_Type;
                                       File_Item : in  out File_Type) is
        procedure Set_Black (Item :    out Pixel_Type) is
        begin
            Item.R := 0;
            Item.G := 0;
            Item.B := 0;
            Item.Alpha := false;
        end Set_Black;

        procedure Set_White (Item :    out Pixel_Type) is
        begin
            Item.R := 255;
            Item.G := 255;
            Item.B := 255;
            Item.Alpha := true;
        end Set_White;

        procedure Put (Item : in     Image_Type) is
        begin
            for Z in 1..Item.Y_Dim loop
                for I in 1..Item.X_Dim loop
                    Put(Item.Image_Area(I, Z).R, Width=>3);
                    Put(" ");
                    Put(Item.Image_Area(I, Z).G, Width=>3);
                    Put(" ");
                    Put(Item.Image_Area(I, Z).B, Width=>3);
                    Put(" ");
                    Put(Item.Image_Area(I, Z).Alpha'Image);
                    Put(" ");
                    if Item.Image_Area(I, Z).Alpha then
                        Put(" ");
                    end if;
                end loop;
                New_Line;
            end loop;
        end Put;


        procedure Read_File (Item :    out Image_Type) is
            S : String(1..Item.X_Dim);
        begin
            for Z in 1..Item.Y_Dim loop 

                S := Get_Line(File_Item);

                for I in 1..Item.X_Dim loop
                    if S(I) = '0' then
                        Set_White(Item.Image_Area(Z, I));
                    elsif S(I) = '1' then
                        Set_Black(Item.Image_Area(Z, I));
                    else
                        raise Constraint_Error;
                    end if;
                end loop;
            end loop;

        exception 
            when Constraint_Error =>
                return;
        end Read_File;

    begin
        
        while not End_OF_File (File_Item) loop
            Read_File(Item);
        end loop;

        Put(Item);


    end Print_Image_Information;


---------- Put_Image is only here for testing ---------------------------
    procedure Put_Image (Item : in     Image_Type) is
    begin
        for Z in 1..Item.Y_Dim loop
            for I in 1..Item.X_Dim loop
                if Item.Image_Area(I, Z).Alpha then
                    Put(" ");
                else
                    Put("-");
                end if;
            end loop;
            New_Line;
        end loop;
    end Put_Image;
---------- Put_Image is only here for testing ---------------------------

        Input_File : File_Type;
        Image : Image_Type;

begin
    
    Ada.Text_IO.Open (File => Input_File, Mode => Ada.Text_IO.In_File, Name => File_Name);

    if check_Arg then
        Print_Image_Information(Image, Input_File);
    end if;
        
    Ada.Text_IO.Close (File => Input_File);

    New_Line;
    New_Line;

    Put_Image(Image);

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