from flask import Flask, jsonify, request
app = Flask(__name__)

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({"service": "Navineo-Siri-Service", "status": "online"}), 200

@app.route('/api/v1/siri/status', methods=['POST'])
def update_status():
    data = request.json
    return jsonify({"message": "Statut Siri (VM/ET/GM) mis à jour", "payload": data}), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8083)
