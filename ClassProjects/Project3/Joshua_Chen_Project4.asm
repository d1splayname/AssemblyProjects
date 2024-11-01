;Author name: Joshua Chen
;Last modified date: 10/24/2024
;Brief description: Shift a user-defined array by a user-defined amount
;Credits:
;	Used https://www.tutorialspoint.com/ for:
;		if statements and compare syntax
;		constant syntax
;	Use https://www.cs.virginia.edu/~evans/cs216/guides/x86.html for:
;		creating empty array of certain size

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
	; Input variables

	; input array
	input BYTE 1, 2
	; shift number
	shift BYTE 0

	;========================================
	;do not modify below this line
	;========================================

	; create output array with size of input and initialized to all 0's
	arraySize EQU SIZEOF input
	output BYTE arraySize DUP(?); used documentation on https://www.cs.virginia.edu/~evans/cs216/guides/x86.html
.code

main proc
	; zero out all registers
	mov eax, 0
	mov ebx, 0
	mov ecx, 0

	;==============================
	; edge case of shift = 0
	;==============================
	cmp shift, 0 ; used documentation on https://www.tutorialspoint.com/
	jne elsestatement

	mov bx, arraySize

; fillpart1loop  using:
;	bx - access index in array
copyloop:
	; move value at index over (using ah)
	dec bx
	mov ah, input[bx]
	mov output[bx], ah
	
	; loop functionality
	jnz copyloop

jmp startcheckloop

	;==============================
	; fill first part of array
	;==============================

elsestatement:
	; clear registers
	mov eax, 0
	mov ebx, 0

	mov cl, bl
	sub cl, shift

; fillpart1loop  using:
;	ah - swap storage
;	al - input index
;	bx - access index in array
;	cl - counter and output index
fillpart1loop:
	; calculate copy indices
	mov al, cl
	add al, shift
	dec al

	; move value at index over (using ah)
	mov bl, al
	mov ah, input[bx]
	mov bl, cl
	dec bl
	mov output[bx], ah
	
	; loop functionality
	dec cl
	jnz fillpart1loop ; jnz made with referencing documentation https://www.tutorialspoint.com/

	;==============================
	; fill remaining part of array
	;==============================

	; clear registers
	mov eax, arraySize
	dec al
	
	mov ebx, 0

	movzx ecx, shift

; fillpart2loop  using:
;	ah - swap storage
;	al - output index
;	bx - base register to access index in array
;	cl - counter and input index
fillpart2loop:
	; swap values at the two indices (using ah)
	mov bl, cl
	dec bl
	mov ah, input[bx]
	mov bl, al
	mov output[bx], ah
	
	; move output index
	dec al

	; loop functionality
	dec cl
	jnz fillpart2loop

	;==============================
	; display output array values
	;==============================

startcheckloop:
	mov eax, 0
	mov ebx, 0
	mov ecx, arraySize

; checkloop allows user to check values in array
; displays values in each array from left to right
; uses:
;	cl for counter
;	bx for accessing index in array
checkloop:
	; move num to temp storage
	mov ah, input[bx]
	mov al, output[bx]

	; loop functionality
	inc bl

	dec cl
	jnz checkloop

	invoke ExitProcess, 0
main endp

end main