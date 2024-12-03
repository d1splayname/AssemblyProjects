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

	input BYTE "JPUESZSBAPANNHTXRTLBVLL"
	key BYTE "ABCXYZ" ;bound in 1 to len(input) - 1
	options BYTE 0 ;1 encryption, else decryption

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

	;check if decrypting
	MOVZX eax, options
	CMP eax, 1
	JNE decrypt

applyCipherLoop:
	DEC ecx

	MOV eax, ecx
	DIV keyLen ;remainder in ah
	MOVZX eax, ah

	LEA edi, key
	MOV ebx, 0
	MOV bl, [edi + eax]
	SUB bl, 'A'

	;MOV ebx, 0

	ADD bl, [esi]
	MOV dl, [esi] ;debug

	CMP bl, 90
	JLE isInRange
	SUB bl, 26

	CMP bl, 65
	JGE isInRange
	ADD bl, 27


isInRange:

	MOV [esi], bl
	
	DEC esi
	CMP ecx, 0
	JG applyCipherLoop

	JMP done

decrypt:

	MOVZX ecx, inputLen
	
	LEA esi, output
	ADD esi, ecx
	DEC esi

applyDecypherLoop:
	DEC ecx

	MOV al, [esi]
	MOVZX ebx, al

	ADD bl, 'A'

	MOV eax, ecx
	DIV keyLen ;remainder in ah
	MOVZX eax, ah

	LEA edi, key
	SUB bl, [edi + eax]

	CMP bl, 65
	JGE isInRange1
	ADD bl, 26

	CMP bl, 90
	JLE isInRange1
	SUB bl, 26

isInRange1:
	
	MOV [esi], bl
	
	DEC esi
	CMP ecx, 0
	JG applyDecypherLoop

done:
	invoke ExitProcess, 0
main endp

end main