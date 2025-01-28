; ASM Intel X86-64bits -- FT_STRDUP

global	ft_strdup
extern	__errno_location
extern	malloc
extern	ft_strlen

extern	ft_strcpy

section .text
ft_strdup:

	push rdi		; Sauvegarde dest sur la heap
	test rdi, rdi
	jz .null_error

	call ft_strlen	; Appel a la fonction extern ft_strlen
	inc rax 		; +1 pur '\0'

	;MALLOC
	mov rdi, rax	; sizeof()
	call malloc
	test rax, rax
	jz .malloc_error

	;Preparation de la copie
	mov rdi, rax
	pop rsi			; Restaure dest de la heap

	;Copie src dans dest
	push rax		; Sauvegarde adresse d'allocation sur la heap
	call ft_strcpy	; Appel a la fonction extern ft_strcpy
	pop rax			; Restaure adresse pour return
	ret

.null_error:
	mov rdi, 0
	call __errno_location
	mov dword [rax], 14 ; EFAULT
	mov rax, 0
	ret

.malloc_error:
	mov rdi, 0
	call __errno_location
	mov dword [rax], 12 ; ENOMEM "available data space not large enough to accommodate the shared memory segment"
	mov rax, 0
	ret