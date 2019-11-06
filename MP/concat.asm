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
msg1 db 10,13,"Enter the first String  : $"
msg2 db 10,13,"Enter the second String  : $"
newline db 10,13,"$"

String1 db 50 dup('$');
String2 db 50 dup('$');
String1_length db 0;
String2_length db 0;
temp db 0

.code
Main proc
mov ax ,@data
mov ds , ax

print msg1

mov si , offset String1
call TAKE_INPUT
mov String1_length , bl

print String1

print msg2

mov si , offset String2
call TAKE_INPUT
mov String2_length , bl

print String2

call CONCAT_STRING

print String1


mov ah , 4ch
int 21h

Main endp





TAKE_INPUT proc

mov temp , 0
  input:
  mov ah , 01
  int 21h

  cmp al , 13
  je label_end

  mov [si] , al
  inc temp
  inc si

  jmp input
  
  label_end:
    mov bl  , temp

ret
TAKE_INPUT endp


CONCAT_STRING proc

mov si , offset String1
mov di ,offset String2

mov cl , String1_length

length_label:
inc si
loop length_label

mov cl , String2_length


concat:

mov bl , [di]
mov [si] , bl
inc si 
inc di

loop concat



ret
CONCAT_STRING endp


end Main