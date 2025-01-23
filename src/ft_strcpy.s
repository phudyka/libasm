; ASM Intel X86-64bits -- FT_STRCPY

global ft_strcpy
extern __errno_location

section .text
ft_strcpy:

;Verification des parametres
test rdi, rdi ; char *destination
jz .null_dest
test rsi, rsi ; char *source
jz .null_source

mov rax, rdi

.ft_strcpy_loop:

; Lecture des caracteres
mov cl, [rsi]

; Copie des caracteres
mov [rdi], cl 

test cl, cl 
jz .end

; Incrémentation
inc rdi ; destination[i++]
inc rsi ; source[i++]
jmp .ft_strcpy_loop

.null_dest:
; Gestion d'erreur si dest = NULL

mov rdi, 0
call __errno_location
mov dword [rax], 14 ; EFAULT
mov rax, 0
ret

.null_source
; Gestion d'erreur si source = NULL
mov rdi, 0
call __errno_location
mov dword [rax], 14 ; EFAULT
mov rax, 0
ret

.end
	ret