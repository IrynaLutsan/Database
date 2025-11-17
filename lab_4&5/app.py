from flask import Flask
from app import app
from app.config.config import Config 
from app.my_project import db, ma     

app.config.from_object(Config)

db.init_app(app)
ma.init_app(app)

with app.app_context():
    from app.my_project.dao import models  
    from app.my_project.controller import controllers

if __name__ == '__main__':
    app.run(debug=True) 