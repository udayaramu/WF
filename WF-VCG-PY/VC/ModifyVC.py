from flask import Flask, jsonify, request 
from flask_restful import Resource, Api

class Home(Resource): 
  
    def get(self): 
  
        return jsonify({'Available apis are': ['CreateVC','ModifyVC','CancelVC','FindVC']}) 
  
