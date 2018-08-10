from flask import Blueprint, jsonify

from project.api.models import User


users_blueprint = Blueprint('users', __name__)


@users_blueprint.route('/users', methods=['GET'])
def get_all_users():
    response_object = {
        'status': 'success',
        'users': [user.to_json() for user in User.query.all()]
    }
    return jsonify(response_object), 200
