from flask import Flask,request,jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
import os

# Creating Flask application instance
app = Flask(__name__)

# Retrieving path of the local directory
base_directory = os.path.abspath(os.path.dirname(__file__))

# Configuring SQLite database URI
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(base_directory, "db.sqlite")

# Initializing SQLAlchemy database
db = SQLAlchemy(app)
ma = Marshmallow(app)

# Creating Table Columns and constructor to initialize column data
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    contact = db.Column(db.String(100), unique=True)

    def __init__(self, name, contact):
        self.name = name
        self.contact = contact

class UserSchema(ma.Schema):
    class Meta:
        fields=('id','name','contact')

user_schema=UserSchema()            
users_schema=UserSchema(many=True)


#Creating new user details
@app.route('/users',methods=['POST'])
def add_user():
    name= request.json['name']
    contact= request.json['contact']
    new_user=User(name,contact)
    db.session.add(new_user)
    db.session.commit()
    return user_schema.jsonify(new_user)

# Getting all users
@app.route('/users',methods=['GET'])
def getAllUsers():
    all_users=User.query.all()
    results=users_schema.dump(all_users)
    return jsonify(results)

#Getting a particular user by ID
@app.route('/users/<id>',methods=['GET'])
def getUser(id):
    user=User.query.get(id)
    result=user_schema.dump(user)
    return jsonify(result)

#Updating a particular user by ID
@app.route('/users/<id>',methods=['PUT'])
def updateUser(id):
    user=User.query.get(id)
    name= request.json['name']
    contact= request.json['contact']
    user.name=name     #updating in db
    user.contact=contact
    db.session.commit()

    result=user_schema.dump(user)
    return jsonify(result)

#Delete user by ID
@app.route('/users/<id>',methods=['DELETE'])
def deleteUser(id):
    user=User.query.get(id)
    db.session.delete(user)
    db.session.commit()
    return user_schema.jsonify(user)


# Check if current module is main module, run the Flask application
if __name__ == '__main__':
    with app.app_context():
        # Create all database tables
        db.create_all()
    # Run the Flask application
    app.run(debug=True)
