
;Macro for printing string 

print macro m
mov ah,09h
mov dx,offset m
int 21h
endm


.model small
.stack 100h
.data


menu_msg   db 10,13,"1. Print The String ",10,13
		   db "2. Length Of The String",10,13
		   db "3. Reverse Of The String",10,13
		   db "4. Palindrome or not ",10,13
           db "5. Find the occurence of a character ",10,13
		   db "6. Exit ",10,13
		   db "Enter a choice : ",10,13,"$"


Input_String_msg db 10,13,"Enter a string : $"
Display_String_msg db 10,13,"Entered String => $"
Length_Of_String_msg db 10,13,"Length of the Entered String =>  $"
Reverse_Of_String_msg db 10,13,"Reverse => $"
String_is_palindrome_msg db 10,13,"Entered String is a Palindrome string ",10,13,"$"
String_is_not_palindrome_msg db 10,13,"Entered String is not a Palindrome string",10,13,"$"
Character_to_find_msg db 10,13,"Enter the character to be Searched : $"
Present_at_index_msg db 10,13,"Character is present at index => $"
Not_present_msg db 10,13,"Entered Character is not present in the string $"

Entered_String db 30 dup('$')
choice db ?
String_Length db ?
temp1 db ?
temp2 db ?
index db ?


.code

Main proc

    mov ax,@data
    mov ds,ax

menu:
    print menu_msg
    call INPUT_CHAR
    mov choice ,al

    cmp choice , '6'
    je exit
    
    
    case1:
        print Input_String_msg
        call INPUT_STRING
        
        cmp choice , '1'
        jne case2

        print Display_String_msg
        print Entered_String

        jmp menu

   exit: 
    mov ah,4ch
    int 21h
        

    case2:

        cmp choice , '2'
        jne case3

        print Length_Of_String_msg
        mov dl,String_Length
        add dl,30h
        mov ah,02
        int 21h

        jmp menu

    
    case3:

        cmp choice , '3'
        jne case4

        print Reverse_Of_String_msg
        call REVERSE_STRING

        jmp menu


    case4:

        cmp choice , '4'
        jne case5

        mov si , offset Entered_String
        mov di , si
        mov cl , String_Length
        dec cl
       
       loop3:
        INC di
       loop loop3


        check_loop:
            cmp si,di
            je Palindrome

            cmp  di , si
            jc Palindrome

            mov al , [si]
            mov temp1 , al

            mov al,[di]
            cmp temp1,al
            jne NOT_PALINDROME

            

            INC si
            DEC di

        jmp check_loop

        Palindrome:
            print String_is_palindrome_msg
            jmp menu

        NOT_PALINDROME:
            print String_is_not_palindrome_msg
            jmp menu     


    case5:
        mov si , offset Entered_String
        mov cl , String_Length
        mov bl , 00h

        print Character_to_find_msg
        call INPUT_CHAR


        loop4:

            cmp al , [si]
            je present
            inc bl
            inc si
        loop loop4

        Not_present:
            print Not_present_msg  

        present:
            print Present_at_index_msg
            mov dl , bl
            add dl , 30h
            mov ah , 02
            int 21h
        jmp menu

    
Main endp


INPUT_CHAR proc
    mov ah,01
    int 21h
    ret
INPUT_CHAR endp

INPUT_STRING proc
    mov si , offset Entered_String
    mov cl,00h
    loop1:
        call INPUT_CHAR
        cmp al,0Dh
        je end_label
        mov [si],al
        inc si
        inc cl
        jmp loop1
    end_label:
    mov String_Length , cl
    ret
INPUT_STRING endp


REVERSE_STRING proc
    mov cl , String_Length
    DEC si
    loop2:
        mov dl , [si]
        mov ah , 02
        int 21h

        dec si
        loop loop2


    ret
REVERSE_STRING endp



end main