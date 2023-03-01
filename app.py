import os

from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql import text

DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"


db = SQLAlchemy()
db.init_app(app)


@app.route("/")
def index():
    return "<b>Hello from Team Peregrine!</b>"


@app.route("/version")
def settings():
    result = db.session.execute(text("SELECT VERSION()")).first()
    return f"PostgreSQL version: {result.tuple()[0]}"
