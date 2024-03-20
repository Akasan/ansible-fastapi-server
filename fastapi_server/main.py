from fastapi import FastAPI


app = FastAPI()


@app.get(
    "/hello",
    description="index"
)
def index():
    return "hello"
