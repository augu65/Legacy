-- By: Jonah Stegman
-- Course: CIS*3190
-- scrammble words using ada
with Ada.Text_IO; use Ada.Text_IO;
with ada.numerics.discrete_random;
procedure wordscram is 

        -- checks if input is a word
        function isWord(word: string) return boolean is
        begin
            for j in word'range loop
                if word(j) not in 'A'..'Z' and word(j) not in 'a'..'z' then 
                    return false;
                end if;
            end loop;
            return true;
        end isWord;


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
                when Name_Error => flag := 1;
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
                    line: string := get_line(input);
                    word : string(1..100);
                    boolWord : boolean;
                    j : integer := 1;
                    n : integer := 0;
                    subtype lower is character range 'a'..'z';
                    subtype upper is character range 'A'..'Z';
                    subtype number is character range '0'..'9';
                begin
                    while  line'last >= j loop
                        if line(j) in upper or line(j) in lower or line(j) in number then 
                            n := n + 1;
                            word(n) := line(j);
                        else
                            boolWord := isWord(word(1..n));
                            if boolWord then
                                
                            else
                                put(word(1..n));
                            end if;
                            n := 0;
                            put(line(j));
                        end if;
                        j := j + 1;
                        if line'last < j then
                            boolWord := isWord(word(1..n));
                            if boolWord then
                                put(word(1..n));
                            else
                                put(word(1..n));
                            end if;
                        end if;
                    end loop;
                end;
                put_line("");
            end loop;
        exception
            when End_Error =>
                if is_open(input) then 
                    close(input);
                end if;
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
