; ASM Intel X86-64bits -- FT_STRLEN

; Registre = zone mémoire integré dans le processeur, stock de la data pour les calculs du proc.
; Liste des registres 64 bits : RAX, RBX, RCX, RDX, RSI, RDI, RBP, RSP, R8 à R15.

;Registres spécifiques :
; - RIP : Instruction Pointer (adresse de la prochaine instruction à exécuter).
; - RSP : Stack Pointer (sommet de la pile).
; - RBP : Base Pointer (base pour accéder aux variables locales).
; - Registres de segment : rarement utilisés en 64 bits (CS, DS, etc.).

global ft_strlen			; Directive de l'assembleur, signal au linker que cette fonction doit etre visible depuis d'autres fichiers objets. (= public / extern dans un .h).
extern	__errno_location 	; Déclaration de errno, Gestionnaire d'erreurs. (=  #include <ernno.h>).

section .text				; Réserve une nouvelle section pour le code executable.
ft_strlen:
	; Vérification des parametres d'entrée:
	test rdi, rdi			; Vérification de la valeur du pointeur, contient l'adresse de la chaine. rdi = adresse de base de la chaine.
	jz .null_pointer		; Si pointeur NULL, renvoie une erreur via errno - jz = "Jump if Zero",  equivalent de je ("Jump if Equal"). Utilise en suite un "test"/"cmp" pour connaitre le resultat.

	; Initialisation des registres:
	xor rax, rax			; rax = registre general, accumulateur (valeur de retour d'une fonction).Iterateur initialiser a 0, Valeur de retour. (Plus rapide que "mov rax, 0").

.ft_strlen_loop:

	; Debut de la boucle
	mov cl, [rdi + rax]		; mov = move - CL = Registre 8bits pour lire les char - [RDI + RAX] adresse du calcul.
							; Calcul donc "string" + "index", lit 1 octet (8bits), copie ce caractere dans CL.
	
	; Test la fin de la chaine
	test cl, cl 			; Compare la caractere a 0 (fin de la chaine).
	jz .end					; Si NULL, fin de la comparaison, et donc fin de .ft_strlen_loop.

	; Incrmentation
	inc rax					; Incremente l'index RAX a chaque tour de boucle.
	jmp	.ft_strlen_loop		; Récursive .ft_strlen_loop, jmp = "Jump", saut inconditionnel.

.null_pointer:
	; Gestion du pointeur NULL
	mov rdi, 0				; Code d'erreur.
	call __errno_location	; Appel a errno.
	mov dword [rax], 14		; dword = 32bits, 14 = EFAULT = "Bad Address". equivalent de errno = EFAULT; en C.
	mov rax, -1				; Valeur de retour avec une erreur (-1).

.end:
	ret						; Retourne la longueur de la chaine dans RAX (return)