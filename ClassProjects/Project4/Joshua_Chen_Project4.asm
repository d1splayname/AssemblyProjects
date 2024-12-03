;Author name: Joshua Chen
;Last modified date: 10/26/2024
;Brief description: Compare if two user-defined strings are anagrams of one another
;Credits:
;	None

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
	; Input variables (change these)
	s1 BYTE "AAA"
	s2 BYTE "BBB"

	;=============================
	;do not modify below this line
	;=============================

	;extra variables
	strLen EQU SIZEOF s1
.code

main proc
	;======================
	;Compare all characters
	;====================== 

	;Try to find all s1 chars in s2

	MOV ecx, strLen

OutLoop:
	CMP ecx, 0
	JE Done
	DEC ecx
	MOV ebx, ecx

	MOVZX eax, s1[bx]

	MOV ebx, strLen

	InLoop:
		CMP ebx, 0
		JNE DontQuit

		; no match found for char
		MOV eax, 0
		invoke ExitProcess, 0

		DontQuit:
		DEC ebx

		MOV ah, s2[bx]

		CMP al, ah
		JNE InLoop

		; same char found in s2
		MOV s2[bx], 0 ; delete char so it is not checked again

		CMP ebx, 0
		JMP OutLoop
	JNZ InLoop
JNZ OutLoop

Done:
	; all characters matched up
	MOV eax, 1
	invoke ExitProcess, 0
main endp

end main