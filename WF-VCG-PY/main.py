from flask import Flask, request, jsonify
from flask_restful import Resource, Api
from sys import argv
#import VC.CreateVC
#import VC.Home

# creating a Flask app 
app = Flask(__name__) 
# creating an API object 
api = Api(app, catch_all_404s=True) #,
      #title="WF Virtual Card API's Gateway",
      #descrition="WellsOne Virtual Card REST API gateway to create/modify/cancel Virtyual Cards generated for Commercial Customers")

class Home(Resource): 
    def get(self): 
        return jsonify({'Available apis are': ['CreateVC','ModifyVC','CancelVC','FindVC']}) 
  
class CreateVCAPI(Resource): 
  
    def get(self, num): 
        return jsonify({'message': 'hello world', 'data': num}) 
  
    # Corresponds to POST request 
    def post(self): 
          
        data = request.get_json()     # status code 
        return jsonify({'data': data}), 201


# adding the defined resources along with their corresponding urls 
api.add_resource(Home, '/vcg') 
api.add_resource(CreateVCAPI, '/vcg/create/<string:num>')
api.add_resource(CreateVCAPI, '/vcg/modify/<string:num>')  
api.add_resource(CreateVCAPI, '/vcg/cancel/<string:num>')  

# driver function 
if __name__ == '__main__': 
    app.run(debug = True, port=2024)
