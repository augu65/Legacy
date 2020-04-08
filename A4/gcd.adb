-- By: Jonah Stegman
-- Course: CIS*3190
-- A4
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Interfaces; use Interfaces;
procedure gcd is 
    type arr is array(1..3000) of Unsigned_64;
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


    function read return arr is
        fname : string(1..25);
        fp : file_type;
        arrnew : arr;
        length : natural;
    begin
        -- gets file
        put_line("Enter the filename: ");
        get_line(fname,length);
        open (fp, in_file, fname(1..length)); 
        -- Read in from file
        for i in 1..3000 Loop
            declare
                number : constant string := get_line(fp);
                temp : Unsigned_64;
            begin
                temp := Unsigned_64'Value(number);
                arrnew(i) := temp;
            end;
        end loop;
        close(fp);
        return arrnew;
    end read;
    
    -- variables in main
    start, end_time : Time;
    exec : Time_Span;
    numsize :  constant integer := 3000;
    arrnew : arr;
    i : integer := 1;
    x : Unsigned_64 := 0;
    y : Unsigned_64 := 0;
begin
    arrnew := read;
    --start doing gcd stuff
    i := 1;
    start := clock;
    loop
        exit when i > numsize-1;
        x := arrnew(i);
        i := i + 1;
        y := arrnew(i);
        y := eucluidNR_GCD(x,y);
    end loop;
    end_time := clock;
    exec := end_time - start;
    put_line("Execute time of eucluidNR_GCD: " & Duration'Image (To_Duration(exec)) & " seconds");
    i := 1;
    start := clock;
    loop
        exit when i > numsize-1;
        x := arrnew(i);
        i := i + 1;
        y := arrnew(i);
        y := euclidR_GCD(x,y);
    end loop;
    end_time := clock;
    exec := end_time - start;
    put_line("Execute time of euclidR_GCD: " & Duration'Image (To_Duration(exec)) & " seconds");
    i := 1;
    start := clock;
    loop
        exit when i > numsize-1;
        x := arrnew(i);
        i := i + 1;
        y := arrnew(i);
        y := stein_GCD(x,y);
    end loop;
    end_time := clock;
    exec := end_time - start;
    put_line("Execute time of Stein_GCD: " & Duration'Image (To_Duration(exec)) & " seconds");
end gcd;