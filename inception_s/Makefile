NAME := inception
DOCKER_COMPOSE_FILEPATH := ./srcs/docker-compose.yml
ENVIRONMENT_PATH := ./srcs/.env
DOCKER_BASE_COMAND := docker compose --file $(DOCKER_COMPOSE_FILEPATH) --env-file $(ENVIRONMENT_PATH) --project-name $(NAME)

DATABASE_VOLUME_PATH := /home/jebouche/data/mariadb-data
DATABASE_VOLUME_NAME := mariadb-data
WORDPRESS_VOLUME_PATH := /home/jebouche/data/wordpress-data
WORDPRESS_VOLUME_NAME := wordpress-data

# Color Aliases
NONE='\033[0m'
GREEN='\033[32m'
GRAY='\033[2;37m'
CURSIVE='\033[3m'
YELLOW = '\033[0;93m'

ifeq ($(wildcard $(ENVIRONMENT_PATH)), )
	$(error .env files does not exist, please create it before running $(NAME))
endif

.PHONY: all
all: $(ENVIRONMENT_PATH) make_data_dirs build up

.PHONY: help
help:
	@echo $(YELLOW) "Available commands:" $(NONE)
	@echo $(GREEN) "make" $(NONE) "build and up, checks if directories an dfiles exist"
	@echo $(GREEN) "build" $(NONE) " runs docker compose build only"
	@echo $(GREEN) "up" $(NONE) " runs docker compose up"
	@echo $(GREEN) "down" $(NONE) " runs docker compose down"
	@echo $(GREEN) "clean" $(NONE) " removes docker containers and images"
	@echo $(GREEN) "fclean" $(NONE) "calls clean and removes volume contents and directories"
	@echo $(GREEN) "re" $(NONE) "calls fclean and makes with all (same as make)"

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

.PHONY: make_data_dirs
make_data_dirs:
	@echo $(CURSIVE) $(GRAY) "Checking data directory for mariadb volume" $(NONE)
	@mkdir -p $(DATABASE_VOLUME_PATH)
	@echo $(CURSIVE) $(GRAY) "Checking data directory for mariadb volume" $(NONE)
	@mkdir -p $(WORDPRESS_VOLUME_PATH)
	@echo $(GREEN) "Data directories created / exist" $(NONE)

.PHONY: clean
clean:
	@echo $(CURSIVE) $(GRAY) "Pruning all docker containers and images" $(NONE)
	docker system prune -a

.PHONY: fclean
fclean: clean

	@if [ -d $(DATABASE_VOLUME_PATH) ]; then \
		echo $(CURSIVE) $(GRAY) "Deleting data directory and volume for mariadb" $(NONE); \
		sudo rm -rf $(DATABASE_VOLUME_PATH); \
		docker volume rm $(DATABASE_VOLUME_NAME); \
	else \
		echo $(CURSIVE) $(GRAY) "mariadb volume already cleaned" $(NONE); \
	fi
	
	@if [ -d $(WORDPRESS_VOLUME_PATH) ]; then \
		echo $(CURSIVE) $(GRAY) "Deleting data directory for wordpress volume" $(NONE); \
		sudo rm -rf $(WORDPRESS_VOLUME_PATH); \
		docker volume rm $(WORDPRESS_VOLUME_NAME); \
	else \
		echo $(CURSIVE) $(GRAY) "wordpress volume already cleaned" $(NONE); \
	fi
	
	@echo $(GREEN) "Data directories are removed" $(NONE)

.PHONY: re
re: fclean all	

