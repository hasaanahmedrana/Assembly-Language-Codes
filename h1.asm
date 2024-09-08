.model small
.stack 100h
.386
.data
	next_line db 10, 13, '$'
	arr1 db 10, 13, 'Input String: $'
	arr2 db 10, 13, 'Output: $'
	true db 'String is palindrome!$'
	false db 'String is not palindrome!$'
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
	
	call check_palindrome
	cmp al, 'N'
	je NO
	lea dx, true
	mov ah,09h
	int 21h
	jmp ending
	
	NO:
	lea dx,false
	mov ah,09h
	int 21h
	
	;terminating the program
	ending:
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

check_palindrome proc
	lea si, arr3
	mov cl, ch
	
	again:
		cmp ch, '0'
		je comparing
		
		mov bl,[si]
		mov bh,0
		push bx
		inc si
		dec ch
		jnz again
	
	comparing:
		lea si, arr3
		again2:
			cmp cl,'0'
			je itstrue
			pop bx
			cmp bl,[si]
			jne nottruee
			inc si
			dec cl
			jmp again2
		
	nottruee:
		dec cl
		mov al,'N'
		jmp pop_out

	itstrue:
		mov al, 'Y'
		jmp exiting

	pop_out:
		cmp cl,'0'
		je exiting
		pop bx
		dec cl
		jmp pop_out

	exiting:
		ret
		
		
check_palindrome endp

end main



