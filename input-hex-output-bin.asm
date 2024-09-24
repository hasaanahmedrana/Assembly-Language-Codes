.model small
.stack 100h
.386
.data
	str1 db 10,13, "INPUT (BINARY):$"
	str2 db 10,13, "OUTPUT (HEXA)$"
	str3 db 10,13, "INVALID INPUT!!$"
.code
main proc
	mov ax,@data
	mov ds,ax

inp:	mov dx,offset str1
	mov ah,09h
	int 21h

	mov ch,8

	xor bh,bh

again:	mov ah,01h
	int 21h

	cmp al,13
	je exit

	sub al,48
	
	cmp al,0
	je aa

	cmp al,1
	jne error

aa:	shl bh,1
	
	or bh,al

	dec ch
	jnz again

exit:	mov dx,offset str3
	mov ah,09h
	int 21h

	mov cl,2

prnt:	rol bh,4
	mov dl,bh
	
	and dl,0Fh

	mov ah,02h
	int 21h

	dec cl
	jz finish
	
	jmp prnt

error:	mov dx,offset str3
	mov ah,09h
	int 21h

	jmp inp

finish:	mov ah,4ch
	int 21h

main endp
end main






	