.model small
.stack 100h
.386
.data
	arr1 db 'Enter A Number: $'
	arr2 db 'Number is prime! $'
	arr3 db 'Number is not prime! $'
.code
main proc	
	mov ax,@data
	mov ds,ax
	
	lea dx, arr1
	mov ah,09h
	int 21h
	
	call dec_inp
	
	
	mov ax,bx
	mov cx, bx
	
	call is_prime
	
	terminate:
		mov ah,4ch
		int 21h
		


main endp

dec_inp proc
	mov bx,0
	again:
		mov ah,01h
		int 21h
		
		cmp al ,13
		je exit
		
		sub al,48
		mov cl, al
		mov ch,0
		mov ax,bx
		mov bx,10
		mul bx
		add ax, cx
		mov bx,ax
		jmp again
	exit:
		ret
dec_inp endp
	

is_prime proc
		dec cx
	again5:
		
		mov ax,bx
		mov dx,0
		div cx
		cmp dx,0
		je not_prime
		dec cx
		cmp cx,2
		jae again5
		
	prime:
		lea dx, arr2
		mov ah,09h
		int 21h
		jmp exit1
	not_prime:
		lea dx, arr3
		mov ah,09h
		int 21h
		
	exit1:

		ret
is_prime endp

end main