.model small
.STACK 100h
.data
    stringg db 50  ('$')

.code
main proc
	mov ax, @data
	mov ds, ax
	mov si, offset stringg
	mov cx, 0

aa:	
	mov ah,01	
	int 21h
	
	; condition to check if input is enter
	cmp al,13	
	je entered
	mov [si],al		
	inc cx		
	inc si		
	jmp aa

entered:

	dec si
	cmp cx, 0
	JE exitt

bb:	
	mov al,[si]
	mov dl,al
	mov ah,02
	int 21h
	dec si
	dec cx
	jnz bb 	
	
exitt:
	mov ah,4ch
	int 21h

main endp
end main