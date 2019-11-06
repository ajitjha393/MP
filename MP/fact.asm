;Print function
;------------------
print macro m
mov ah,09h
mov dx,offset m
int 21h
mov ah , 0
endm
;-------------------

.model small
stack 100h

.data
msg1 db 10,13,"Enter the number  : $"
n db ?
newline db 10,13,"$"
temp dw ?
result1 dw ?
result2 dw ?




.code
Main proc
mov ax ,@data
mov ds , ax

print msg1
call TAKE_ONE_DIGIT
mov n , al

print newline

call FACTORIAL


call PRINT_OUTPUT



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


FACTORIAL proc

  mov dx , 0
  mov ah , 00
  mov al , n

  mov cl , n
  dec cx

  mov bx , ax

  fact:
  dec bx
  mul bx

  loop fact







ret
FACTORIAL endp



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


PRINT_WORD proc

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
PRINT_WORD endp







PRINT_OUTPUT proc

  mov result1 , dx
  mov result2 , ax


  cmp result1 , 0
  je print_AX

  print_DX:
  mov bx , result1
  call PRINT_WORD


  print_AX:
  mov bx , result2
  call PRINT_WORD



ret
PRINT_OUTPUT endp


end Main