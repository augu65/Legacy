       *> by: jonah stegman
       *> course: cis*3190
       *> a3
       identification division.
       program-id. sqrtbabyex.
       environment division.
       input-output section.
       file-control.
           select standard-output assign to display.
       data division.
       file section.
       fd standard-output.
           01 out-line  picture x(80).
       working-storage section.
       *> input value
       77 in-z  picture s9(11)v9(6).
       *> values used to calulate square root
       77 z    picture 9(11)v9(6).
       77 y    picture 9(11)v9(6).

       *> display
       01 title-line.
          02 filler picture x(9) value spaces.
          02 filler picture x(26) value 'square root approximations'.
       01 under-line.
          02 filler picture x(44) value 
             '--------------------------------------------'.
       01 col-heads.
          02 filler picture x(8) value spaces.
          02 filler picture x(6) value 'number'.
          02 filler picture x(15) value spaces.
          02 filler picture x(11) value 'square root'.
       01 underline-2.
          02 filler picture x(20) value ' -------------------'.
          02 filler picture x(5) value spaces.
          02 filler picture x(19) value '------------------'.
       01 print-line.
          02 filler picture x value space.
          02 out-z  picture z(11)9.9(6).
          02 filler picture x(5) value spaces.
          02 out-y  picture z(11)9.9(6).
       01 error-mess.
          02 filler picture x value space.
          02 ot-z   picture -(11)9.9(6).
          02 filler picture x(21) value 
             '        invalid input'.
       01 quit.
          02 filler picture x(38) value
             ' exiting the program. have a good day!'.
       01 input-data.
          02 filler picture x(39) value
             ' please enter a number to be calulated:'.
       01 exit-how.
          02 filler picture x(19) value
             ' enter zero to exit.     '.
       01 welcome.
          02 filler picture x(44) value
             ' welcome to the cobol square root calculator'.

       procedure division.
           open output standard-output.
           *> displays welcome message
           write out-line from welcome after advancing 1 line.
           
       main.
           *> displays prompt and exit message
           write out-line from exit-how after advancing 1 line.
           write out-line from input-data after advancing 1 line. 
           *> gets input
           accept in-z.
           *> checks if entry is = to an exit value
           if in-z = 0 then 
               *> displays exit message
               write out-line from quit
               *> used to close the standard output
               close standard-output
               stop run
           else
               *>displays square root value
               write out-line from title-line after advancing 0 lines
               write out-line from under-line after advancing 1 line
               write out-line from col-heads after advancing 1 line
               write out-line from underline-2 after advancing 1 line
               *> checks if value is 0
               if in-z < 0 then
                   move in-z to ot-z
                   *> displays error message
                   write out-line from error-mess after advancing 1 line
                   perform main
               else
                   perform sqrt_prep
               end-if
           end-if.

       sqrt_prep. 
           *> moves input to z to be maninpulated
           move in-z to z.
           call 'sqrtbabyex_calc' using z, y.
           *> assigns values to out variables
           move in-z to out-z
           move y to out-y
           write out-line from print-line after advancing 1 line
           perform main.
