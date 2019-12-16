global main
 extern printf
section .text
main:
push ebp
mov ebp, esp
sub esp, 12
LBL0:
push SL0
call printf
jmp LBL1
LBL1:
jmp LBL2
LBL2:
push SL1
push SL2
call printf
jmp LBL3
LBL3:
jmp LBL4
LBL4:
jmp LBL5
LBL5:
jmp main_end
main_end:
leave
ret
section .data
SL2: db '%s', 10, 0
SL0: db 'Hello World!', 10, 0
SL1: db 'Hola Mundo', 0
