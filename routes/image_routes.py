from flask import Blueprint, request, jsonify
from PIL import Image

from services.image_detect_service import describe_image

image_bp = Blueprint('image_routes', __name__)

@image_bp.route('/describe', methods=['POST'])
def describe():
    if 'image' not in request.files:
        return jsonify({'error': 'No image provided'}), 400

    image_file = request.files['image']
    try:
        image = Image.open(image_file.stream).convert('RGB')
        description = describe_image(image)
        return jsonify({'description': description})
    except Exception as e:
        return jsonify({'error': str(e)}), 500
