# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaammari <aaammari@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/09/19 13:13:32 by aaammari          #+#    #+#              #
#    Updated: 2023/09/23 16:32:48 by aaammari         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

V_DB = /home/aaammari/data/mariadb
V_WP = /home/aaammari/data/wordpress

RM_VLS = $(shell docker volume ls -q)

all: mkdir
	@docker compose -f ./srcs/docker-compose.yml up --build

mkdir:
	@mkdir -p $(V_DB)
	@mkdir -p $(V_WP)

up:
	@docker compose -f ./srcs/docker-compose.yml up

down:
	@docker compose -f ./srcs/docker-compose.yml down

clean:
	@docker compose -f ./srcs/docker-compose.yml down --rmi all

fclean: clean
	@docker system prune -af
	@docker volume prune -f
	@docker image prune -af
	@docker container prune -f
	@docker network prune -f
	@sudo rm -fr $(V_DB)
	@sudo rm -fr $(V_WP)
	@if [ "$(RM_VLS)" != "" ]; then docker volume rm $(RM_VLS); fi

re: fclean all

.PHONY: all mkdir clean fclean re
