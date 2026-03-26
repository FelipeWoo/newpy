ENV_FILE := .env
APP_DIR := app
TEST_DIR := app/tests

ifneq ("$(wildcard $(ENV_FILE))","")
include $(ENV_FILE)
export
endif

.PHONY: help init add add-dev add-api add-tools run test cov lint format ty check clean reset requirements

help:
	@echo "Available commands:"
	@echo "  make init                 - Create virtual environment and install dependencies"
	@echo "  make add p=fastapi        - Add a base package"
	@echo "  make add-dev p=pytest     - Add a package to dev extra"
	@echo "  make add-api p=fastapi    - Add a package to api extra"
	@echo "  make add-tools p=pandas   - Add a package to tools extra"
	@echo "  make run                  - Run the main program"
	@echo "  make test                 - Run tests"
	@echo "  make cov                  - Run tests with coverage"
	@echo "  make lint                 - Run linters"
	@echo "  make format               - Format code"
	@echo "  make ty                   - Run ty type checker"
	@echo "  make check                - Run lint + ty + test"
	@echo "  make clean                - Remove temporary files"
	@echo "  make reset                - Recreate environment"
	@echo "  make requirements         - Export requirements.txt from uv.lock"

init:
	clear
	uv venv
	uv sync --extra dev --extra api --extra tools

add:
	clear
	@test -n "$(p)" || (echo "Use: make add p=package_name" && exit 1)
	uv add $(p)

add-dev:
	clear
	@test -n "$(p)" || (echo "Use: make add-dev p=package_name" && exit 1)
	uv add --optional dev $(p)

add-api:
	clear
	@test -n "$(p)" || (echo "Use: make add-api p=package_name" && exit 1)
	uv add --optional api $(p)

add-tools:
	clear
	@test -n "$(p)" || (echo "Use: make add-tools p=package_name" && exit 1)
	uv add --optional tools $(p)

run:
	clear
	uv run python -m app.main

test:
	clear
	APP_ENV=test uv run pytest $(TEST_DIR) -v -s

cov:
	clear
	APP_ENV=test uv run pytest $(TEST_DIR) --cov=$(APP_DIR) --cov-report=term-missing

lint:
	clear
	uv run ruff check $(APP_DIR) $(TEST_DIR)

format:
	clear
	uv run black $(APP_DIR) $(TEST_DIR)
	uv run ruff check $(APP_DIR) $(TEST_DIR) --fix

ty:
	clear
	uv run ty check $(APP_DIR)

check: lint ty test

clean:
	clear
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -exec rm -rf {} +
	rm -rf .pytest_cache .coverage coverage.xml htmlcov

reset: clean
	clear
	rm -rf .venv logs
	uv venv
	uv sync --extra dev --extra api --extra tools

requirements:
	clear
	uv lock --upgrade
	uv export --format requirements.txt > requirements.txt