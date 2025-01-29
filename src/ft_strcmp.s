; ASM Intel X86-64bits -- FT_STRCMP
global ft_strcmp
extern __errno_location
section .text
ft_strcmp:
	; Vérification des paramètres
	test rdi, rdi           ; Vérifie si s1 (destination) est NULL
	jz .null_dest
	test rsi, rsi           ; Vérifie si s2 (source) est NULL
	jz .null_source

	; Initialisation
 	xor rax, rax            ; Initialise la valeur de retour à 0
    xor rcx, rcx
    xor rdx, rdx

.ft_strcmp_loop:
	; Charger les caractères de s1 et s2
	mov cl, byte [rdi]      ; Charge les char dans s1
	mov dl, byte [rsi]      ; Charge les char dans s2

    ; Vérifier la fin de chaîne
	test cl, cl             ; Vérifie si '\0'
	jz .end_compare
	test dl, dl
	jz .end_compare

	; Comparer les caractères
	cmp cl, dl              ; Compare s1[i] et s2[i]
	jne .end_compare        ; Si différents, return

	; Incrémenter les pointeurs
	inc rdi
	inc rsi
	jmp .ft_strcmp_loop
    
.null_dest:
	; Gestion d'erreur si s2 est NULL
	mov rdi, 0
	call __errno_location wrt ..plt
	mov dword [rax], 14     ; EFAULT
	mov rax, -1
	ret

.null_source:
	; Gestion d'erreur si s1 est NULL
	mov rdi, 0
	call __errno_location wrt ..plt
	mov dword [rax], 14     ; EFAULT
	mov rax, -1
	ret

.end_compare:
	; Calculer la différence entre s1[i] et s2[i]
    movzx rax, cl   ; Étend cl (s1[i]) à 64 bits avec des 0
    movzx rcx, dl
    sub rax, rcx    ; rax = s1[i] - s2[i]
    cmp rax, 0      ; Normalise le résultat et retourne 1, -1, ou 0 plutot que la len pour respecter les standards de la libc.
    jg .positive    ; 
    jl .negative
    ret

.positive:
    mov rax, 1
    ret
.negative:
    mov rax, -1
    ret