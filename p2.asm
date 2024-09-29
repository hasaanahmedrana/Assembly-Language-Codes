.model small
.stack 100h
.data
	
	stringg1 db 'Enter first number (0-9):$'
	stringg2 db 'Enter second number (0-9):$'
	warn db 'Error! Sum is greater than 9.$'
	answer db 'Sum is: $'
.code
main proc
	mov ax, @data
	mov ds, ax
	
	; taking first number input
	mov dx, offset stringg1
	mov ah, 09h
	int 21h
	
	
	mov ah, 01h
	int 21h
	mov bl,al
	
	; skipping line
	mov dl, 10  
	mov ah, 02h
	int 21h
	mov dl, 13
	mov ah, 02h
	int 21h

	; taking second number input
	mov dx, offset stringg2
	mov ah, 09h
	int 21h
	
	mov ah, 01h
	int 21h

	mov cl,al
	
	; asci handling
	add bl, cl
	sub bl, 60h

	; new line
	mov dl, 10  
	mov ah, 02h
	int 21h
	mov dl, 13
	mov ah, 02h
	int 21h 
	
	; comparing
	cmp bl,9h
	jg failure 
	
	
	; successfull case 
	mov dx, offset answer
	mov ah, 09h
	int 21h

	mov dl, bl
	add dl, 30h
	mov ah, 02h
	int 21h
	jmp exitt

	
	
failure: 
	mov dx, offset warn
	mov ah, 09h
	int 21h
	jmp exitt
exitt:
mov ah, 4ch
int 21h
main endp
end main
	