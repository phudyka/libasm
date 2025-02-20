; ASM Intel X86-64bits -- FT_READ

global ft_read
extern __errno_location

section .text
ft_read:
	;Verification des parametres
	test rdi, rdi	; check fd
	jl .error_fd	; JL "Jump if Less" -> if x < n
	test rsi, rsi	; check NULL
	jz .error_buf
	test rdx, rdx	; check taille
	jl .error_count

	mov rax, 0		; 0 correspond au syscall read
	syscall

	;Gestion d'erreur
	cmp rax, 0
	jl .error
	ret

.error_fd:
	mov rdi, 9 		;EBADF "Error Bad File Descriptor"
	jmp .set_errno

.error_buf:
	mov rdi, 14		;EFAULT
	jmp .set_errno
	
.error_count:
	mov rdi, 22		;ENINVAL "Invalid argument"
	jmp .set_errno

.error:
	neg rax			; Transforme l'erreur négative en une valeur positive pour recuperer un code erreur, ex si x = -1, avec neg -> return = 1
	mov rdi, rax

.set_errno:
	call __errno_location wrt ..plt
	mov [rax], rdi
	mov rax, -1 	; Stocke le code d'erreur (dans `rdi`) à l'adresse retournée
	ret