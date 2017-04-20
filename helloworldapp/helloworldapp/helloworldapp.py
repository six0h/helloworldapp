# -*- coding: utf-8 -*-
from flask import Flask

app = Flask(__name__)

@app.route("/", methods=['GET'])
def hello():
    return "Hello World!"

@app.route("/<name>", methods=['POST'])
def respond_with_name(name):
    return "Hello {} World!".format(name)
