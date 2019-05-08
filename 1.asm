section .data  			;data section 
arr1 db 09h,08h,07h,06h,05h


section .bss			;bss section
arr2 resb 15

section .text			;start of text section
global _start
_start:


mov ch,05h
outer:				;outer  loop
mov esi,arr1			;setting up counter
mov cl,04h

inner :				;inner loop
mov al,byte[esi]
cmp al,byte[esi+1]
jbe down

xchg al,byte[esi+1]		;swaping values
mov byte[esi],al
down:
inc esi
dec cl
jnz inner			;end of

dec ch
jnz outer			;end of outer loop


mov esi,arr1
mov edi,arr2


mov ch,05h
ott:
mov al,byte[esi]
mov cl,02h


inn:
rol al,04h
mov bl,al
and al,0fh
cmp al,09h
jbe down1			;unpacking arr and display it on to the terminal
add al,07h
down1:
add al,30h
mov byte[edi],al
inc edi
mov al,bl
dec cl
jnz inn

mov byte[edi],20h
inc esi
inc edi
dec ch
jnz ott

mov rax,1
mov rdi,1
mov rsi,arr2
mov rdx,15
syscall

mov rax,60
mov rdi,0
syscall
