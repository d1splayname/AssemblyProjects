;Author name: Joshua Chen
;Last modified date: 11/08/2024
;Brief description: A program to encrypt and decrypt text using Vigenere cipher
;Credits:
;	None

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
	; Input variables (change these)

	input BYTE "JOSHUACHEN"
	key BYTE "BAD" ; bound in 1 to len(input) - 1
	options BYTE 1 ;1 encryption, else decryption

	;=============================
	;do not modify below this line
	;=============================

	output BYTE LENGTHOF input DUP(0)

	;extra variables
	inputLen BYTE LENGTHOF input
	keyLen BYTE LENGTHOF key
.code

main proc

	MOVZX ecx, inputLen
	LEA esi, input
	LEA edi, output

	ADD esi, ecx
	DEC esi
	ADD edi, ecx
	DEC edi

copyLoop:
	DEC ecx
	MOV al, [esi]
	MOV [edi], al
	
	DEC esi
	DEC edi
	
	CMP ecx, 0
	JG copyLoop

;apply ciphers
	MOVZX ecx, inputLen
	
	LEA esi, output
	ADD esi, ecx
	DEC esi

	MOV eax, 0

applyCipherLoop:
	DEC ecx

	MOV eax, ecx
	DIV keyLen ;remainder in ah
	MOVZX eax, ah

	LEA edi, key
	ADD edi, eax
	MOV ebx, 0
	MOV bl, [edi]

	ADD bl, [esi]
	MOV al, [esi] ;debug
	SUB bl, 92

	CMP bl, 65
	JGE inRange
	ADD bl, 27
inRange:
	
	CMP options, 1
	JE skipDecrypt
	;ADD bl, 1
	;CMP bl, 
	;JGE
skipDecrypt:
	MOV [esi], bl
	
	DEC esi
	CMP ecx, 0
	JG applyCipherLoop
	
	invoke ExitProcess, 0
main endp

end main