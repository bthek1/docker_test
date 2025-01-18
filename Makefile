

# Makefile

help:			# Show this help.
	@echo "Available commands:"
	@echo "For more information, see the README.md file."
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


# Define project variables
PROJECT_NAME = docker_test
DOCKER_COMPOSE = docker compose


build: ## Build the Docker container
	$(DOCKER_COMPOSE) build


up: ## Start the Docker container
	$(DOCKER_COMPOSE) up -d

down: ## Stop the Docker container
	$(DOCKER_COMPOSE) down

shell: ## Start a shell session in the Docker container
	$(DOCKER_COMPOSE) exec app bash

logs: ## Show the Docker container
	$(DOCKER_COMPOSE) logs -f

clean: ## Stop and remove the Docker container
	$(DOCKER_COMPOSE) down --volumes --remove-orphans
	docker system prune -f
