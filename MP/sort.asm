
;;;;;MOther fucker problem was i was taking value in bx ;;instead of bl while comparing 


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
msg1 db 10,13,"Enter the number of elements of array : $"

sorted_array db 10,13,"Sorted array is => $"

newline db 10,13,"$"
array db 20 dup('$')
array_length db ?
num1 dw ?
num2 dw ?
temp dw ?
count db ?
space db "  $"
msg3 db 10,13,"Inside Swap :( $"
.code
Main proc

mov ax ,@data
mov ds , ax

print msg1
call GET_INPUT

print newline

mov array_length , bl

call GET_ARRAY_ELEMENTS



print sorted_array


call SORT_ARRAY

print newline

call PRINT_ARRAY



Main endp




exit:
mov ah , 4ch
int 21h


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

  call TAKE_ONE_DIGIT
  mov bx , ax
  rol bx , 4

  call TAKE_ONE_DIGIT
  add bx,ax


ret
GET_INPUT endp


GET_ARRAY_ELEMENTS proc

  mov si , offset array
  mov ch , 0
  mov cl , array_length

  loop_label:

    call GET_INPUT
    mov [si] , bl
    INC si

    print newline

    loop loop_label


ret
GET_ARRAY_ELEMENTS endp


SORT_ARRAY proc 


  mov ch , 0
  mov cl , array_length
  dec cx

  

outer_loop:

  mov di , offset array

  mov dl , array_length
  mov count , dl

  mov dl ,00
  dec count


  inner_loop:

    mov bl , [di]
    ;mov num1 , bx
    
    
    
    ;inc di
    mov al , [di + 1]
    ;mov num2 , ax 
    


    cmp bl , al 
    jc end_label
    
    swap:

   mov [di] , al ;//bx is no 2
    
   ; dec di
  ;  mov bx , num2
    mov [di+1] , bl 
    ;inc di


    end_label:
    inc di
    dec count
    ;call PRINT_ARRAY    
    ;Print newline 
    
    cmp count  , 0


  jne inner_loop 


 loop outer_loop



ret
SORT_ARRAY endp


PRINT_ARRAY proc

mov si , offset array

mov ch , 0
mov cl , array_length

print_array_label:

  mov bx , [si]
  inc si
  call PRINT_NUMBER
  print space


  loop print_array_label





ret
PRINT_ARRAY endp



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





PRINT_NUMBER proc


mov temp , bx
and bx , 0F0h
ror bx , 4
mov dl , bl
call PRINT_ONE_DIGIT


mov bx , temp
and bx , 0Fh
mov dl , bl
call PRINT_ONE_DIGIT



ret
PRINT_NUMBER endp


end Main




