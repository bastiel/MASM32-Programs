TITLE: test1.asm
;// Name: Nghi Vu
;// Description: Program about prime numbers and Euclid's algorithm'


INCLUDE irvine32.inc 

; list of function declarations 
menuScreen PROTO; displays menu



; useful symbols 
newline TEXTEQU <0Ah, 0Dh>
move EQU mov
jump EQU jmp

.data
msg_greet byte "Hello. Welcome to my assembly sandbox.", newline, 0h


.code
main PROC
LOCAL menuInput : byte

starthere :
call clrscr
mov edx, 0
mov edx, offset msg_greet 
call writeString 
call waitMs

ret

main ENDP
end main







; //////////////////// MENU PROCEDURE END ///////////////////