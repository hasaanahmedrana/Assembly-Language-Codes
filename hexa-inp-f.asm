.model small
.stack 100h
.386
.data
	arr1 db 10,13,'Enter Hex input: $'
	arr2 db 10,13, 'Hex Output is: $'
	arr3 db 10,13,'$'
.code

main proc
	mov ax, @data
	mov ds, ax
	
	lea dx, arr1
	mov ah,09h
	int 21h
	call hex_inp
	
	lea dx, arr2
	mov ah,09h
	int 21h
	call hex_out
	
	;terminating the program
	mov ah,4ch
	int 21h
	
main endp

hex_out proc	
	PUSH cx
	mov cx,4
	
	again:
		rol bx,4
		mov dl,bl
		and dl,0fh
		add dl, '0'
		cmp dl, '9'
		jg letter
		jmp print
	letter:
		add dl, 7h
		
	print:
		mov ah,02h
		int 21h
		
		lea dx, arr3
		mov ah, 09h
		int 21h
		
		dec cx
		jnz again
	ret
	POP CX
hex_out endp
	
hex_inp proc
	push cx
	xor bx,bx
	mov cx,4
	
	again:
		mov ah,1h
		int 21h
		
		shl bx,4
		and al, 0fh

		cmp al, '9'
		jbe digit
		sub al, 7
	digit:
		sub al,48
	store:
		rol bx,4
		or bl,al
		dec cx
		jnz again
	ret
	pop cx
hex_inp endp
	
	
end main
