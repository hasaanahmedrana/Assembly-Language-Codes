.model small
.stack 100h
.data
	arr1 db 'Enter first string: $'
	arr2 db 'Enter second string: $'
	present db 'Yes$'
	absent db 'No$'
	s1 db 50 dup ('$')
	s2 db 50 dup ('$')	
	len1 dw 0
	len2 dw 0
.code
	main proc
		mov ax,@data
		mov ds,ax
		mov es,ax
		cld
	
	lea di,s1
	call read_str
	mov len1, bx
	
	lea di,s2
	call read_str
	mov len2,bx
	
	call find_substr

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
		mov len1,bx
		mov byte ptr [di], '$'
		pop di
		pop ax
		ret
read_str endp

find_substr proc
		lea di,s1
		lea si,s2
		mov al,[si]
		inc len1
		check_again:
			mov cx,len1
			add cx, len2
			repne	scasb
			cmp cx,0
			je not_exits
	
	match_sub:
		mov cx,len2
		inc cx
		push di
		dec di
		repe cmpsb
		pop di
		cmp cx,0
		je exits
		lea si, s2
		jmp check_again
	exits:
		lea dx, present
		mov ah,9
		int 21h
		jmp return
		
	not_exits:
		mov ah,9
		lea dx,absent
		int 21h
	return:
		ret
find_substr endp

end main
		
