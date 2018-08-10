from flask import Blueprint, jsonify


main_blueprint = Blueprint('main', __name__)


@main_blueprint.route('/ping', methods=['GET'])
def ping_pong():
    return jsonify({
        'status': 'success',
        'message': 'pong!'
    })
