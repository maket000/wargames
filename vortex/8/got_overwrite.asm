BITS 32
	global _start
	section .text
	
	mov ecx, 0x0804a00c
	mov [ecx], dword 0xffffdbf6

	
