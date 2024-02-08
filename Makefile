NAME := Inception
DOCKER_COMPOSE_FILEPATH := ./srcs/docker-compose.yml
ENVIRONMENT_PATH := ./srcs/.env #make sure it exists
DOCKER_BASE_COMAND := docker compose --file $(DOCKER_COMPOSE_FILEPATH) --env-file $(ENVIRONMENT_PATH) --project-name $(NAME)
# /home/login/data this will be the path  begining for the turn in
DATABASE_VOLUME_PATH := ./temp_volumes/mariadb-data
WORDPRESS_VOLUME_PATH := ./temp_volumes/wordpress-data

# Color Aliases
NONE='\033[0m'
GREEN='\033[32m'
GRAY='\033[2;37m'
CURSIVE='\033[3m'
YELLOW = '\033[0;93m'

.PHONY: all
all: build up

.PHONY: help
help:
	@echo $(YELLOW) "Available commands:" $(NONE)
# @echo 
#what should this do?

.PHONY: up
up:
	$(DOCKER_BASE_COMAND) up
# --detach

.PHONY: build
build:
	$(DOCKER_BASE_COMAND) build

.PHONY: down
down:
	$(DOCKER_BASE_COMAND) down

.PHONY: clean
clean:

.PHONY: make_data_dirs
make_data_dirs:
	@echo $(CURSIVE) $(GRAY) "Making data directory for mariadb volume" $(NONE)
	@mkdir -p $(DATABASE_VOLUME_PATH)
	@echo $(CURSIVE) $(GRAY) "Making data directory for mariadb volume" $(NONE)
	@mkdir -p $(WORDPRESS_VOLUME_PATH)
	@echo $(GREEN) "Data directories created" $(NONE)

#change to clean volume directories
.PHONY: clean
fclean: clean
	@echo $(CURSIVE) $(GRAY) "Pruning all docker containers and images" $(NONE)
	docker system prune -af
	@echo $(CURSIVE) $(GRAY) "Pruning all docker volumes" $(NONE)
	docker volumes prune -f
	@echo $(GREEN) "Project files cleaned" $(NONE)

.PHONY: re
re: fclean all
