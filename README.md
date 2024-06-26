# FastApi Server
This repository holds a FastApi server that interacts with the production database and is integrated with Auth0. The whole application is fully containerized for local development. It requires __Docker version 25.0.3__ to be installed and can be started by running a single command:
```bash
make build up
```
This command will:
- build all the containers
- mount the backud to postgresql
- start the api service with hot reload over ./src changes over http://localhost:8000
- start a pgadmin service running on http://localhost:8080/ with database connection already stored as known server
- setup a reverse engineer focused container to auto generate the SqlAlchemy Class Models

## Make file Commands
__You can run help command to promt Makefile actions documentation__
```bash
make help
```
__Usage: make [command]__
| Command | Description |
| ------ | ------ |
| help | promt commands help message |
| up | Starts all the containers |
| build | Builds all the containers |
| down | Tears down all the containers, deletes database volume |
| generate-models | Generates models from the database backup with reverse engineering. It requires container to be up |
| format | Formats the code with black |
| shell-into-api | Opens a bash into the api container |

## Features

- Fastapi Api Service with Object Oriented Hexagonal Architecture using Sql Alchemy
- Postgresql database with a Backup of the last state of the production database
- PgAdmin for Postgresql Query and Management
- Bruno Collection for Api Exploration and Integration Testing