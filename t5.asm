.model small
.stack 100h
.data
	array1 db "enter a number: $"

.code
	main proc
		mov ax,@data
		mov ds,ax

		mov bh,0
		
		mov dx,offset array1
		mov ah,09h
		int 21h
	
		mov ah,01h
		int 21h

		mov bl,al
		sub bl,48d

		mov dl,10
		mov ah,2
		int 21h
		mov dl,13
		mov ah,2
		int 21h


bb:  		CMP bh,bl
		JA exit
		
		mov cl,bh
		ADD cl,48d

		mov dl,cl
		mov ah,02h
		int 21h

		mov dl,10
		mov ah,2
		int 21h
		mov dl,13
		mov ah,2
		int 21h

		inc bh
		jmp bb

exit:

		mov ah,4ch
		int 21h
	
main endp	
end main