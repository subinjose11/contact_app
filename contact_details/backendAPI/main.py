from flask import Flask, redirect,jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
import os

#Creating object to the Flask class with current module
app=Flask(__name__)



# If current module is main module, run the flask application
if __name__=='__main__':
    app.run(debug=True)
