-- By: Jonah Stegman
-- Course: CIS*3190
-- scrammble words using ada
with Ada.Text_IO; use Ada.Text_IO;
with ada.numerics.discrete_random;
procedure wordscram is 
    -- gets the filename from the user
    function getFilename return string is
        filename : string (1..100);
        size : natural;
        flag : integer := 0;
        file : file_type;
    begin
        loop
            flag := 0;
            put_line("Enter the file name: "); 
            get_line(filename,size);
            begin
                open(file,in_file,filename(1..size));
                close(file);
            exception
                when Name_Error =>
                    flag := 1;
            end;
            exit when flag = 0;
        end loop;
        return filename(1..size);
    end getFilename;

    -- Reads in file
    function processText(filename: string) return integer is
        input : file_type;
        begin
            open (file => input,
                mode => in_file,
                name => filename);
            loop
                declare
                    line: string := get_line (input);
                    put_line(line);
                end;
            end loop;
            close(input);
        exception
            when End_Error =>
                if is_open(input) then 
                    close(input);
                end if;
            put_line(filename);
            return 0;
        end processText;

    -- Variables for the main
    flag: integer:=1;
    userfile: constant string := getFilename;
begin

    flag:=processText(userfile);
    if flag = 0 then
        put_line("success");
    end if;
end wordscram;


--function processText()
--begin
--end processText;

--function scrambleWord()
--begin
--end scrambleWord;

--function randomInt() return integer is
--    type randRange is new Integer range 1..100;
--    package Rand_Int is new ada.numerics.discrete_random(randRange);
--    use Rand_Int;
--    gen : Generator;
--    num : randRange
--    num: integer
--begin
--    reset(gen);
--    num:= random(gen);
--    put_line(randRange'Image(num));
--    return num;
--end randomInt;

--function isWord() return boolean is
--begin
--end isWord;