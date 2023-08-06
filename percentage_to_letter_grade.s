@ Problem Statement: Convert a percentage grade to a letter grade and print the result.

@ Define constants for grade thresholds
@ These constants can be adjusted as needed for different grading scales
@ For example, if the grading scale changes to A=85, B=70, C=50, F=0,
@ these constants can be modified accordingly.

@ Grade thresholds for letter grades
GRADE_A_THRESHOLD EQU 90
GRADE_B_THRESHOLD EQU 75
GRADE_C_THRESHOLD EQU 50

@ Start of the program
    .text

    @ Entry point of the program
    @ The program expects the percentage grade to be passed in R5
    @ The main function will call the conversion subroutine and then exit
    main:
        @ Call the conversion subroutine
        BL convertToLetterGrade

        @ Exit the program
        MOV R7, #1       @ Exit syscall number
        SWI 0            @ Invoke syscall to exit

    @ Subroutine to convert percentage grade to letter grade
    @ Inputs: R5 - Percentage grade
    @ Outputs: None (Result is printed to the terminal)
    convertToLetterGrade:
        @ Check if the percentage grade is greater than or equal to GRADE_A_THRESHOLD
        CMP R5, #GRADE_A_THRESHOLD
        BGE .gradeA

        @ Check if the percentage grade is greater than or equal to GRADE_B_THRESHOLD
        CMP R5, #GRADE_B_THRESHOLD
        BGE .gradeB

        @ Check if the percentage grade is greater than or equal to GRADE_C_THRESHOLD
        CMP R5, #GRADE_C_THRESHOLD
        BGE .gradeC

        @ If none of the previous conditions are met, it means the grade is below GRADE_C_THRESHOLD
        @ Print "Sorry, you got an F." to the terminal
        @ We use a syscall to print the string, assuming it's available in memory
        MOV R0, #4        @ Syscall number for write
        MOV R1, #1        @ File descriptor for standard output (terminal)
        LDR R2, =failMsg  @ Load the address of the failMsg string into R2
        MOV R3, #failMsgLen @ Length of the failMsg string
        SWI 0             @ Invoke syscall to print the message
        B .end

    .gradeA:
        @ Print "Congratulations! You got an A." to the terminal
        MOV R0, #4        @ Syscall number for write
        MOV R1, #1        @ File descriptor for standard output (terminal)
        LDR R2, =aMsg     @ Load the address of the aMsg string into R2
        MOV R3, #aMsgLen  @ Length of the aMsg string
        SWI 0             @ Invoke syscall to print the message
        B .end

    .gradeB:
        @ Print "Good job! You got a B." to the terminal
        MOV R0, #4        @ Syscall number for write
        MOV R1, #1        @ File descriptor for standard output (terminal)
        LDR R2, =bMsg     @ Load the address of the bMsg string into R2
        MOV R3, #bMsgLen  @ Length of the bMsg string
        SWI 0             @ Invoke syscall to print the message
        B .end

    .gradeC:
        @ Print "Not bad, you got a C." to the terminal
        MOV R0, #4        @ Syscall number for write
        MOV R1, #1        @ File descriptor for standard output (terminal)
        LDR R2, =cMsg     @ Load the address of the cMsg string into R2
        MOV R3, #cMsgLen  @ Length of the cMsg string
        SWI 0             @ Invoke syscall to print the message

    .end:
        BX LR             @ Return from the subroutine

    @ Strings to be printed
    aMsg:              @ Congratulations! You got an A.
        .asciz "Congratulations! You got an A.\n"
    bMsg:              @ Good job! You got a B.
        .asciz "Good job! You got a B.\n"
    cMsg:              @ Not bad, you got a C.
        .asciz "Not bad, you got a C.\n"
    failMsg:           @ Sorry, you got an F.
        .asciz "Sorry, you got an F.\n"

    @ Lengths of the strings (excluding the null terminator)
    aMsgLen EQU . - aMsg
    bMsgLen EQU . - bMsg
    cMsgLen EQU . - cMsg
    failMsgLen EQU . - failMsg
