from flask import Flask, jsonify, request
import os

app = Flask(__name__)
db_host = os.environ.get("DB_HOST", "Non configuré")

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({
        "service": "Navineo-Filexis-Connector", 
        "status": "online", 
        "db": db_host
    }), 200

@app.route('/api/v1/files', methods=['POST'])
def sync_files():
    data = request.json
    return jsonify({
        "message": "Fichier Navineo transmis à Filexis avec succès", 
        "payload": data
    }), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8082)
