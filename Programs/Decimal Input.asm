INCLUDE Irvine32.inc

newline TEXTEQU <0Ah, 0Dh>
move EQU mov
jump EQU jmp
CLEAREAX TEXTEQU <move ebx, 0> 
CLEAREBX TEXTEQU <move ebx, 0>
CLEARECX TEXTEQU <move ecx, 0>
CLEAREDX TEXTEQU <move edx, 0>


str_num_input PROTO ; asks for number in string form
int_input PROTO  ; asks for number in int form 
printChar PROTO ; prints numbers up to user specified location 
dec_after_str PROTO ; prints trailing zeros if decimal greater than str len
menu PROTO

.data

.code
main PROC
start:
	cleareax
	clearebx
	clearecx
	clearedx

	call str_num_input
	call int_input
	call printChar

	exit
main endp
;///// main ENDS //////


; str_num_input START 
str_num_input PROC
COMMENT~/*
---------------------------------------------------------------------------------
	str_num_input

	Description: Gets string input of a number from user
	Receives: nothing 
	Returns: String to edx and length to eax
	Requires: Nothing
---------------------------------------------------------------------------------
~*/

.data
	msg_str_prompt BYTE "Enter an unsigned number: ", 0
	max_char BYTE 25

.code
	mov edx, offset msg_str_prompt
	movzx ecx, max_char 
	call writeString
	call readString
	
	COMMENT @
	; this tests user input
	call writeString
	call waitmsg
	@

ret
str_num_input ENDP

int_input PROC
COMMENT~/*
---------------------------------------------------------------------------------
	int_input

	Description: Gets decimal location as an int from user
	Receives: nothing 
	Returns: Int decimal place to eax
	Requires: Nothing
---------------------------------------------------------------------------------
~*/

.data 
	msg_int_prompt BYTE "Insert a decimal in location: ", 0

.code
	; save str  len to ebx 
	mov ebx, eax
	push edx
	mov edx, offset msg_int_prompt
	call writestring
	call readDec
	pop edx 

	COMMENT @
	; test input
	call writeDec
	call waitmsg
	@ 

ret
int_input ENDP




;printChar START 
; print char and decimal 
printChar  PROC 
COMMENT~/*
---------------------------------------------------------------------------------
	printChar 

	Description: print string up to specific decimal location, then continue printing rest of string if decimal location is positive
	Receives: nothing 
	Returns: nothing
	Requires: Nothing
---------------------------------------------------------------------------------
~*/

.data

.code

; push ecx 1
push ecx
mov esi, 0
mov ecx, ebx 

cmp eax, ebx 
je print_up_to
cmp eax, 0
je print_up_to

; save dec location 1
push eax 
; move dec location to ecx 
mov ecx, eax 

print_up_to:
	mov al, [edx + esi]
	call WriteChar
	inc esi
	loop print_up_to

; restore dec location 1
pop eax

cmp eax, ebx 
je done
cmp eax, 0
je done

print_dec:
;save dec location
push eax
mov al, '.'
call writeChar
; recover dec location
pop eax

; move str length to ecx
sub ebx, eax
mov ecx, ebx
; esi at current location

cont_print:
	mov al, [edx + esi]
	call WriteChar
	inc esi
	loop cont_print

done:
; recover ecx 1
pop ecx


call waitmsg

ret
printChar ENDP

COMMENT @
dec_after_str PROC

.data

.code
	dec_after_str:
	mov al, [edx + esi]
	call WriteChar
	inc esi
	loop dec_after_str

	; RESUME HERE!!!!!
	; need to subtract decimal location by str len
	leading_zeros:
		push eax
		mov al, 0
		call writeChar
		pop eax
	ret
dec_after_str ENDP
@

end main