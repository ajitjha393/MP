
;Macro for printing string 


print macro m
mov ah,09h
mov dx,offset m
int 21h
endm


.model small
.stack 100h
.data
  input_msg  db 10,13," Enter a number : $"
  newline db 10,13,"$"
	num db ?

.code
Main proc


  mov ax,@data
	mov ds,ax
  
	print input_msg;
  call ONE_DIGIT_INPUT;
  
	mov num , al;
  
	
	print newline;

	mov dl , num; 
	call PRINT_DIGIT;

	print newline;

	mov al , num;
	not al;
	add al , 01h;
	

	mov cl , 8;
	mov num , al;
	mov bl , 80h;

	label_loop:
		mov al , num;
		and al ,bl;
		jz zero

		one:
		mov dl , 31h;
		jmp rotate;
		
	zero:
		mov dl , 30h;
	
	rotate:		
	mov ah,02h
	int 21h
	ror bl , 1;



	loop label_loop


	
	
	mov ah,4ch
	int 21h

Main endp



ONE_DIGIT_INPUT proc
	
	mov ah,01
	int 21h
	and ah,00h

	cmp al,41h
	jc label_i
	sub al,07h
	label_i:
		sub al,30h
	
	ret
ONE_DIGIT_INPUT endp

PRINT_DIGIT proc

	cmp dl,0AH
	jc label_j
	add dl,07h
	
	label_j:
	add dl,30h;
	
	mov ah,02h
	int 21h

	ret
PRINT_DIGIT endp



end Main
