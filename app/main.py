import uvicorn
from fastapi import FastAPI

from app.api.routes.system import router as system_router
from app.cli.menu import menu
from app.utils.boot import boot

config = boot("main")
print(f"Application: {config.name}")  # optional

# FastAPI option
app = FastAPI(title="mini-api")
app.include_router(system_router, prefix="")


def main() -> None:

    uvicorn.run(
        "app.main:app",
        host="0.0.0.0",
        port=8000,
        reload=True,
    )

    # # CLI option
    # menu()


if __name__ == "__main__":
    main()
