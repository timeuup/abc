;Name :-Shriyash Shingare
;Roll No:-203707
;Div- Panel 1
;Aim-Display the contents of GDTR,LDTR,IDTR,Tr and MSW.

;PROGRAM

%macro rw 4
mov rax,%1
mov rdi,%2
mov rsi,%3							;macro for input and output operation
mov rdx,%4
syscall 
%endmacro

section .data
msg db "GDTR is ",10
msglen equ $-msg

msg1 db 10,"GDTR limit is ",10
msglen1 equ $-msg1

msg2 db 10,"TR is ",10
msglen2 equ $-msg2

msg3 db 10,"IDTR is",10
msglen3 equ $-msg3

msg4 db 10,"IDTR limit is",10					;messages for displaying register and limit
msglen4 equ $-msg4

msg5 db 10,"MSW is",10
msglen5 equ $-msg5

newline db " ",10
len equ $-newline

section .bss
GDTR resb 8
gdtrlimit resb 2
tr resb 2
temp resb 1							;declaring undeclared variables
IDTR resb 8
idtrlimit resb 2
msw resb 2

section .text
global _start
_start:

call gdtrfunc
call idtrfunc
call trfunc							;different function calls 
call mswfunc

rw 1,1,newline,len
rw 60,0,0,0							;end of program


display64:
mov bp,16

up:rol rax,4
mov rbx,rax
and rax,0fh
cmp rax,09h
jbe down1			
add rax,07h							;function defination of displaying 64 bit data 
down1:
add rax,30h

mov byte[temp],al
rw 1,1,temp,1
mov rax,rbx
dec bp
jnz up

ret

display16:
mov bp,4

up1: rol ax,4
mov bx,ax
and ax,0fh
cmp ax,09h
jbe down2
add ax,07h							;function defination of displaying 16 bit data
down2:
add ax,30h
mov byte[temp],al
rw 1,1,temp,1 
mov ax,bx
dec bp
jnz up1

ret

gdtrfunc:
rw 1,1,msg,msglen

mov esi,GDTR
sgdt [esi]
mov rax,[esi]

call display64
rw 1,1,msg1,msglen1						;function defination of gdtr register
mov esi,gdtrlimit
mov ax,[esi]

call display16
ret

trfunc:
rw 1,1,msg2,msglen2

mov esi,tr
str [esi]
mov ax,[esi]
call display16							;function defination of tr register
ret

idtrfunc:
rw 1,1,msg3,msglen3

mov esi,IDTR
sidt [esi]
mov rax,[esi]

call display64
rw 1,1,msg4,msglen4						;function defination of idtr register
mov esi,idtrlimit
mov ax,[esi]

call display16
ret

mswfunc:
rw 1,1,msg5,msglen5
mov esi,msw
smsw [esi]							;function defination of msw register
mov ax,[esi]
call display16
ret

;OUTPUT:
mtech@MTECHCSE:~/Desktop/shriyash$ nasm -f elf64 assign3.asm 
mtech@MTECHCSE:~/Desktop/shriyash$ ld -o assign3 assign3.o 
mtech@MTECHCSE:~/Desktop/shriyash$ ./assign3 

GDTR is 
FE0000001000007F
GDTR limit is 
FFFF

IDTR is
FE00000000000FFF
IDTR limit is
FFFF

TR is 
0040

MSW is
0033
