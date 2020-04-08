-- By: Jonah Stegman
-- Course: CIS*3190
-- A4
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Interfaces; use Interfaces;
procedure gcd is 
    function eucluidNR_GCD(q: Unsigned_64; w: Unsigned_64) return Unsigned_64 is
    r: Unsigned_64;
    x: Unsigned_64 := q;
    y: Unsigned_64 := w;
    begin
        if y = 0 then
            return x;
        end if;
        r:= x mod y;
        while r /= 0 loop
            x := y;
            y := r;
            r := x mod y;
        end loop;
        return y;
    end eucluidNR_GCD;
    
    function euclidR_GCD(x: Unsigned_64; y: Unsigned_64) return Unsigned_64 is
    begin
        if y = 0 then
            return x;
        else
            return euclidR_GCD(y, x mod y);
        end if;
    end euclidR_GCD; 

    function stein_GCD(x: Unsigned_64; y: Unsigned_64) return Unsigned_64 is
    z: Unsigned_64;
    begin
        if x = y or y = 0 then
            return x;
        elsif x = 0 then
            return y;
        end if;
        if x mod 2 = 0 then
            if y mod 2 /= 0 then
                return stein_GCD(Shift_Right(x, 1), y);   
            else
                return Shift_Left(stein_GCD(Shift_Right(x, 1), Shift_Right(y, 1)), 1);
            end if;
        end if;
        if y mod 2 = 0 then
            return stein_GCD(x, Shift_Right(y, 1));
        end if;
        if x > y then
            z := x - y;
            return stein_GCD(Shift_Right(z, 1), y);
        end if;
        z := y - x;
        return stein_GCD(Shift_Right(z, 1), x);
    end stein_GCD;

    -- variables in main
    start, end_time : Time;
    exec : Time_Span;
    numsize : constant integer := 3000;
    arr : array(0..3000) of Unsigned_64;
    fp : file_type;
    i : integer := 1;
    x : Unsigned_64 := 0;
    y : Unsigned_64 := 0;
begin
open (file => fp,
    mode => in_file,
    name => "test.txt"); 
    -- makes array
        -- Read in from file
        While not End_Of_File (fp) Loop
            put_line(unsigned_64'Image(arr(i)));
            arr(i) := Unsigned_64'Value(Get_Line (fp));
            put_line(unsigned_64'Image(arr(i)));
            i := i + 1;
            exit when i > numsize;
        end loop;
    --start doing gcd stuff
    i := 1;
    start := clock;
    loop
        exit when i > numsize;
        x := arr(i);
        i := i + 1;
        y := arr(i);
        y := eucluidNR_GCD(x,y);
    end loop;
    end_time := clock;
    exec := end_time - start;
    put_line("Execute time of eucluidNR_GCD: " & Duration'Image (To_Duration(exec)) & " seconds");
    i := 1;
    start := clock;
    loop
        exit when i > numsize;
        x := arr(i);
        i := i + 1;
        y := arr(i);
        y := euclidR_GCD(x,y);
    end loop;
    end_time := clock;
    exec := end_time - start;
    put_line("Execute time of euclidR_GCD: " & Duration'Image (To_Duration(exec)) & " seconds");
    i := 1;
    start := clock;
    loop
        exit when i > numsize;
        x := arr(i);
        i := i + 1;
        y := arr(i);
        y := stein_GCD(x,y);
    end loop;
    end_time := clock;
    exec := end_time - start;
    put_line("Execute time of Stein_GCD: " & Duration'Image (To_Duration(exec)) & " seconds");
end gcd;