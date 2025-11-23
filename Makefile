.PHONY: help build run test clean docker-build docker-run deploy-railway

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## Build the application
	mvn clean package -DskipTests

build-with-tests: ## Build the application with tests
	mvn clean package

run: ## Run the application locally
	mvn spring-boot:run

test: ## Run tests
	mvn test

clean: ## Clean build artifacts
	mvn clean

docker-build: ## Build Docker image
	docker build -t spring-vercel-app:latest .

docker-run: ## Run application in Docker
	docker run -p 8080:8080 spring-vercel-app:latest

docker-stop: ## Stop Docker container
	docker stop $$(docker ps -q --filter ancestor=spring-vercel-app:latest)

deploy-railway: ## Deploy to Railway
	railway up

dev: ## Run in development mode
	mvn spring-boot:run -Dspring-boot.run.profiles=dev

prod: ## Run in production mode
	SPRING_PROFILES_ACTIVE=prod java -jar target/spring-vercel-app.jar

install: ## Install dependencies
	mvn clean install

lint: ## Check code style
	mvn checkstyle:check

format: ## Format code
	mvn formatter:format

health-check: ## Check if application is running
	@curl -s http://localhost:8080/actuator/health | jq . || echo "Application is not running"

quick-test: ## Quick test of API endpoints
	@echo "Testing endpoints..."
	@echo "\n1. Root endpoint:"
	@curl -s http://localhost:8080/api/ | jq .
	@echo "\n2. Hello endpoint:"
	@curl -s http://localhost:8080/api/hello | jq .
	@echo "\n3. Status endpoint:"
	@curl -s http://localhost:8080/api/status | jq .
	@echo "\n4. Health check:"
	@curl -s http://localhost:8080/actuator/health | jq .

