; remove all duplicate adjacent elements
.model small
.stack 100h
.386
.data
	space db ' $'
	arr1 db 10, 13, 'Input String: $'
	arr2 db 10, 13, 'Output: $'
	arr3 db 50 dup ('$')
	arr4 db 50 dup ('$')
	arr5 db 50 dup ('$')

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
	

	call remove_duplicate
	
	call reverse_output
	lea dx, arr5
	mov ah,09h
	int 21h
	
	
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


remove_duplicate proc
	push cx
	mov cl, 0
	lea si, arr3
	
	repeating:
		cmp ch,'0'
		je return
		cmp cl,0
		je pushing
		
		pop dx
		dec cl
		cmp [si],dl
		jne pushing2
		
		dec ch
		inc si
		jmp repeating
		
		
		
	pushing2:
		push dx
		mov bl, [si]
		mov bh,0
		push bx
		inc si
		add cl,2
		dec ch
		jmp repeating
		
	pushing:
		mov bl, [si]
		mov bh,0
		push bx
		inc si
		dec ch
		inc cl
		jmp repeating

		
	return:
		lea si, arr4
		re:
			cmp cl,0
			je exiting
			pop bx
			mov [si],bl
			inc si
			dec cl
			jmp re
	exiting:
		pop cx
		ret
remove_duplicate endp

reverse_output proc
	lea si, arr4
	lea di,arr5
	mov cx,0
	pushing:
		mov bl, '$'
		cmp [si], bl
		je pop_out
		mov bl, [si]
		mov bh,0
		push bx
		inc si
		inc cx
		jmp pushing
		
	pop_out:
		pop bx
		mov [di],bl
		inc di
		dec cx
		jnz pop_out
		
	ret
reverse_output endp

end main