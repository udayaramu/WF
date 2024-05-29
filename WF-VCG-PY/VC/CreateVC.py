
class CreateVC(Resource): 
  
    def get(self): 
  
        return jsonify({'message': 'hello world'}) 
  
    # Corresponds to POST request 
    def post(self): 
          
        data = request.get_json()     # status code 
        return jsonify({'data': data}), 201
  
  
# another resource to calculate the square of a number 
class Home(Resource): 
  
    def get(self, num): 
  
        return jsonify({'square': num**2}) 
  
