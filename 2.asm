;Name :-Shriyash Shingare
;Roll No:-203707
;Div- Panel 1
;Aim-Calculate mean of 5 real numbers.

%macro rw 4
mov rax,%1
mov rdi,%2
mov rsi,%3							;macro for input and output operation
mov rdx,%4
syscall 
%endmacro

section .data
divisor dd 5.0							;divisor element
arr dd 12.00,13.43,12.56,56.34,46.33				;predifined floating type array of 5 element
mult dd 10000.0
mean dt 0.0
count1 db 10							;useful predifined element 
count2 db 2
mydot db "."
								;end of data section 
section .bss
res resb 2



section .text 							;starting of text section
global _start
_start:

fldz
mov cl,05h
mov esi,arr
up:
fadd dword[esi]							;addition of element 
add esi,04h
dec cl
jnz up

fdiv dword[divisor]
fmul dword[mult] 
fbstp tword[mean]

mov rbp,mean
add rbp,9h


ott:								;outer loop
mov bh,byte[rbp]
mov byte[count2],02h
cmp byte[count1],02h

jne dot
rw 1,1,mydot,1
dot:
inn:								;inner loop
							
rol bh,04h
mov bl,bh
and bh,0fh
cmp bh,09h
jbe down
add bh,07h							;unpacking of register value
down:
add bh,30h
mov byte[res],bh
rw 1,1,res,1
mov bh,bl
dec byte[count2]
jnz inn								;exit of inner loop 							

dec rbp
dec byte[count1]
jnz ott 							;exit of outer loop

mov rax,60
mov rdi,0
syscall


;OUTPUT:
mtech@MTECHCSE:~/Desktop/shriyash$ nasm -f elf64 mean.asm 
mtech@MTECHCSE:~/Desktop/shriyash$ ld -o mean mean.o 
mtech@MTECHCSE:~/Desktop/shriyash$ ./mean 
0000000000000028.1320
