.model small
.stack 100h
.386
.data
	arr1 db 10,13,'Enter numerator of first fraction: $'
	arr2 db 10,13,'Enter denomenator of first fraction: $'
	arr3 db 10,13,'Enter numerator of second fraction: $'
	arr4 db 10,13,'Enter denomenator of second fraction: $'
	arr5 db 10,13,'The result is: $'
	total dw '0'
	num1 dw '0'
	num2 dw '0'
	den1 dw '0'
	den2 dw '0'
	lcm dw '0'
	var1 dw '0'
	
	
.code

main proc	
	mov ax,@data
	mov ds,ax
	
	call taking_inputs
	call find_lcm
	call result_num
	call display_result
	
	
	
	terminate:
		mov ah,4ch
		int 21h
main endp


taking_inputs proc
	lea dx, arr1
	mov ah,09h
	int 21h
	mov total,0
	call dec_input
	mov num1,0
	mov bx,total
	mov num1, bx
	
	lea dx, arr2
	mov ah,09h
	int 21h
	call dec_input
	mov bx,total
	mov den1,bx

	lea dx, arr3
	mov ah,09h
	int 21h
	call dec_input
	mov num2,0
	mov bx,total
	mov num2, bx

	lea dx, arr4
	mov ah,09h
	int 21h
	call dec_input
	mov den2,0
	mov bx,total
	mov den2, bx
	ret
taking_inputs endp



printing_inputs proc
	mov ax,num1
	call dec_out
	mov ax,num2
	call dec_out
	mov ax,den1
	call dec_out
	mov ax,den2
	call dec_out
	
	ret
printing_inputs endp


dec_input proc
	; initialize total dw 0
	push ax
	push bx
	push cx
	push dx
	
	mov total,0
	
	again:
		mov ah, 01h
		int 21h
		cmp al, 13
		je return 
		sub al,'0'
		mov ah, 0
		mov cx, ax
		mov ax,total
		mov bx, 10
		mul bx
		add ax,cx
		mov total, ax
		jmp again
	
	return:
		pop dx
		pop cx
		pop bx
		pop ax
		ret
dec_input endp

dec_out proc
	push ax
	push bx
	push cx
	push dx
	
	mov bx, 10
	mov cx, 0
	again:
		cmp ax,0
		je popping
		mov dx, 0
		div bx
		push dx
		inc cx
		jmp again
		
	cmp cx,0
	je exit
	
	popping:
		pop dx
		cmp dx,9
		jle digit
		add dx,7h
		digit:
		add dx,30h
		mov ah,02h
		int 21h
		loop popping
	exit:
		pop dx
		pop cx
		pop bx
		pop ax
		ret
		ret
dec_out endp

find_lcm proc
	push ax
	push bx
	push cx
	push dx
	
	mov ax, den1
	mov bx, den2
	

	cmp ax, bx
	jb exchange
	jmp again2
	
	exchange:
		mov bx, den1
		mov ax, den2

	again2:
		mov dx, 0
		div bx
		cmp dx,0
		je found
		mov ax, bx
		mov bx, dx
		jmp again2
	found:
		mov cx, bx
		mov ax, den1
		mov bx,den2
		mul bx
		mov dx,0
		div cx
		mov lcm, ax

	pop dx
	pop cx
	pop bx
	pop ax
	ret
find_lcm endp

result_num proc
	push ax
	push bx
	push cx
	push dx
	
	mov var1, 0
		
	first:
		mov ax, lcm
		mov bx, num1
		mov cx, den1
		cmp bx,ax
		jge second
		mov dx, 0
		div cx
		mul bx
		mov num1, ax
		
	second:
		mov ax, lcm
		mov bx, num2
		mov cx, den2
		cmp bx,ax
		jge process
		mov dx, 0
		div cx
		mul bx
		mov num2, ax
	process:
		mov cx,num1
		mov ax, num2
		add ax, cx
		mov var1, ax
	exiting:
		pop dx
		pop cx
		pop bx
		pop ax
		ret
		
result_num endp

display_result proc
	lea dx, arr5
	mov ah,09h
	int 21h
	
	mov ax,var1
	call dec_out
	
	mov dx,'/'
	mov ah,02h
	int 21h
	
	mov ax, lcm
	call dec_out
	
	
	ret
display_result endp

end main