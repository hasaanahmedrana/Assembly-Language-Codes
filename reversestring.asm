.model small
.stack 100h
.386
.data
	space db ' $'
	arr1 db 10, 13, 'Enter a String: $'
	arr2 db 10, 13, 'You Entered: $'
	arr3 db 50 dup ('$')

.code
	main proc
	mov ax, @data
	mov ds, ax
	
	lea dx, arr1
	mov ah,09h
	int 21h
	
	call take_input
	 

	lea dx, arr2
	mov ah,09h
	int 21h
	

	call reverse_words
	
	
	;terminating the program
	mov ah,4ch
	int 21h


main endp

take_input proc
	mov ch, '0'
	mov cl, 0
	lea si, arr3
	
	again:
	mov ah,01h
	int 21h
	
	cmp al, 13
	je exitt
	
	
	mov [si], al
	inc cl
	inc ch
	inc si
	jmp again
	
	exitt:
	
	ret
take_input endp


reverse_words proc
	push cx
	mov cl, 0
	lea si, arr3
	again2:
		cmp ch,'0'
		je return
		dec ch
		
		mov bl, ' '
		cmp [si],bl
		je printing
		
		mov bl, [si]
		push bx
		inc cl
		inc si
		jmp again2

	
	printing:
		pop dx
		mov ah,02h
		int 21h
		
	
		dec cl
		jnz printing
		inc si
		lea dx, space
		mov ah,09h
		int 21h
		
		mov ah,09h
		jmp again2
		
	return:
		againn3:
		cmp cl,0
		je exiting 
		pop dx
		mov ah,02h
		int 21h
		
		dec cl
		jnz againn3
	exiting:
		pop cx
		ret
reverse_words endp

end main
