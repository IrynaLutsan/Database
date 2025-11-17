from flask import request, jsonify
from app import app 
from app.my_project.service import services 

# --- CRUD для Users ---

@app.route('/users', methods=['GET'])
def get_all_users_controller():
    
    users = services.get_all_users()
    return jsonify(users) 

@app.route('/users/<int:user_id>', methods=['GET'])
def get_user_by_id_controller(user_id):
    
    user = services.get_user_by_id(user_id)
    return jsonify(user)

@app.route('/users', methods=['POST'])
def create_user_controller():
    
    data = request.json 
    user = services.create_user(data)
    return jsonify(user), 201 

@app.route('/users/<int:user_id>', methods=['PUT'])
def update_user_controller(user_id):
    
    data = request.json
    user = services.update_user(user_id, data)
    return jsonify(user)

@app.route('/users/<int:user_id>', methods=['DELETE'])
def delete_user_controller(user_id):
    
    response, status_code = services.delete_user(user_id)
    return response, status_code


@app.route('/objects/<int:object_id>', methods=['GET'])
def get_object_by_id_controller(object_id):
    
    obj_with_zones = services.get_object_by_id(object_id)

    return jsonify(obj_with_zones)

@app.route('/objects/<int:object_id>/users', methods=['GET'])
def get_users_for_object_controller(object_id):
    
    users_list = services.get_users_for_object(object_id)

    return jsonify(users_list)