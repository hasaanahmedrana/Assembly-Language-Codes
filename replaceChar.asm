.model small
.stack 100h
.386
.data
	input_str db 50 dup('$')
	arr1 db 10,13,'Input a string: $'
	arr2 db 10,13,'Character to be replaced: $'
	arr3 db 10,13,'New character: $'
	arr4 db 10,13, 'Modified String: $'
	prev db 0
	new db 0
	len dw '0'
.code
main proc
	mov ax,@data
	mov ds,ax
	mov es, ax
	
	call read_str
	call input_chars
	call replace_chars
	call display_str
	
	terminate:
		mov ah,4ch
		int 21h
		

		
main endp

read_str proc
    push ax
    push di
	
	lea dx, arr1
	mov ah,09h
	int 21h
	
    cld
	lea di, input_str
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
		mov len ,bx
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
	
	lea dx, arr4
	mov ah,09h
	int 21h
	
	
	lea si, input_str
	mov cx, bx
	mov ah,02h
	
	cmp cx, 0
	je exit
	
	again:
		lodsb
		mov dl, al
		int 21h
		loop again
		
	exit:
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
display_str endp

input_chars proc
	push ax
	push bx
	push cx
	push dx
	
		lea dx, arr2
		mov ah,09h
		int 21h
		
		mov ah,01h
		int 21h
		mov prev, al
		
		lea dx, arr3
		mov ah,09h
		int 21h
		mov ah,01h
		int 21h
		mov new, al

		pop dx
		pop cx
		pop bx
		pop ax
		ret
input_chars endp

replace_chars proc
	push ax
	push bx
	push cx
	push dx
	

	mov cx, len
	mov al, prev
	mov bl, new
	
	lea di, input_str
	cld
	again:
		scasb           
		jne no_match     

		match:
			mov [di-1], bl   
		no_match:
			loop again       

	
	pop dx
	pop cx
	pop bx
	pop ax
	ret
replace_chars endp

end main
