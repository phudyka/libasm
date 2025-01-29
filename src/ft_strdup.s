; ASM Intel X86-64bits -- FT_STRDUP

global ft_strdup
extern __errno_location
extern malloc
extern ft_strlen
extern ft_strcpy

section .text
ft_strdup:

    push rdi                ; Sauvegarde dest sur la stack
    test rdi, rdi
    jz .null_error

    call ft_strlen          ; Appel à ft_strlen pour calculer la taille.
    cmp rax, -1             ; Verifie retour positif de ft_strlen.
    je .strlen_error        ; "Jump if is Equal to", em l'occurence -1.
    inc rax                 ; Ajouter +1 pour le caractère nul '\0'.

    ; Allocation de mémoire avec malloc
    mov rdi, rax            ; Passer la taille en paramètre à malloc.
    call malloc wrt ..plt
    test rax, rax           ; Vérifier si malloc a réussi.
    jz .malloc_error

    ; Préparation pour la copie
    mov rdi, rax            ; Adresse mémoire allouée.
    pop rsi                 ; Restaurer l'adresse source depuis la stack.

    ; Copie des données
    push rax                ; Sauvegarder l'adresse allouée.
    call ft_strcpy          ; Appel à ft_strcpy pour copier la chaîne.
    pop rax                 ; Restaurer l'adresse allouée pour le retour.
    ret

.null_error:
    mov rdi, 0
    call __errno_location wrt ..plt
    mov dword [rax], 14     ; EFAULT "Bad Address"
    mov rax, 0
    ret

.strlen_error:
    pop rdi                 ; Free la stack.
    ret

.malloc_error:
    mov rdi, 0
    call __errno_location wrt ..plt
    mov dword [rax], 12     ; ENOMEM "Pas assez de mémoire"
    mov rax, 0
    ret