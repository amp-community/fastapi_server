include .env

up:
	@docker compose up
build:
	@docker compose build
down:
	@docker compose down -v
generate-models:
	@docker compose exec generator bash -c "sqlacodegen ${POSTGRES_URL}  --outfile ./generated/database_models.py"
format:
	@docker compose exec api bash -c "black ./src"
shell-into-api:
	@docker compose exec api bash