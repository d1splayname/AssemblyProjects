;Submitter: Joshua Chen
;Date: 10/04/2024
;Description: Incrememnt all values in an array by 2

;Credits:
;Received help from Leopold with .data
;Functions syntax from lecture slides
;Kyler pointed out I can just do calculations inside of ah,
	;instead of calculating in al and shifting it up to ah

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data ;Leopold helped on this
	;Create input BYTE array
	input db 1, 2, 3, 4, 5, 6, 7, 8

	;Create shift BYTE variable
	shift db 2

.code

main proc
	;Set all registers to 0
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	
	;Calculate sum for high AX register
	mov ah, input[0]
	add ah, shift

	;Calculate sum for low AX register
	mov al, input[1]
	add al, shift

	;Calculate sum for high BX register
	mov bh, input[2]
	add bh, shift

	;Calculate sum for low BX register
	mov bl, input[3]
	add bl, shift

	;Calculate sum for high CX register
	mov ch, input[4]
	add ch, shift

	;Calculate sum for low CX register
	mov cl, input[5]
	add cl, shift

	;Calculate sum for high DX register
	mov dh, input[6]
	add dh, shift

	;Calculate sum for low DX register
	mov dl, input[7]
	add dl, shift

	invoke ExitProcess, 0
main endp

end main