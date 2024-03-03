#########################################################################################\
#		-MAKEFILE-																		#\
#		PROJECT: pipex																	#\
#########################################################################################

NAME = $(BIN_DIR)pipex

CC	= cc
CFLAGS = -Wall -Wextra -Werror
LIBFT_PATH = ./lib/libft/bin/
DATA_STR_PATH = ./lib/data_structures_C/bin/
LIBFT = $(LIBFT_PATH)libft.a
AR = ar rcs
RM = rm -rf

########################################################################################\
Directories
########################################################################################

HDR_DIR	=	./lib/
BIN_DIR = 	./bin/
SRC_DIR	=	./src/

HEAD_DIR =		./

BIN_DIRS	=	$(addprefix $(BIN_DIR), $(HEAD_DIR))

########################################################################################\
Sources & objects
########################################################################################

MAIN_FILES	=	main

FILES	=	$(addprefix $(HEAD_DIR), $(MAIN_FILES))

SRCS	=	$(addprefix $(SRC_DIR), $(addsuffix .c, $(FILES)))
OBJS	=	$(addprefix $(BIN_DIR), $(addsuffix .o, $(FILES)))

########################################################################################\
Colors
########################################################################################

DEF_COLOR = \033[0;39m
CUT = 		\033[K
R = 		\033[31;1m
G = 		\033[32;1m
Y = 		\033[33;1m
B = 		\033[34;1m
P = 		\033[35;1m
GR = 		\033[30;1m
END = 		\033[0m

########################################################################################\
Rules
########################################################################################

all: libft data_str $(NAME)

libft: $(LIBFT)

data_str: $(FT_PRINTF)

$(LIBFT):
	@make -C $(LIBFT_PATH)

$(DATA_STR):
	@make -C $(DATA_STR_PATH)

$(NAME): $(OBJS)
	@$(CC) $(OBJS) $(LIBFT) $(DATA_STR) -o $@
	@echo "\n$(G)[PIPEX] Compilation finished!$(DEF_COLOR)-> $(NAME)\n"

$(BIN_DIR)%.o:$(SRC_DIR)%.c
	@mkdir -p $(BIN_DIRS)
	@echo "$(Y)Compiling: $< $(DEF_COLOR)"
	@$(CC) $(CFLAGS) -I$(HDR_DIR) -c $< -o $@

clean: clean_libs
	@$(RM) $(OBJS)
	@echo "$(R)[$(NAME)] All $(OBJ_DIR)*.o files removed$(DEF_COLOR)\n"

fclean: clean fclean_libs
	@$(RM) $(NAME)
	@echo "$(R)[PIPEX] binary removed$(DEF_COLOR)\n"

clean_libs:
	@make clean -C $(LIBFT_PATH)
	@make clean -C $(DATA_STR_PATH)

fclean_libs:
	@make fclean -C $(LIBFT_PATH)
	@make fclean -C $(DATA_STR_PATH)

re: fclean all

norminette:
	norminette $(SRC_DIR)		

.PHONY: all clean fclean re norminette