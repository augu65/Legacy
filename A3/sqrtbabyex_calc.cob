       identification division.
       program-id. sqrtbabyex_calc.
       environment division.
       data division.
       *> Variables
       working-storage section.
       77 k    picture s9999.
       77 temp picture 9(11)v9(6).
       77 x    picture 9(11)v9(6).
       *>shared variables
       linkage section.
       77 y    picture 9(11)v9(6).
       77 z    picture 9(11)v9(6).

       procedure division using z, y.
       compute x rounded = z / 2.
       perform calc_sqrt varying k from 1 by 1
             until k is greater than 1000.
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
               *>returns to main function
               goback
           end-if.
