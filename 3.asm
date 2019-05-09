

%macro rw 4
mov rax,%1
mov rdi,%2
mov rsi,%3						
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

msg4 db 10,"IDTR limit is",10					
msglen4 equ $-msg4

msg5 db 10,"MSW is",10
msglen5 equ $-msg5

newline db " ",10
len equ $-newline

section .bss
GDTR resb 8
gdtrlimit resb 2
tr resb 2
temp resb 1							
IDTR resb 8
idtrlimit resb 2
msw resb 2

section .text
global _start
_start:

call gdtrfunc
call idtrfunc
call trfunc							
call mswfunc

rw 1,1,newline,len
rw 60,0,0,0						


display64:
mov bp,16

up:rol rax,4
mov rbx,rax
and rax,0fh
cmp rax,09h
jbe down1			
add rax,07h							
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
add ax,07h							
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
rw 1,1,msg1,msglen1					
mov esi,gdtrlimit
mov ax,[esi]

call display16
ret

trfunc:
rw 1,1,msg2,msglen2

mov esi,tr
str [esi]
mov ax,[esi]
call display16							
ret

idtrfunc:
rw 1,1,msg3,msglen3

mov esi,IDTR
sidt [esi]
mov rax,[esi]

call display64
rw 1,1,msg4,msglen4					
mov esi,idtrlimit
mov ax,[esi]

call display16
ret

mswfunc:
rw 1,1,msg5,msglen5
mov esi,msw
smsw [esi]							
mov ax,[esi]
call display16
ret


