# controller/controller.py
# Add your FastAPI route logic here or import routers as needed.

from fastapi import APIRouter

router = APIRouter()

# Example placeholder route
@router.get("/controller-status")
def controller_status():
    return {"status": "controller is active"}
