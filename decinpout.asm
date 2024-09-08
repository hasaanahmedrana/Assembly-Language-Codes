.model small
.stack 100
.386
.data
	arr1 db 'Enter decimal input: $'
	arr2 db 'Enter decimal output: $'
	total dw 0
.code
	main proc
	mov ax,@data
	mov ds, ax
	
	lea dx,arr1
	mov ah,09h
	int 21h
	
	call dec_input
	
	lea dx,arr1
	mov ah,09h
	int 21h	
	
	call dec_out
	
	terminate:
		mov ah, 4ch
		int 21h
	
	main endp
	

dec_input proc
	; initialize total dw 0
	push ax
	push bx
	push cx
	push dx
	
	mov total,0
	
	again:
		mov ah, 01h
		int 21h
		cmp al, 13
		je return 
		sub al,'0'
		mov ah, 0
		mov cx, ax
		mov ax,total
		mov bx, 10
		mul bx
		add ax,cx
		mov total, ax
		jmp again
	
	return:
		pop dx
		pop cx
		pop bx
		pop ax
		ret
dec_input endp

dec_out proc
	push ax
	push bx
	push cx
	push dx
	
	mov ax, total
	mov bx, 10
	mov cx, 0
	again2:
		cmp ax,0
		je popping
		mov dx, 0
		div bx
		push dx
		inc cx
		jmp again2
		

	popping:
		cmp cx,0
		je zero
		pop dx
		cmp dx,9
		jle digit
		add dx,7h
		digit:
			add dx,30h
			mov ah,02h
			int 21h
		loop popping
		jmp exit
		zero:
			mov ah,02h
			mov dl, '0'
			int 21h
	exit:
		pop dx
		pop cx
		pop bx
		pop ax
		ret
dec_out endp


end main
