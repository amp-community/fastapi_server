include .env

up:
	@docker compose up
build:
	@docker compose build
down:
	@docker compose down -v