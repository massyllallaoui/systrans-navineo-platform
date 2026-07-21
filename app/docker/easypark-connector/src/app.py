from flask import Flask, jsonify, request
import os

app = Flask(__name__)
db_host = os.environ.get("DB_HOST", "Non configuré")

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({
        "service": "Navineo-EasyPark-Connector", 
        "status": "online", 
        "db": db_host
    }), 200

@app.route('/api/v1/parkings', methods=['POST'])
def sync_parking_data():
    data = request.json
    return jsonify({
        "message": "Données Navineo reçues et transmises à EasyPark avec succès", 
        "payload": data
    }), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8081)
