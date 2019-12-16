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
jmp LBL2
LBL2:
mov eax, 9800
mov [ebp-4], eax
jmp LBL3
LBL3:
jmp LBL4
LBL4:
mov eax, 324234
mov [ebp-8], eax
jmp LBL5
LBL5:
jmp LBL6
LBL6:
push SL0
call printf
jmp LBL7
LBL7:
jmp LBL8
LBL8:
push dword[ebp-4]
push SL1
call printf
jmp LBL9
LBL9:
jmp LBL10
LBL10:
push SL2
call printf
jmp LBL11
LBL11:
jmp LBL12
LBL12:
push dword[ebp-8]
push SL3
call printf
jmp LBL13
LBL13:
jmp LBL14
LBL14:
push SL4
call printf
jmp LBL15
LBL15:
jmp LBL16
LBL16:
mov eax, dword[ebp-4]
add eax, dword[ebp-8]
push eax
push SL3
call printf
jmp LBL17
LBL17:
jmp LBL18
LBL18:
push SL5
call printf
jmp LBL19
LBL19:
jmp LBL20
LBL20:
mov eax, dword[ebp-4]
sub eax, dword[ebp-8]
push eax
push SL3
call printf
jmp LBL21
LBL21:
jmp LBL22
LBL22:
push SL6
call printf
jmp LBL23
LBL23:
jmp LBL24
LBL24:
mov eax, dword[ebp-4]
cdq
mov ecx, dword[ebp-8]
imul ecx
push eax
push SL3
call printf
jmp LBL25
LBL25:
jmp LBL26
LBL26:
push SL7
call printf
jmp LBL27
LBL27:
jmp LBL28
LBL28:
mov eax, dword[ebp-4]
cdq
mov ecx, dword[ebp-8]
idiv ecx
push eax
push SL3
call printf
jmp LBL29
LBL29:
jmp LBL30
LBL30:
push SL8
call printf
jmp LBL31
LBL31:
jmp LBL32
LBL32:
mov eax, dword[ebp-4]
cdq
mov ecx, dword[ebp-8]
idiv ecx
mov eax, edx
push eax
push SL3
call printf
jmp LBL33
LBL33:
jmp LBL34
LBL34:
jmp LBL35
LBL35:
jmp main_end
main_end:
leave
ret
section .data
SL8: db 'Mod ', 0
SL7: db 'Div ', 0
SL6: db 'Mul ', 0
SL1: db '%d', 0
SL0: db 'X = ', 0
SL3: db '%d', 10, 0
SL2: db ', Y = ', 0
SL4: db 'Add ', 0
SL5: db 'Sub ', 0
