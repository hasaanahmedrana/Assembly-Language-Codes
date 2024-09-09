.model small
.stack 100h
.386
.data
	arr1 db 10,13,'Enter a string: $'
	arr2 db 10,13,'After trim: $'	
	inp_str db 50 dup ('$')
	out_str db 50 dup ('$')
	len dw '0'
.code
main proc
		mov ax,@data
		mov ds,ax
		mov es,ax
		
		call read_str
		call delete_blanks
		
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
	lea di, inp_str
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

delete_blanks proc

		lea dx,arr2
		mov ah,9
		int 21h
		
		mov al,' '
		lea di,inp_str
		lea si,out_str
		
		repe scasb
		dec di
		inc cx
	again2:
		mov bl,[di]
		mov [si],bl
		inc si
		inc di
		dec cx
		cmp cx,0
		jnz again2
	
		lea dx,out_str
		mov ah,9 
		int 21h
		ret
delete_blanks endp

end main
