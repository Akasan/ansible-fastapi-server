from fastapi import FastAPI


app = FastAPI()


app.get(
    "/",
    description="index"
)
def index():
    return "hello"
