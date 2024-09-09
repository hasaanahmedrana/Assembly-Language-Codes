.model small
.stack 100h
.386
.data
	arr1 db 10,13,'Enter String 1: $'
	arr2 db 10,13,'Enter String 2: $'
	arr3 db 10, 13, 'Enter Integer: $'
	arr4 db 50 dup('$')
	arr5 db 50 dup('$')
	digit dw '0'
	len1 dw  '0'
	len2 dw  '0'
	result db 100 dup('$')
	
	
.code
main proc
	mov ax,@data
	mov ds,ax
	mov es, ax
	
	lea dx, arr1 
	mov ah,09h
	int 21h
	lea di, arr5
	call read_str
	mov len2, bx
	
	
	lea dx, arr2
	mov ah,09h
	int 21h
	lea di, arr4
	call read_str
	mov len1, bx
	
	lea dx, arr3
	mov ah,09h
	int 21h
	lea di, digit
	mov cx, 0 

	iterate:
		mov ah, 01h
		int 21h
		cmp al, 13
		je stop
		sub al, '0' 
		movzx ax, al
		imul cx, 10
		add cx, ax
		jmp iterate

	stop:
		mov digit, cx 

		call processing
		
		call display_str
		
	
	terminate:
		mov ah,4ch
		int 21h
		
main endp


read_str proc
    push ax
    push di
    cld
    xor bx, bx
	
	read_char:
		mov ah, 01h
		int 21h
		cmp al, 13
		je end_input
		
		cmp al, 08h  ; backspace
		jne store_char

		cmp bx, 0
		je read_char
		
		dec di
		dec bx
		jmp read_char
		
	store_char:
		stosb
		inc bx
		jmp read_char
	end_input:
		mov byte ptr [di], '$'
		pop di
		pop ax
		ret
read_str endp

display_str proc
	push ax
	push bx
	push cx
	push dx
	push si
	
	mov ah,09h
	lea dx, arr4
	int 21h
		
	exit:
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
display_str endp

processing proc
	push ax
	push bx
	push cx
	push dx
	push si
	push di
		
	mov cx, len1
	sub cx, digit

	
	lea si, arr4
	add si, len1
	dec si
	
	
	mov di,si
	add di, len2
	STD
	rep movsb               

	cld
	mov cx, len2
	lea di,arr4
	add di,digit
	lea si, arr5
	rep movsb

	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret
processing endp


end main