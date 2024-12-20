-- Antgu873: Arbetat enskilt

with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Command_Line;      use Ada.Command_Line;

procedure adao81 is 

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

    function Check_Arg return Boolean is
        procName : String := "adao81";
    begin

        if Argument_Count /= 2 then
            Put("Error! Incorrect number of arguments!");
            New_Line;
            Put("Usage: ./executable_program˽IMAGE_FILENAME˽N˽[X˽Y]");
            return false;
        end if;

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

        return true;
    end Check_Arg;
    
    function Check_Format_PBM (S : in     String) return Boolean is
    begin
        if S(S'First..S'First + 2) = "P1a" then
            return false;
        else
            return true;
        end if;
    exception
        when Constraint_Error=>
            return true;
    end Check_Format_PBM;

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
                if Item.Image_Area(I, Z).Alpha then
                    Put("TRUE ");
                else
                    Put("FALSE ");
                end if;
            end loop;
            New_Line;
        end loop;
    end Put;

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
        Item.Alpha := false;
    end Set_White;

    procedure Open_File (File_Item :    out File_Type) is
        I_File_Name : String := Argument(1);
    begin
        Open(File_Item, In_File, I_File_Name);
    end Open_File;

    procedure Close_File (File_Item :    out File_Type) is
    begin
        Close(File_Item);
    end Close_File;

    procedure Parse_Image (Item      :    out Image_Type;
                           File_Item : in     File_Type;
                           Incr : in     Integer) is
        C : Character;
    begin
        for Z in 1..Item.Y_Dim loop
            for I in 1..(Item.X_Dim) loop
                Get(File_Item, C);
                if C = '0' then
                    Set_White(Item.Image_Area(Z, I));
                elsif C = '1' then
                    Set_Black(Item.Image_Area(Z, I));
                end if;

                if (Incr = 2) then
                    Get(File_Item, C);
                    if C = '1' then
                        Item.Image_Area(Z, I).Alpha := true;
                    end if;
                end if;
            end loop;
        end loop;
    end Parse_Image;

    procedure Read (Item      :    out Image_Type;
                    File_Item : in     File_Type) is
        File_Format, File_Comment, File_Dimension : String := Get_Line(File_Item);
    begin
            while not End_OF_File (File_Item) loop
                if Check_Format_PBM(File_Format) then 
                    Parse_Image(Item, File_Item, 1);
                else
                    Parse_Image(Item, File_Item, 2);
                end if;
            end loop;
    end Read;

    procedure Print_Image_Information (Item :    out Image_Type) is
        File_Item : File_Type;
    begin
        Open_File(File_Item);
        Read(Item, File_Item);
        Put(Item);
        Close(File_Item);
    end Print_Image_Information;

    procedure Print_Image_Information (Img_Item    : in out Image_Type;
                                       I_File_Item : in     File_Type) is
        O_File_Item : File_Type;
        O_File_Name : String := Argument(2);
    begin
        Read(Img_Item, I_File_Item);
        Create(O_File_Item, Out_File, O_File_Name);
        Set_Output(O_File_Item);
        Put(Img_Item);
        Close(O_File_Item);
        Set_Output(Standard_Output);
    exception 
        when Constraint_Error =>
            return;
    end Print_Image_Information;

---------- Put_Image is only here for testing ---------------------------
    procedure Put_Image (Item : in     Image_Type) is
    begin
        for Z in 1..Item.Y_Dim loop
            for I in 1..Item.X_Dim loop
                if Item.Image_Area(I, Z).R /= 0 then
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
        Output_File : File_Type;
        Image : Image_Type;
begin
    if Check_Arg then
        Print_Image_Information(Image);
        Open_File(Input_File);
        Print_Image_Information(Image, Input_File);
        Close_File(Input_File);    
    else
        return;
    end if;
        -- SHOW IMAGE IN TERMINAL FOR TESTING
        -- Put_Image(Image);
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