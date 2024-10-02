.model small
.stack 100h
.386
.data
	arr1 db 10,13,'Enter the character: $'
	arr2 db 10,13,'The output in binary is: $'
.code
	main proc
		mov ax,@data		
		mov ds,ax
		
		mov cx, 0
		xor bx, bx
		
		lea dx, arr1
		mov ah, 09h
		int 21h
		
		
	next:cmp cx,1
		je stop

		
		mov ah,01h
		int 21h
		
		cmp al,13
		je stop
		
		cmp al,41h
	

		
	process:
		
		Rol bx, 4
		and al,0fh
		or bl, al
		inc cx
		jmp next

	stop:
		mov cx ,16
		lea dx, arr2
		mov ah, 09h
		int 21h	
			mov cx,16

	again:	SHL bx,1
			JC aa 
			mov dl,'0'
			mov ah,02h
			int 21h
			JMP bb

	aa:		mov dl,'1'
			mov ah,02h
			int 21h
		
	bb:		DEC cx
			JNZ again



exit:
	mov ah,4ch
	int 21h

		
main endp
end main

