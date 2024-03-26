COMMENT @
TITLE: PA5_Nghi_Vu.asm
;// Name: Nghi Vu
;// Description: MASM32 program that checks if a user string input is a palindrome
@

INCLUDE irvine32.inc 

; list of function declarations 
menuScreen PROTO; displays menu



; useful symbols 
newline TEXTEQU <0Ah, 0Dh>
move EQU mov
jump EQU jmp

.data

.code
; //////////////////// main PROCEDURE START ///////////////////
main PROC
; LOCAL menuInput : byte

starthere :
call clrscr
call menuScreen 


exit

main ENDP


; //////////////////// MENU PROCEDURE START ///////////////////

menuScreen PROC

.data
menuPrompt byte "  Menu", newline, 
"========", newline,
"1. Enter string", newline,
"2. Convert string to all lowercase", newline,
"3. Remove all non-letter characters", newline,
"4. Check if string is a palindrome", newline,
"5. Print the current string", newline,
"6. Exit", newline,
"========", newline,
" Please select an option: ", 0h

errorMsg byte "Invalid input. Press [Enter] to try again.", 0h


.code
mov edx, offset menuPrompt 
call writestring 
call readDec
call waitmsg

ret

menuScreen ENDP

; //////////////////// MENU PROCEDURE END ///////////////////



end main
; //////////////////// main PROCEDURE END ///////////////////