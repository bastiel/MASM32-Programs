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
GenerateCapital PROTO
processInput PROTO
nline PROTO, s:byte
printStr PROTO


.data
	listOfStr DWORD 5555 DUP(?)  

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
	mov esi, offset listofstr
	call generatestring
	mov esi, offset listofstr 
	;call printStr

	jmp start 

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
GenerateString PROC
.data
	numOfStr byte ? ; max of 255 strings 

.code 
	
	mov numOfStr, al 
	push eax 
	push ecx
	push edx
	movzx ecx, numofStr 

	genStrLoop:
		call howmany ; gets the length of the str, stores it in eax 
		push ecx ; saves outter loop count
		mov ecx, eax 
		mov edx, esi
		genLenLoop: ;generates a capital letter until it reaches specified length 
			call GenerateCapital ; generates random uppercase letter
			mov byte ptr [esi], al ; saves uppercase letter to array of strings, pointed to by esi 
			inc esi
			loop genLenLoop 
		call writestring
		call crlf 
		mov byte ptr [esi], 0
		inc esi
		pop ecx ; retrieves outter loop count 
		loop genStrLoop ; generates more strings until reaches user input (ecx)
	pop edx 
	pop ecx 
	pop eax 
	ret 
GenerateString ENDP
;#endregion 

;#region HowMany
; how long each string is 
HowMany PROC 
.data
	StringLen byte ?
.code 	
	range:
		mov eax, 35
		call randomRange 
		cmp eax, 10
		jb range 

	mov stringlen, al

	ret 
HowMany ENDP 
;#endregion

;#region GenerateCapital
GenerateCapital PROC

.data 

.code

	mov eax, 25 ; since 65 = A and 90 = Z, you could add 65 from 0 to 25 (A to Z, 26 characters) and get the corresponding letter 
	call randomrange 
	add eax, 65 

	ret 
GenerateCapital ENDP
;#endregion 

;#region clearStr
clearStr PROC 

.data 

	;for testing purposes 
	;clearSuccMsg byte "String array cleared.", newline, 0h 

.code 
		
	clearingLoop:
	mov byte ptr [esi], 0 ; clears current element 
	inc esi ; move to next element 
	loop clearingLoop


	;mov edx, offset clearSuccMsg
	;call writeString 
	ret 
clearStr ENDP
;#endregion


;#region printStr
printStr PROC
.data

.code 
	push edx
	push ecx 

	mov edx, esi
	mov ecx, eax 
	printloop: ;eax times 
		call writestring 
		call crlf 
		add edx, 35
		loop printloop

	pop ecx 
	pop edx 

		ret 
printStr ENDP
;#endregion 


END main
