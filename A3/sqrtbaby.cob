       IDENTIFICATION DIVISION.
       PROGRAM-ID. SQRTBAB.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT STANDARD-OUTPUT ASSIGN TO DISPLAY.
       DATA DIVISION.
       FILE SECTION.
       FD STANDARD-OUTPUT.
           01 OUT-LINE  PICTURE X(80).
       WORKING-STORAGE SECTION.
       77 IN-Z  PICTURE s9(11)v9(6).
       77 DIFF PICTURE V9(5).
       77 Z    PICTURE 9(11)V9(6).
       77 K    PICTURE S9999.
       77 X    PICTURE 9(11)V9(6).
       77 Y    PICTURE 9(11)V9(6).
       77 TEMP PICTURE 9(11)V9(6).
       77 IN-DIFF PICTURE V9(5).
       01 TITLE-LINE.
          02 FILLER PICTURE X(9) VALUE SPACES.
          02 FILLER PICTURE X(26) VALUE 'SQUARE ROOT APPROXIMATIONS'.
       01 UNDER-LINE.
          02 FILLER PICTURE X(44) VALUE 
             '--------------------------------------------'.
       01 COL-HEADS.
          02 FILLER PICTURE X(8) VALUE SPACES.
          02 FILLER PICTURE X(6) VALUE 'NUMBER'.
          02 FILLER PICTURE X(15) VALUE SPACES.
          02 FILLER PICTURE X(11) VALUE 'SQUARE ROOT'.
       01 UNDERLINE-2.
          02 FILLER PICTURE X(20) VALUE ' -------------------'.
          02 FILLER PICTURE X(5) VALUE SPACES.
          02 FILLER PICTURE X(19) VALUE '------------------'.
       01 PRINT-LINE.
          02 FILLER PICTURE X VALUE SPACE.
          02 OUT-Z  PICTURE Z(11)9.9(6).
          02 FILLER PICTURE X(5) VALUE SPACES.
          02 OUT-Y  PICTURE Z(11)9.9(6).
       01 ERROR-MESS.
          02 FILLER PICTURE X VALUE SPACE.
          02 OT-Z   PICTURE -(11)9.9(6).
          02 FILLER PICTURE X(21) VALUE '        INVALID INPUT'.
       01 ABORT-MESS.
          02 FILLER PICTURE X VALUE SPACE.
          02 OUTP-Z PICTURE Z(11)9.9(6).
          02 FILLER PICTURE X(37) VALUE
             '  ATTEMPT ABORTED,TOO MANY ITERATIONS'.
       01 QUIT.
          02 FILLER PICTURE X(38) VALUE
             ' EXITING THE PROGRAM. HAVE A GOOD DAY!'.
       01 INPUT-DATA.
          02 FILLER PICTURE X(39) VALUE
             ' PLEASE ENTER A NUMBER TO BE CALULATED:'.
       01 EXIT-HOW.
          02 FILLER PICTURE X(38) VALUE
             ' ENTER A NEGATIVE NUMBER TO EXIT.     '.
       77 DONE pic 9.
       PROCEDURE DIVISION.
           OPEN OUTPUT STANDARD-OUTPUT.
           PERFORM M1 UNTIL IN-Z < 0.

       M1.
           WRITE OUT-LINE FROM EXIT-HOW AFTER ADVANCING 1 LINE.
           WRITE OUT-LINE FROM INPUT-DATA AFTER ADVANCING 1 LINE. 
           accept IN-Z.
           if IN-Z < 0 then 
               write out-line from QUIT
               perform finish
           ELSE
               WRITE OUT-LINE FROM TITLE-LINE AFTER ADVANCING 0 LINES
               WRITE OUT-LINE FROM UNDER-LINE AFTER ADVANCING 1 LINE
               WRITE OUT-LINE FROM COL-HEADS AFTER ADVANCING 1 LINE
               WRITE OUT-LINE FROM UNDERLINE-2 AFTER ADVANCING 1 LINE
               if IN-Z = 0 then
                   MOVE IN-Z TO OT-Z
                   WRITE OUT-LINE FROM ERROR-MESS AFTER ADVANCING 1 LINE
               ELSE
                   perform S1
               END-IF
           END-IF.
       S1. 
           MOVE 0 to DONE.
               IF IN-Z > ZERO 
                   MOVE IN-DIFF TO DIFF
                   MOVE IN-Z TO Z
                   DIVIDE 2 INTO Z GIVING X ROUNDED
                   PERFORM S2 VARYING K FROM 1 BY 1
                       UNTIL K IS GREATER THAN 1000
                   MOVE IN-Z TO OUTP-Z
                   WRITE OUT-LINE FROM ABORT-MESS AFTER ADVANCING 1 LINE
                   PERFORM S1
               END-IF.

       S2. 
           COMPUTE Y ROUNDED = 0.5 * (X + Z / X).
           SUBTRACT X FROM Y GIVING TEMP.
           IF NOT TEMP > ZERO 
               COMPUTE TEMP = - TEMP
           END-IF.
           IF TEMP / (Y + X) > DIFF
               MOVE Y TO X
           ELSE
               MOVE IN-Z TO OUT-Z
               MOVE Y TO OUT-Y
               WRITE OUT-LINE FROM PRINT-LINE AFTER ADVANCING 1 LINE
               PERFORM M1
           END-IF.
       FINISH.
           CLOSE STANDARD-OUTPUT. 
       STOP RUN.
