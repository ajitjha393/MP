;for a year to be a leap year 
;year % 400 === 0 (leap)
;year % 100 === 0(not leap) ( it is leap if divisible by 400 and not by 100)
;year % 4 === 0(leap) (divisible by 4 but not by 100 and 400)
;not a leap if divisible by none of 100,400,4

;Macro for printing string 

print macro m
mov ah,09h
mov dx,offset m
int 21h
endm


.model small
.stack 100h
.data
  msg db 10,13,"Enter a year : $"
  newline db 10,13,"$"
  leap_msg db 10,13,"It is a leap year $"
  not_leap_msg db 10,13,"It is not a leap year ",10,13,"$"
  hello db 10,13,"HELLO $"
  num dw ?
  year dw ?

.code
Main proc
  mov ax,@data
	mov ds,ax

print msg

call INPUT

print newline

call LEAP_OR_NOT


  exit: 
    mov ah , 4ch
    int 21h

Main endp



ONE_DIGIT_INPUT proc
	
	mov ah,01
	int 21h
	sub al , 30h
	ret
ONE_DIGIT_INPUT endp


INPUT proc
  call ONE_DIGIT_INPUT
  mov ah, 00
  mov cx ,1000
  mul cx
  mov year , ax

  call ONE_DIGIT_INPUT
  mov ah, 00
  mov cl ,100
  mul cl
  add year , ax


  call ONE_DIGIT_INPUT
  mov ah, 00
  mov cl ,010
  mul cl
  add year , ax

  call ONE_DIGIT_INPUT
  mov ah, 00
  add year , ax

  

  ret
INPUT endp

PRINT_INPUT proc

;jusr replaced year by num
  mov ax , num
  mov cx , 16 
  mov bx, 8000h


   print_label:

    mov ax , num
    and ax , bx
    jz zero

    one:
    mov dl , 31h
    jmp label1

    zero:
    mov dl , 30h


    label1:
    mov ah,02
    int 21h
    ror bx,1

    loop print_label

  ret
PRINT_INPUT endp



LEAP_OR_NOT proc

div_by_4:
  
  mov ax , year
  mov bx , 4
  mov dx , 0000
  div bx
  cmp dx , 0
  
  je div_by_100
  jmp div_by_400


div_by_100:
  mov ax , year
  mov bx , 0100
  mov dx , 0000
  div bx
  cmp dx,0



  je div_by_400
  jmp leap_year



div_by_400:

  mov ax , year
  mov dx , 0000
  mov bx , 400

  div bx
  
  ;mov num , dx
  ;call PRINT_INPUT  
  ;print newline

  cmp dx , 0

  je leap_year
  jmp not_leap_year


not_leap_year:
  print not_leap_msg
   jmp endlabel
  

leap_year:
  print leap_msg
jmp endlabel
  



  
  endlabel:  
    ret

LEAP_OR_NOT endp





end Main


