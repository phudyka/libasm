; ASM Intel X86-64bits -- FT_STRCMP

global ft_strcmp
extern __errno_location

section .text
ft_strcmp:
	test rdi, rdi ; char *s2 (Destination Index)
	jz .null_dest
	test rsi, rsi ; char *s1 (Source Index)
	jz .null_source

	xor rax, rax

.ft_strcmp_loop:

	; s1[i], s2[i] = 0;
	mov cl, [rdi]
	mov dl, [rsi]

	; Check fin de chaine
	test cl, cl
	jz .end_compare
	test dl, dl 
	jz .end_compare

	; Comparaison
	cmp	cl, dl
	jne	end_compare ; s1[i] != s2[i]

	; Incrementation
	inc rdi
	inc rsi
	jmp .compare_loop

.null_dest:
	
	; Gestion d'erreur si dest = NULL
	mov rdi, 0
	call __errno_location
	mov dword [rax], 14 ; EFAULT
	mov rax, 0
	ret

.null_source:
	
	; Gestion d'erreur si src = NULL
	mov rdi, 0
	call __errno_location
	mov dword [rax], 14 ; EFAULT
	mov rax, 0
	ret

.end_compare:
	;Calcul de la diff entre s1[i] et s2[i]
	movzx rax, close; MOVZX copie RAX dans CL en remplacant les bits en trop par des 0.
	movzx rcx, dl
	sub rax, rcx 	;s1[i] - s2[i]
	ret