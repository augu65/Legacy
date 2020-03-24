       identification division.
       program-id. sqrt_two.
       environment division.
       data division.
       working-storage section.
       linkage section.
       procedure division using .

       calc_sqrt. 
           *> computes square root
           compute y rounded = 0.5 * (x + z / x).
           compute temp = y - x.
           if not temp > 0 then
               compute temp = - temp
           end-if.
           if temp / (y + x) > 0 then
               move y to x
           else
               *> assigns values to out variables
               move in-z to out-z
               move y to out-y
               write out-line from print-line after advancing 1 line
               *> returns to get more input
               perform main
           end-if.
