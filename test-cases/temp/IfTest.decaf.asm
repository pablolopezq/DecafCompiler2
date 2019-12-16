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
mov eax, 5
mov [ebp-4], eax
jmp LBL3
LBL3:
jmp LBL4
LBL4:
mov eax, 7
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
jmp LBL22
LBL22:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
sete bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
sete bl
je LBL23
jmp LBL24
LBL23:
push SL4
call printf
jmp LBL15
LBL24:
push SL5
call printf
jmp LBL19
LBL15:
jmp LBL16
LBL19:
jmp LBL20
LBL16:
jmp LBL17
LBL20:
jmp LBL21
LBL17:
jmp LBL25
LBL21:
jmp LBL25
LBL25:
jmp LBL26
LBL26:
mov eax, 456
mov [ebp-4], eax
jmp LBL27
LBL27:
jmp LBL28
LBL28:
mov eax, 456
mov [ebp-8], eax
jmp LBL29
LBL29:
jmp LBL30
LBL30:
push SL0
call printf
jmp LBL31
LBL31:
jmp LBL32
LBL32:
push dword[ebp-4]
push SL1
call printf
jmp LBL33
LBL33:
jmp LBL34
LBL34:
push SL2
call printf
jmp LBL35
LBL35:
jmp LBL36
LBL36:
push dword[ebp-8]
push SL3
call printf
jmp LBL37
LBL37:
jmp LBL46
LBL46:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
sete bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
sete bl
je LBL47
jmp LBL48
LBL47:
push SL4
call printf
jmp LBL39
LBL48:
push SL5
call printf
jmp LBL43
LBL39:
jmp LBL40
LBL43:
jmp LBL44
LBL40:
jmp LBL41
LBL44:
jmp LBL45
LBL41:
jmp LBL49
LBL45:
jmp LBL49
LBL49:
jmp LBL50
LBL50:
jmp LBL51
LBL51:
jmp main_end
main_end:
leave
ret
section .data
SL5: db 'X is not equal to Y', 10, 0
SL4: db 'X is equal to Y', 10, 0
SL3: db '%d', 10, 0
SL2: db ' Y = ', 0
SL0: db 'X = ', 0
SL1: db '%d', 0
