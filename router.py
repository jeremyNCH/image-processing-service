from fastapi import APIRouter, Query
from fastapi.responses import JSONResponse

router = APIRouter()

@router.get("/echo")
def echo_user_input(input: str = Query(..., description="Input to echo")):
    return JSONResponse(content={"echo": input})
