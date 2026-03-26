# newpy

`newpy` is a lightweight Python starter repo for spinning up new lab or service projects with a consistent structure, `uv`-based dependency management, FastAPI wiring, logging, tests, and a small bootstrap script that can clone this template into a fresh repository.

## What It Includes

- `uv` for environment and dependency management
- FastAPI app with basic system routes
- Pydantic-based boot/config loading from `.env`
- Centralized `loguru` logging setup
- `pytest`, coverage, Ruff, Black, and `ty`
- Optional CLI menu scaffold with `InquirerPy`
- Helper scripts for cloning this template into a new project

## Requirements

- Python 3.12+
- [`uv`](https://docs.astral.sh/uv/)
- Git
- Bash or another Unix-like shell

## Quick Start

1. Clone the repo.
2. Create or update `.env`.
3. Install dependencies.
4. Run the app.

```bash
make init
make run
```

The API starts with Uvicorn on `http://0.0.0.0:8000`.

## Environment Variables

Current `.env` shape:

```dotenv
APP_NAME=my_project
APP_ENV=development
LOG_LEVEL=DEBUG
```

These values are loaded in [`app/utils/boot.py`](/home/zenon/Documents/300_Projects/SOFTWARE/PUBLIC/newpy/app/utils/boot.py).

## Available Commands

```bash
make help
make init
make run
make test
make cov
make lint
make format
make ty
make check
make clean
make reset
make requirements
```

Package helpers:

```bash
make add p=requests
make add-dev p=pytest-mock
make add-api p=fastapi
make add-tools p=pandas
```

## API Endpoints

Defined in [`app/api/routes/system.py`](/home/zenon/Documents/300_Projects/SOFTWARE/PUBLIC/newpy/app/api/routes/system.py):

- `GET /` returns `{"status": "ok"}`
- `GET /health` returns `{"service": "running"}`
- `GET /info` returns app metadata

## Project Layout

```text
newpy/
├── app/
│   ├── api/routes/
│   ├── cli/
│   ├── domain/
│   ├── services/
│   ├── tests/
│   ├── main.py
│   └── utils/
├── data/
├── docs/
├── notebooks/
├── scripts/
├── Makefile
├── pyproject.toml
└── README.md
```

## Create a New Project From This Template

You can use the included helper script:

```bash
bash scripts/make_repo.sh my_project
```

That script:

- clones this repository into a new folder
- removes template-local artifacts like `.git`, `.venv`, and caches
- creates a fresh `.env`
- creates a `.private/notes.md` scratch file
- initializes a new Git repository

There is also an installer script for a shell function:

```bash
bash scripts/alias_make_repo.sh
source ~/.bash_aliases
newpy my_project
```

## Notes

- `make run` launches the FastAPI app from [`app/main.py`](/home/zenon/Documents/300_Projects/SOFTWARE/PUBLIC/newpy/app/main.py).
- Logging output is configured in [`app/utils/logger.py`](/home/zenon/Documents/300_Projects/SOFTWARE/PUBLIC/newpy/app/utils/logger.py) and writes to `logs/`.
- The CLI scaffold exists in [`app/cli/menu.py`](/home/zenon/Documents/300_Projects/SOFTWARE/PUBLIC/newpy/app/cli/menu.py), but the current default entrypoint runs the API server.

## License

See [`LICENSE`](/home/zenon/Documents/300_Projects/SOFTWARE/PUBLIC/newpy/LICENSE).
