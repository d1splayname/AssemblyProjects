;Description: Bubble sorts a list of bytes
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
	array BYTE 10, 9, 8, 6, 7, 5, 4, 3, 1, 2

.code
main proc

	mov ecx, SIZEOF array
	dec ecx

OuterLoop:
	MOV ebx, ecx
	
	InnerLoop:
	CMP

	MOV array[bx], eax
	xchg ebx, ecx

	MOV eax, array[bx]

	xchg ebx, ecx
	DEC ebx
	JNZ InnerLoop

DEC ecx
JNZ OuterLoop

	invoke ExitProcess, 0
main endp
end main
