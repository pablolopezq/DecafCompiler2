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
mov eax, 97
mov [ebp-4], eax
jmp LBL3
LBL3:
jmp LBL4
LBL4:
mov eax, 15670
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
push SL1
call printf
jmp LBL13
LBL13:
jmp LBL14
LBL14:
push SL3
call printf
jmp LBL15
LBL15:
jmp LBL16
LBL16:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setg bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setg bl
jg LBL17
jmp LBL18
LBL17:
push SL4
push SL5
call printf
jmp LBL19
LBL18:
push SL6
push SL5
call printf
jmp LBL19
LBL19:
jmp LBL20
LBL20:
push SL7
call printf
jmp LBL21
LBL21:
jmp LBL22
LBL22:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setl bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setl bl
jl LBL23
jmp LBL24
LBL23:
push SL4
push SL5
call printf
jmp LBL25
LBL24:
push SL6
push SL5
call printf
jmp LBL25
LBL25:
jmp LBL26
LBL26:
push SL8
call printf
jmp LBL27
LBL27:
jmp LBL28
LBL28:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setge bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setge bl
jge LBL29
jmp LBL30
LBL29:
push SL4
push SL5
call printf
jmp LBL31
LBL30:
push SL6
push SL5
call printf
jmp LBL31
LBL31:
jmp LBL32
LBL32:
push SL9
call printf
jmp LBL33
LBL33:
jmp LBL34
LBL34:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setle bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setle bl
jle LBL35
jmp LBL36
LBL35:
push SL4
push SL5
call printf
jmp LBL37
LBL36:
push SL6
push SL5
call printf
jmp LBL37
LBL37:
jmp LBL38
LBL38:
push SL10
call printf
jmp LBL39
LBL39:
jmp LBL40
LBL40:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setne bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setne bl
jne LBL41
jmp LBL42
LBL41:
push SL4
push SL5
call printf
jmp LBL43
LBL42:
push SL6
push SL5
call printf
jmp LBL43
LBL43:
jmp LBL44
LBL44:
push SL11
call printf
jmp LBL45
LBL45:
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
push SL5
call printf
jmp LBL49
LBL48:
push SL6
push SL5
call printf
jmp LBL49
LBL49:
jmp LBL50
LBL50:
mov eax, 98765
mov [ebp-4], eax
jmp LBL51
LBL51:
jmp LBL52
LBL52:
mov eax, 15670
mov [ebp-8], eax
jmp LBL53
LBL53:
jmp LBL54
LBL54:
push SL0
call printf
jmp LBL55
LBL55:
jmp LBL56
LBL56:
push dword[ebp-4]
push SL1
call printf
jmp LBL57
LBL57:
jmp LBL58
LBL58:
push SL2
call printf
jmp LBL59
LBL59:
jmp LBL60
LBL60:
push dword[ebp-8]
push SL1
call printf
jmp LBL61
LBL61:
jmp LBL62
LBL62:
push SL3
call printf
jmp LBL63
LBL63:
jmp LBL64
LBL64:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setg bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setg bl
jg LBL65
jmp LBL66
LBL65:
push SL4
push SL5
call printf
jmp LBL67
LBL66:
push SL6
push SL5
call printf
jmp LBL67
LBL67:
jmp LBL68
LBL68:
push SL7
call printf
jmp LBL69
LBL69:
jmp LBL70
LBL70:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setl bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setl bl
jl LBL71
jmp LBL72
LBL71:
push SL4
push SL5
call printf
jmp LBL73
LBL72:
push SL6
push SL5
call printf
jmp LBL73
LBL73:
jmp LBL74
LBL74:
push SL8
call printf
jmp LBL75
LBL75:
jmp LBL76
LBL76:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setge bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setge bl
jge LBL77
jmp LBL78
LBL77:
push SL4
push SL5
call printf
jmp LBL79
LBL78:
push SL6
push SL5
call printf
jmp LBL79
LBL79:
jmp LBL80
LBL80:
push SL9
call printf
jmp LBL81
LBL81:
jmp LBL82
LBL82:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setle bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setle bl
jle LBL83
jmp LBL84
LBL83:
push SL4
push SL5
call printf
jmp LBL85
LBL84:
push SL6
push SL5
call printf
jmp LBL85
LBL85:
jmp LBL86
LBL86:
push SL10
call printf
jmp LBL87
LBL87:
jmp LBL88
LBL88:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setne bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setne bl
jne LBL89
jmp LBL90
LBL89:
push SL4
push SL5
call printf
jmp LBL91
LBL90:
push SL6
push SL5
call printf
jmp LBL91
LBL91:
jmp LBL92
LBL92:
push SL11
call printf
jmp LBL93
LBL93:
jmp LBL94
LBL94:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
sete bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
sete bl
je LBL95
jmp LBL96
LBL95:
push SL4
push SL5
call printf
jmp LBL97
LBL96:
push SL6
push SL5
call printf
jmp LBL97
LBL97:
jmp LBL98
LBL98:
mov eax, 98765
mov [ebp-4], eax
jmp LBL99
LBL99:
jmp LBL100
LBL100:
mov eax, 98765
mov [ebp-8], eax
jmp LBL101
LBL101:
jmp LBL102
LBL102:
push SL0
call printf
jmp LBL103
LBL103:
jmp LBL104
LBL104:
push dword[ebp-4]
push SL1
call printf
jmp LBL105
LBL105:
jmp LBL106
LBL106:
push SL2
call printf
jmp LBL107
LBL107:
jmp LBL108
LBL108:
push dword[ebp-8]
push SL1
call printf
jmp LBL109
LBL109:
jmp LBL110
LBL110:
push SL3
call printf
jmp LBL111
LBL111:
jmp LBL112
LBL112:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setg bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setg bl
jg LBL113
jmp LBL114
LBL113:
push SL4
push SL5
call printf
jmp LBL115
LBL114:
push SL6
push SL5
call printf
jmp LBL115
LBL115:
jmp LBL116
LBL116:
push SL7
call printf
jmp LBL117
LBL117:
jmp LBL118
LBL118:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setl bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setl bl
jl LBL119
jmp LBL120
LBL119:
push SL4
push SL5
call printf
jmp LBL121
LBL120:
push SL6
push SL5
call printf
jmp LBL121
LBL121:
jmp LBL122
LBL122:
push SL8
call printf
jmp LBL123
LBL123:
jmp LBL124
LBL124:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setge bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setge bl
jge LBL125
jmp LBL126
LBL125:
push SL4
push SL5
call printf
jmp LBL127
LBL126:
push SL6
push SL5
call printf
jmp LBL127
LBL127:
jmp LBL128
LBL128:
push SL9
call printf
jmp LBL129
LBL129:
jmp LBL130
LBL130:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setle bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setle bl
jle LBL131
jmp LBL132
LBL131:
push SL4
push SL5
call printf
jmp LBL133
LBL132:
push SL6
push SL5
call printf
jmp LBL133
LBL133:
jmp LBL134
LBL134:
push SL10
call printf
jmp LBL135
LBL135:
jmp LBL136
LBL136:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setne bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
setne bl
jne LBL137
jmp LBL138
LBL137:
push SL4
push SL5
call printf
jmp LBL139
LBL138:
push SL6
push SL5
call printf
jmp LBL139
LBL139:
jmp LBL140
LBL140:
push SL11
call printf
jmp LBL141
LBL141:
jmp LBL142
LBL142:
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
sete bl
mov eax, dword[ebp-4]
cmp eax, dword[ebp-8]
sete bl
je LBL143
jmp LBL144
LBL143:
push SL4
push SL5
call printf
jmp LBL145
LBL144:
push SL6
push SL5
call printf
jmp LBL145
LBL145:
jmp LBL146
LBL146:
jmp LBL147
LBL147:
jmp main_end
main_end:
leave
ret
section .data
SL11: db 'x == y: ', 0
SL10: db 'x != y: ', 0
SL9: db 'x <= y: ', 0
SL0: db 'x = ', 0
SL8: db 'x >= y: ', 0
SL7: db 'x < y:  ', 0
SL2: db 'y = ', 0
SL6: db 'false', 0
SL3: db 'x > y: ', 0
SL1: db '%d', 10, 0
SL5: db '%s', 10, 0
SL4: db 'true', 0
