-- By: Jonah Stegman
-- Course: CIS*3190
-- A4
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Interfaces; use Interfaces;
procedure euclids is 
    function gcd(q: Unsigned_64; w: Unsigned_64) return Unsigned_64 is
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
    end gcd;
    
    function recursive_gcd(x: Unsigned_64; y: Unsigned_64) return Unsigned_64 is
    begin
        if y = 0 then
            return x;
        else
            return recursive_gcd(y, x mod y);
        end if;
    end recursive_gcd; 

    function stein_gcd(x: Unsigned_64; y: Unsigned_64) return Unsigned_64 is
    z: Unsigned_64;
    begin
        if x = y or y = 0 then
            return x;
        elsif x = 0 then
            return y;
        end if;
        if x mod 2 = 0 then
            if y mod 2 /= 0 then
                return stein_gcd(Shift_Right(x, 1), y);   
            else
                return Shift_Left(stein_gcd(Shift_Right(x, 1), Shift_Right(y, 1)), 1);
            end if;
        end if;
        if y mod 2 = 0 then
            return stein_gcd(x, Shift_Right(y, 1));
        end if;
        if x > y then
            z := x - y;
            return stein_gcd(Shift_Right(z, 1), y);
        end if;
        z := y - x;
        return stein_gcd(Shift_Right(z, 1), x);
    end stein_gcd;

    start, end_time : Time;
    exec : Time_Span;
    val : Unsigned_64 := 0;
begin
    start := clock;
    val := gcd(3496,13);
    end_time := clock;
    exec := end_time - start;
    put_line("Time to Execute: " & Duration'Image (To_Duration(exec)) & " seconds");
    start := clock;
    val := recursive_gcd(3496,13);
    end_time := clock;
    exec := end_time - start;
    put_line("Time to Execute: " & Duration'Image (To_Duration(exec)) & " seconds");
    start := clock;
    val := stein_gcd(3496,13);
    end_time := clock;
    exec := end_time - start;
    put_line("Time to Execute: " & Duration'Image (To_Duration(exec)) & " seconds");
end euclids;