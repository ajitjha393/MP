
;Macro for printing string 

print macro m
mov ah,09h
mov dx,offset m
int 21h
endm


.model small
.stack 100h
.data
  
  num1_msg   db 10,13,"Enter first number : $"
  num2_msg   db 10,13,"Enter second number : $"
  newline db 10,13,"$"
  number1 db ? 
  number2 db ?
  

.code
Main proc

  mov ax , @data
  mov ds , ax

  print num1_msg;
  call TAKE_ONE_NUMBER
  
  print newline   
  mov number1 , bl;

  call PRINT_NUMBER
  print newline

  print num2_msg
  call TAKE_ONE_NUMBER
  print newline

  mov number2 , bl;
call PRINT_NUMBER
  print newline


  print newline;

  call MULTIPY

  mov bx , ax

  call PRINT_NUMBER

  exit:

  mov ah , 4ch
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



TAKE_ONE_NUMBER proc

   mov bx ,00
    call ONE_DIGIT_INPUT;
    rol ax,04
    add bx,ax;

    call ONE_DIGIT_INPUT;
    add bx,ax;

    ret
TAKE_ONE_NUMBER endp



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



PRINT_NUMBER proc


    mov dx,bx;
    and dx, 0F000H
    ror dx,12
    call PRINT_DIGIT;



    mov dx,bx;
    and dx, 0F00H
    ror dx,8
    call PRINT_DIGIT;

    mov dx,bx;
    and dx, 00F0H
    ror dx,4
    call PRINT_DIGIT;


    mov dx,bx;
    and dx, 000FH
    call PRINT_DIGIT;

    ret
PRINT_NUMBER endp



MULTIPY proc

  mov ax , 0

  mov bx,0
  mov bl , number1
  cmp bl , number2
  
  jc swap
  mov cl , number2
  jmp multiply

  swap:
  mov al , number2
  mov number1 , al;
  mov number2, bl;

  mov cl, number2
  
  multiply:

    mov bh , 0
    mov bl ,  number1
    add ax , bx


  loop multiply



  ret
MULTIPY endp


end Main