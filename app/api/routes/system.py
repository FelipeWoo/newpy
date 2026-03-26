from fastapi import APIRouter

router = APIRouter()

@router.get("/")
def root():
    return {"status": "ok"}

@router.get("/health")
def health():
    return {"service": "running"}

@router.get("/info")
def info():
    return {
        "name": "mini-api",
        "version": "0.1.0"
    }