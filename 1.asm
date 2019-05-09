section .data  			
arr1 db 09h,08h,07h,06h,05h


section .bss		
arr2 resb 15

section .text			
global _start
_start:


mov ch,05h
outer:				
mov esi,arr1			
mov cl,04h

inner :				
mov al,byte[esi]
cmp al,byte[esi+1]
jbe down

xchg al,byte[esi+1]		
mov byte[esi],al
down:
inc esi
dec cl
jnz inner			

dec ch
jnz outer			


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
jbe down1			
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
