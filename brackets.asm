.model small
.stack 100h
.386
.data
	next_line db 10, 13, '$'
	arr1 db 10, 13, 'Enter an Algebraic Expression: $'
	arr2 db 10, 13, 'Too many right brackets begin again! $'
	arr3 db 10, 13, '"Expression is correct."$'
	arr4 db 10, 13, 'Type Y if you want to continue: $'
	arr5 db 50 dup ('$')                                     ; contains input string
	arr6 db 10, 13, 'Too many left brackets begin again! $'
	
.code


main proc
	mov ax, @data
	mov ds, ax
	
	start:
	lea dx, arr1
	mov ah,09h
	int 21h
	
	call take_input
	
	mov bl, cl  ;Bl contains the count of characrters in the input
	call validate

	printing:
		cmp bh,'B'
		je balance_print
		cmp bh,'L'
		je left_print
		cmp bh, 'R'
		je right_print
		
		balance_print:
			lea dx, arr3
			mov ah,09h
			int 21h
			
			lea dx, arr4
			mov ah,09h
			int 21h
			
			mov ah,01h
			int 21h
			
			cmp al,'Y'
			je next_try
			jmp terminate
			
			
			
		left_print:
			lea dx, arr6
			mov ah,09h
			int 21h
			jmp next_try
		right_print:
			lea dx, arr2
			mov ah,09h
			int 21h
			jmp next_try

		
		next_try:
			xor bx,bx
			xor cx,cx
			xor ax,ax
			jmp start
	
	terminate:
		mov ah,4ch
		int 21h
		
		
main endp

take_input proc	
	mov cl, 0
	lea si, arr5
	mov ah,0
	
	again:
		mov ah,01h
		int 21h
		
		cmp al,13
		je return
		
		mov [si],al
		inc si
		inc cl
		
		jmp again
	
	return:
	ret

take_input endp


validate proc
	lea si, arr5 
	mov cl, bl
	
	again:
		mov dl,[si]
		
		cmp dl ,'}'
		je check
		cmp dl ,']'
		je check
		cmp dl ,')'
		je check
		
		cmp dl ,'('
		je pushing
		cmp dl ,'{'
		je pushing
		cmp dl ,'['
		je pushing
		
		jmp next
		
		check:
			; check if stack is empty so return many right brackets
			cmp ch,0  
			je right
			
			pop ax  ; ax contain the top of the stack
			dec ch
			cmp dl ,'}'
			je curly
			cmp dl ,']'
			je square
			cmp dl ,')'
			je round
			
		next:
			inc si
			dec cl
			jz balance
			jmp again
			
		pushing:
			mov al, [si]
			mov ah,0
			push ax
			inc ch
			jmp next
		
		round:

			cmp al, '('
			jne left
			jmp next
		curly:
			cmp al,'{'
			jne left
			jmp next
		square:
			cmp al,'['
			jne left
			jmp next
		
		
		balance:
			cmp ch,0
			je is_balance
			mov bh,'L'
			pop_extra:
				pop ax
				dec ch
				jnz pop_extra
				jmp return
			is_balance:
				mov bh,'B'
				jmp return
			
			
		
		right:
			mov bh,'R'
			je return
		left:
			mov bh,'L'
			je return
			
	return:
		ret
		

validate endp

end main

; AX, USE FOR PUSH PULL
; BL CONTAINS INPUT LENGTH
; CL CONTAINS THE COUNT OF CHARACTERS VALIDATED (ITERATED)
; CH CONTAINS NUMBER OF BRACKETS IN THE stack
