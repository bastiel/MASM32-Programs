TITLE PA4_Nghi_Vu.asm
; Nghi Vu

INCLUDE Irvine32.inc

newline TEXTEQU <0Ah, 0Dh>
move EQU mov
jump EQU jmp



UserInput PROTO 
GenerateString PROTO
clearStr PROTO
HowMany PROTO
processInput PROTO
nline PROTO, s:byte


.data
	numOfStr byte ? ; max of 255 strings 
	listOfStr DWORD 255 DUP(?)  

.code
;#region main
main PROC
	call Randomize 
	start: 
	mov esi, 0
	mov ecx, 0
	mov esi, offset listOfStr 
	mov ecx, 255
	call clearStr 
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov esi, 0
	mov edi, 0

	call UserInput
	mov numOfStr, al ; holds num of strings for now 

	call HowMany

	jmp start 

	quit:
	mov edx, offset quitMsg
	call writestring 
	exit
main ENDP
;#endregion

;#region UserInput
UserInput PROC 

.data
	menuPrompt BYTE newline, "Enter how many random strings you want to generate (1 to 255),", newline,
					"or enter 00 to quit", newline,
					"========================", newline,
					"Input: ",0h
.code 
	push ebx
	start: 
		mov edx, offset menuPrompt 
		call writestring
		call readInt 
		call processInput
		cmp bl, 1 ;indicate error
		je start ; restart until valid input 

	pop ebx 

	ret  
UserInput ENDP
;#endregion

;#region processInput
processInput PROC 
.data
	quitMsg BYTE newline, "Exiting program...", newline, "Goodbye.", newline, 0h
	invalidMsg BYTE "Error. Your input must be between 1 and 255. Try again.",newline,newline, 0h
.code 
	mov bl, 0
	cmp eax, 0
	je quit 
	jb error
	cmp eax, 255
	ja error

	ret
	
	error:
		mov edx, offset invalidMsg
		call writestring 
		mov bl, 1 ; indicate error 
		ret

	quit:
	mov edx, offset quitMsg
	call writestring 
	exit
processInput ENDP 
;#endregion

;#region GenerateString

.data

.code 

;#endregion 

;#region HowMany
HowMany PROC 
.data
	StringLen byte ?
.code 
	push eax
	push ebx 

	range:
		mov eax, 35
		call randomRange 
		cmp eax, 10
		jb range 

	pop eax 
	call writedec
	pop ebx 
	
	ret 
HowMany ENDP 
;#endregion