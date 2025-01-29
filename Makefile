# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: phudyka <phudyka@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/23 11:38:10 by phudyka           #+#    #+#              #
#    Updated: 2025/01/29 10:40:52 by phudyka          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = libasm.a

NASM = nasm
NASM_FLAGS = -f elf64 -DPIC 				# Options pour NASM LINUX 64bits
CC = gcc
CFLAGS = -Wall -Wextra -Werror -fPIE -pie 	# Compatible PIE (Position Independent Executable) pour ASLR (Address Space Layout Randomization) -> rend possible la compilation sur un systeme Linux moderne pour la relocation.

SRCS = src/ft_strlen.s \
       src/ft_strcpy.s \
       src/ft_strcmp.s \
       src/ft_write.s \
       src/ft_read.s \
       src/ft_strdup.s

OBJ_DIR = obj
OBJS = $(SRCS:src/%.s=$(OBJ_DIR)/%.o)

TEST_SRC = main.c
TEST_EXEC = test_libasm

RED = \033[0;31m
GREEN = \033[0;32m
RESET = \033[0m

all: $(NAME)

$(NAME): $(OBJS)
	@echo -e "$(GREEN)Création de l'archive $(NAME)...$(RESET)"
	ar rcs $@ $^
	@echo -e "$(GREEN)Archive $(NAME) créée avec succès !$(RESET)"

$(OBJ_DIR)/%.o: src/%.s
	@mkdir -p $(OBJ_DIR)
	$(NASM) $(NASM_FLAGS) $< -o $@

$(TEST_EXEC): $(NAME) $(TEST_SRC)
	@echo -e "$(GREEN)Compilation de l'exécutable de test $(TEST_EXEC)...$(RESET)"
	$(CC) $(CFLAGS) -o $(TEST_EXEC) $(TEST_SRC) -L. -lasm
	@echo -e "$(GREEN)Exécutable $(TEST_EXEC) compilé avec succès !$(RESET)"

ccproject: $(NAME) $(TEST_SRC)
	@echo -e "$(GREEN)Compilation du ccproject avec la bibliothèque $(NAME)...$(RESET)"
	$(CC) $(CFLAGS) $(TEST_SRC) -L. -lasm -o ccproject -z execstack
	@echo -e "$(GREEN)Exécutable ccproject créé avec succès !$(RESET)"

clean:
	@echo -e "$(RED)Suppression des fichiers objets...$(RESET)"
	rm -rf $(OBJ_DIR)

fclean: clean
	@echo -e "$(RED)Suppression de l'archive $(NAME) et des fichiers d'exécution...$(RESET)"
	rm -f $(NAME) $(TEST_EXEC) ccproject

re: fclean all

.PHONY: all clean fclean re ccproject