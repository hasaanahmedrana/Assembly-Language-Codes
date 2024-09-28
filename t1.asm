.model small
.stack 100h
.386

.data
    arr1 db 10,13,'Enter 8-bit binary number: $'
    arr2 db 13, 10, 'The hexadecimal representation is: $'
	new_line db 13,10,'$'
    errorr db 'Invalid input. Please enter only 0 or 1.$'
	count db 5
	count1 db 5 
	arr3 db 5 dup(0)  
	
.code
main proc
    mov ax, @data
    mov ds, ax
	
    lea si, arr3
	
againn:	
	lea dx, arr1
	mov ah,09
	int 21h 
		
	call binary_input
	
	
	mov [si], bl        
    inc si 
 
	dec count 
	jnz againn
	
	lea di, arr3
	
	againn2:	
		lea dx, new_line
		mov ah,09h
		int 21h
		
		lea dx, arr2
    	mov ah, 09h
    	int 21h

    	mov bl, [di]        
    	call hexaDecimalOutput
		inc di
    	dec count1
	jnz againn2

    ;terminating the code
    mov ah, 4Ch
    int 21h
main endp
	

binary_input proc
    mov bx, 0           
    mov cx, 8           

input_loop:
    mov ah, 01h        
    int 21h

    cmp al, 13         
    je done            

    cmp al, '0'
    je process_digit
    cmp al, '1'
    je process_digit


    lea dx, errorr
    mov ah, 09h
    int 21h
    jmp input_loop     

process_digit:
    sub al, '0'        
    shl bl, 1         
    or  bl, al        
    dec cx            
    jnz input_loop    

done:
    ret
binary_input endp

hexaDecimalOutput proc
    mov cx, 2        
    
convert_loop:
    rol bl, 4         
    mov dl, bl        
    and dl, 0Fh       
    
    cmp dl, 9
    jbe convert_digit 
    add dl, 55        
    jmp print_char

convert_digit:
    add dl, 48        

print_char:
    mov ah, 02h       
    int 21h
    dec cx            
    jnz convert_loop  
	
    ret
hexaDecimalOutput endp

end main 