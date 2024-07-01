include .env

GREEN  := \033[0;32m
CYAN   := \033[0;36m
YELLOW := \033[0;33m
RESET  := \033[0m

## [ help ]: pront commands help message
help:
	@echo "${YELLOW}You can use the following commands:"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | while IFS= read -r line; do \
	    command=$$(echo $$line | sed -E 's/\[([^]]+)\]/\\033[0;36m[\1]\\033[0m/'); \
	    printf "$$command\n"; \
	done
	@echo "${GREEN}Usage: make [command]"

## [ up ]: Starts all the containers
up:
	@docker compose up
## [ build ]: Builds all the containers
build:
	@docker compose build
## [ down ]: Tears down all the containers, delete database volume
down:
	@docker compose down -v
## [ generate-models ]: Generates models from the database backup with reverse engineering. It requires container to be up
generate-models:
	@docker compose exec generator bash -c "sqlacodegen ${POSTGRES_URL}  --outfile ./generated/database_models.py"
## [ format ]: Formats the code with black
format:
	@docker compose exec api bash -c "black ./src"
## [ shell-into-api ]: Opens a bash into the api container
shell-into-api:
	@docker compose exec api bash

test:
	sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':'