-- By: Jonah Stegman
-- Course: CIS*3190
-- scrammble words using ada
with Ada.Text_IO; use Ada.Text_IO;
with ada.numerics.discrete_random;
procedure wordscram is 
     type int_arr is array (1..30) of integer;
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

    --generates a random number
    function randomInt(max:integer; arr: int_arr) return integer  is
            type Rand_Range is new integer range 2..max;
            package Rand_Int is new Ada.Numerics.Discrete_Random(Rand_Range);
            seed : Rand_Int.Generator;
            num : Rand_Range;
            check : boolean := false;
            i : integer := 1;
            number : integer;
    begin
        loop
            i := 1;
            check := true;
            Rand_Int.Reset(seed);
            num := Rand_Int.Random(seed);
            number := Integer'Value(Rand_range'Image(num));
            loop
                if number = arr(i) then
                    check := false;
                    exit;
                end if;
                i := i + 1;
                exit when i > max;
            end loop;
            exit when check;
        end loop;
        return number;
    end randomInt;


    -- scrambles the word
    function scrambleWord(original:string; max:integer) return string is
        num : integer :=1;
        j : integer := 2;
        k : integer := 1;
        word : string := original;
        arr : int_arr := (1..30 => 0);
    begin
        loop
            num := randomInt(max,arr);
            arr(k) := num;
            word(num) := original(j);
            j := j + 1;
            k := k + 1;
            exit when j > max;
        end loop;
        return word;
    end scrambleWord;


    -- Reads in file
    function processText(filename: string) return integer is
        input : file_type;
        begin
            open (file => input,
                mode => in_file,
                name => filename);
            loop
                declare
                    line: constant string := get_line(input);
                    word : string(1..100);
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
                            if isWord(word(1..n)) and n > 3 then
                                put(scrambleWord(word(1..n),n-1));
                            else
                                put(word(1..n));
                            end if;
                            n := 0;
                            put(line(j));
                        end if;
                        j := j + 1;
                        if line'last < j then
                            if isWord(word(1..n)) and n > 3 then
                                put(scrambleWord(word(1..n),n-1));
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
    if flag = 1 then
        put_line("Error");
    end if;
end wordscram;
