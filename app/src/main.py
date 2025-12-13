import pandas as pd
from fastapi import FastAPI
from pydantic import BaseModel
from fastai.tabular.all import *
from pathlib import Path
import random

app = FastAPI()

MODEL_PATH = Path("model.pkl")
learn = None

class PredictIn(BaseModel):
    x1: float
    x2: float
    x3: float

def make_tiny_data(n: int = 200):
    rows = []
    for _ in range(n):
        x1 = random.random() * 10
        x2 = random.random() * 10
        x3 = random.random() * 10
        y = 2 * x1 - 0.5 * x2 + 0.1 * x3
        rows.append({"x1": x1, "x2": x2, "x3": x3, "y": y})
    return pd.DataFrame(rows)

def load_model_if_exists():
    global learn
    if MODEL_PATH.exists():
        learn = load_learner(MODEL_PATH)
        return True
    return False

@app.on_event("startup")
def startup():
    load_model_if_exists()

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/train")
def train():
    global learn

    df = make_tiny_data()

    dls = TabularDataLoaders.from_df(
        df,
        procs=[Normalize],
        cont_names=["x1", "x2", "x3"],
        y_names="y",
        bs=32,
    )

    learn = tabular_learner(dls, layers=[64, 32])
    learn.fit(2, 1e-2)

    learn.export(MODEL_PATH)
    return {"trained": True, "model_file": str(MODEL_PATH)}

@app.post("/predict")
def predict(body: PredictIn):
    global learn

    if learn is None and not load_model_if_exists():
        return {"error": "model not trained yet. call POST /train first"}

    row = pd.DataFrame([body.model_dump()])

    try:
        res = learn.predict(row.iloc[0])
        pred = res[0]
        return {"prediction": float(pred)}
    except Exception as e:
        return {"error": str(e)}
