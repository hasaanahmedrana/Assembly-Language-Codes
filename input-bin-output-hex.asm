.model small
.stack 100h
.386
.data

	arr1 db 10,13,'Enter binary input:$'
	arr2 db 10,13,'Hexa number is: $'
	arr3 db 10,13,'Illegal input !, try again: $'
	
.code
main proc
	mov ax,@data
	mov ds, ax
	
	lea dx,arr1
	mov ah,09h
	int 21h
	
	mov cx,16
	input:
		mov ah,01h
		int 21h
		
		cmp al,13
		je printing
		jmp validate
		
		return:
			dec cx
			jnz input
			jmp printing
			
	validate:
		cmp al,'1'
		je process
		cmp al,'0'
		je process
		jmp errorr
		
	errorr:
		lea dx,arr3
		mov ah,09h
		int 21h
		
		mov cx,16
		xor bx,bx
		jmp input
	
	process:
		sub al, 48
		shl bx,1
		or bl,al
		jmp return
		
	printing:
		lea dx, arr2
		mov ah,09h
		int 21h
		
		mov cx, 4
		
		again:
			rol bx,4
			mov dl, bl
			and dl, 0Fh
			add dl,48
			cmp dl,'9'
			ja addition_sev
		backk:
			mov ah,02h
			int 21h
			dec cx
			jnz again
			jmp exitt
		addition_sev:
		add dl,7
		jmp backk

		
exitt:
	mov ah, 4ch
	int 21h
	
main endp
end main
ss