; ASM Intel X86-64bits -- FT_STRCMP

global ft_strcmp
extern __errno_location

section .text
ft_strcmp:
test rdi, rdi ; char *str1 (Destination Index)
jz .null_dest
test rsi, rsi ; char *str2 (Source Index)
jz .null_source

xor rax, rax

.ft_strcmp_loop:

mov cl, [rdi]
mov dl, [rsi]

test cl, cl 
jz .end_compare
test dl, dl 
jz .end_compare