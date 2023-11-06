# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: doduwole <doduwole@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/09/19 14:16:52 by mamesser          #+#    #+#              #
#    Updated: 2023/11/06 20:39:07 by doduwole         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# NAME = cub3D

# CFLAGS = -Wall -Wextra -Werror #-g -fsanitize=address

# MLXFLAGS = -L/usr/X11/lib -lX11 -lXext -lm #-O3

# SRCS_DIR = ./srcs/

SRCS := $(addprefix $(SRCS_DIR),raycaster.c \
								parser_utils1.c \
								parser_utils2.c \
								parser.c parser2.c \
								parser3.c \
								init.c \
								main.c \
								setup_view.c \
								init_raycasting.c \
								raycaster_utils.c \
								dda_utils.c \
								utils.c \
								key_hooks.c \
								mini_map.c \
								mini_map_utils.c \
								free_mem.c \
								mouse_move.c \
								floor_ceiling.c \
								hand_item.c \
								init_tex.c \
								alloc_tex.c)

# LIBFT_DIR = ./libft

# LIBFT = $(LIBFT_DIR)/libft.a

# MLXLIB_DIR = ./minilibx

# MLXLIB = $(MLXLIB_DIR)/libmlx.a

# OBJS := $(SRCS:$(SRCS_DIR)%.c=$(SRCS_DIR)%.o)

# HEADERS = cub.h

# .PHONY: clean fclean re all

# all: $(NAME)

# $(NAME): $(OBJS) $(MLXLIB) $(LIBFT)
# 	cc $(CFLAGS) $(OBJS) $(MLXLIB) $(LIBFT) $(MLXFLAGS) -o $@

# $(LIBFT):
# 	$(MAKE) bonus -C $(LIBFT_DIR)

# $(MLXLIB):
# 	$(MAKE) -C $(MLXLIB_DIR)

# $(SRCS_DIR)%.o: $(SRCS_DIR)%.c $(HEADERS)
# 	cc $(CFLAGS) -I. -c $< -o $@

# install on linux:
# 	@sudo apt update && sudo apt install build-essential libx11-dev libglfw3-dev libglfw3 xorg-dev libbsd-dev

# bonus: all

# clean:
# 	$(MAKE) clean -C $(LIBFT_DIR)
# 	$(MAKE) clean -C $(MLXLIB_DIR)
# 	rm -f $(OBJS)

# fclean: clean
# 	$(MAKE) fclean -C $(LIBFT_DIR)
# 	rm -f $(NAME)

# re: fclean all


NAME = cub3D


RM = rm -rf

CFLAGS = -Werror -Wall -Wextra

OBJ_DIR = obj
SRC_DIR = srcs
INC_DIR = inc

# SRC := $(addprefix $(SRCS_DIR), raycaster.c \
# 								parser_utils1.c \
# 								parser_utils2.c \
# 								parser.c parser2.c \
# 								parser3.c \
# 								init.c \
# 								main.c \
# 								setup_view.c \
# 								init_raycasting.c \
# 								raycaster_utils.c \
# 								dda_utils.c \
# 								utils.c \
# 								key_hooks.c \
# 								mini_map.c \
# 								mini_map_utils.c \
# 								free_mem.c \
# 								mouse_move.c \
# 								floor_ceiling.c \
# 								hand_item.c \
# 								init_tex.c \
# 								alloc_tex.c)
SRC := $(wildcard srcs/*.c)

OBJS = $(SRC:%.c=$(OBJ_DIR)/%.o)

CC = gcc #-g -fsanitize=address 

LIBFTDIR = ./libft

LIBFTA = $(LIBFTDIR)/libft.a


# Detect the operating system
UNAME_S := $(shell uname -s)

# macOS
ifeq ($(UNAME_S),Darwin)
MLX_DIR = ./minilibx
MLX = $(MLX_DIR)/libmlx.a
LINK = -L$(MLX_DIR) -lmlx -framework OpenGL -framework AppKit

# Linux
else
MLX_DIR = ./minilibx-linux
MLX = $(MLX_DIR)/libmlx.a
LINK = -L$(MLX_DIR) -lmlx -lX11 -lXext -lm
endif
# endif marks the end of a conditional block in a Makefile

NONE='\033[0m'
GREEN='\033[32m'
GRAY='\033[2;37m'
CURSIVE='\033[3m'
WARNING='\033[33m'

all: $(NAME)

$(NAME): $(LIBFTA) $(MLX) $(SRC) $(OBJS)
	@$(CC) $(OBJS) $(LIBFTA) $(LINK) -o $@
	@echo $(GREEN)"- Compiled -"$(NONE)

$(OBJ_DIR)/%.o: %.c $(LIBFTA)
	@echo $(CURSIVE)$(GRAY) "     - Building $<" $(NONE)
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -Imlx -c $< -o $@

$(MLX):
	@make all -C $(MLX_DIR)

$(LIBFTA):
	@make all -C $(LIBFTDIR)

clean:
	@$(RM) $(OBJS) $(OBJ_DIR)
	@make -C $(LIBFTDIR) clean
	@make -C $(MLX_DIR) clean
	@echo $(CURSIVE)$(GRAY) "     - Object files removed" $(NONE)

fclean: clean
	@rm -f $(NAME)
	@make -C $(LIBFTDIR) fclean
	@echo $(CURSIVE)$(GRAY) "     - $(NAME) removed" $(NONE)

re: fclean all

.PHONY: all clean fclean re
