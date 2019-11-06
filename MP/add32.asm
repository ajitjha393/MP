
;Print function
;------------------
print macro m
mov ah,09h
mov dx,offset m
int 21h
endm
;-------------------

.model small
stack 100h

.data
msg1 db 10,13,"Enter the number 1 : $"
msg2 db 10,13,"Enter the number 2 : $"
newline db 10,13,"$"
num1_higher dw ?
num1_lower dw ? 
num2_higher dw ?
num2_lower dw ?
result_lower dw ?
result_higher dw ?
temp dw ? 
carry dw 0

.code
Main proc

mov ax , @data
mov ds , ax

print msg1
call GET_INPUT
mov num1_higher , bx

call GET_INPUT
mov num1_lower , bx

print msg2
call GET_INPUT
mov num2_higher , bx

call GET_INPUT
mov num2_lower , bx

mov bx , 0


call ADD_32;


print newline


mov bx , result_higher
call PRINT_RESULT

mov bx , result_lower
call PRINT_RESULT

mov ah , 4ch
int 21h

Main endp


TAKE_ONE_DIGIT proc


mov ah , 01 
int 21h
mov ah , 0

cmp al , 'A'
jc label1
sub al , 7
label1:
sub al,30h


ret
TAKE_ONE_DIGIT endp



GET_INPUT proc
;---first we will store first 4 bit in 1 and rest in another
mov bx , 0
  call TAKE_ONE_DIGIT
  rol ax , 12
  mov bx, ax

  call TAKE_ONE_DIGIT
  rol ax , 8
  add bx , ax

  call TAKE_ONE_DIGIT
  rol ax , 4
  add bx, ax

  
  call TAKE_ONE_DIGIT
  add bx, ax



  



ret
GET_INPUT endp



ADD_32 proc

mov bx , num1_lower
mov cx , num2_lower

add bx , cx
mov result_lower , bx

jc label_set_carry
jmp add_higher_bit
label_set_carry:
mov carry , 1

add_higher_bit:
;mov result_lower , bx

mov bx , num1_higher
mov cx , num2_higher
add bx , cx
add bx , carry
mov result_higher , bx



ret
ADD_32 endp


PRINT_ONE_DIGIT proc

cmp dl , 10
jc label_add
add dl , 7

label_add:
add dl , 30h
mov ah , 02
int 21h

mov ah , 00

ret
PRINT_ONE_DIGIT endp


PRINT_RESULT proc

 mov temp , bx;
 and bx , 0F000h
 ror bx , 12

 mov dl , bl
 call PRINT_ONE_DIGIT



 mov bx , temp;
 and bx , 0F00h
 ror bx , 8

 mov dl , bl
 call PRINT_ONE_DIGIT



 mov bx , temp;
 and bx , 00F0h
 ror bx , 4

 mov dl , bl
 call PRINT_ONE_DIGIT



 mov bx , temp
 and bx , 000Fh

 mov dl , bl
 call PRINT_ONE_DIGIT




ret
PRINT_RESULT endp





end Main

