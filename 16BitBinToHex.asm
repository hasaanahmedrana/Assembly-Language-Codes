.model small
.stack 100h
.386
.data
	arr1 db 10,13,'Enter a binary number upto 16 digits: $'
	arr2 db 10,13,'In hexa it is: $'
	arr3 db 10,13,'Illegal binary digit. try again:'
	
.code
main proc
	mov ax,@data		
	mov ds,ax
	
	xor bx,bx
	xor dx,dx

	lea dx, arr1
	mov ah,09h
	int 21h

again: 
	
	
	
	mov ah,01h
	int 21h
	 
	cmp al, 13
	je stop
	sub al, '0'
	cmp al, 0
	je rotate
	cmp al, 1
	jne errorr

	jmp rotate

errorr:
	lea dx, arr3
	mov ah,09h
	int 21h
	jmp again
	

	
rotate:
	shl bx,1
	or bl, al
	dec cx
	jnz again
	
	
stop:
	mov cx, 4
	lea dx, arr2
	mov ah,09h
	int 21h
	
cc: rol bx,4
	mov dl, bl
	and dl, 0fh
	cmp dl,09h
	JA letter
	add dl, 30h
	jmp aa
letter:
	add dl, 37h
aa: 
	mov ah,02h
	int 21h
	dec cx
	cmp cx,0
	ja cc
mov ah,4ch
int 21h

		
main endp
end main

