global main
 extern printf
section .text
main:
push ebp
mov ebp, esp
sub esp, 12
LBL0:
jmp LBL1
LBL1:
jmp LBL13
LBL13:
mov eax, 0
mov [ebp-4], eax
jmp LBL3
LBL3:
mov eax, dword[ebp-4]
cmp eax, 10
setle bl
jle LBL6
jmp LBL15
LBL6:
push SL0
call printf
jmp LBL7
LBL15:
jmp LBL16
LBL7:
jmp LBL8
LBL16:
push SL1
push SL2
call printf
jmp LBL17
LBL8:
push dword[ebp-4]
push SL3
call printf
jmp LBL9
LBL17:
jmp LBL18
LBL9:
jmp LBL10
LBL18:
jmp LBL19
LBL10:
jmp LBL11
LBL19:
jmp main_end
LBL11:
jmp LBL14
LBL14:
mov eax, dword[ebp-4]
add eax, 1
mov eax, eax
mov [ebp-4], eax
jmp LBL5
LBL5:
mov eax, dword[ebp-4]
cmp eax, 10
setle bl
jle LBL6
jmp LBL15
main_end:
leave
ret
section .data
SL3: db '%d', 10, 0
SL2: db '%s', 10, 0
SL0: db 'i = ', 0
SL1: db 'End of loop', 0
