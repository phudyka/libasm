# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: phudyka <phudyka@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/23 11:38:10 by phudyka           #+#    #+#              #
#    Updated: 2025/01/23 16:16:50 by phudyka          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = libasm.a

NASM = nasm               # Netwide Assembler - equivalent de GCC pour l'assembleur
NASM_FLAGS = -f elf64     # Format objet pour systeme 64bits, Executable and Linkable Format (standard Linux)
CC = gcc                 
CFLAGS = -Wall -Wextra -Werror 

SRCS = src/ft_strlen.s \
       src/ft_strcpy.s \
       src/ft_strcmp.s \
       src/ft_write.s \
       src/ft_read.s \
       src/ft_strdup.s

OBJS = $(SRCS:.s=.o)

all: $(NAME)

$(NAME): $(OBJS)
	ar rcs $@ $^

%.o: %.s
	$(NASM) $(NASM_FLAGS) $< -o $@

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re