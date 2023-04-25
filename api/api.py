from firebase_admin import credentials, firestore, initialize_app
import json
from flask import Flask, request, jsonify

# Use a service account.
cred = credentials.Certificate('./api/key.json')
firebase_app = initialize_app(cred)
db = firestore.client()

app = Flask(__name__)                        

profiles = db.collection(u'profiles')


# Create Profile
@app.route('/profiles', methods=['POST'])
def create_profile():
    profile_id = request.json.get('ID')
    profile = profiles.document(profile_id).get()
    if profile.exists:
        return jsonify({'error' : 'profile already exists'}), 409
    else:
        profiles.document(profile_id).set(request.json)
        return jsonify(request.json), 201


# Edit Profile
@app.route('/profiles/<profile_id>', methods=['PUT'])
def edit_profile(profile_id):
    profile = profiles.document(profile_id).get()
    if not profile.exists:
        return jsonify({'error': 'profile not found'}), 404
    else:
        profile_data = request.json
        profile_data.pop('ID', None)
        profile_data.pop('name', None)
        profile_data.pop('email', None)
        profiles.document(profile_id).update(profile_data)
        updated_profile = profiles.document(profile_id).get()
        return jsonify(updated_profile.to_dict()), 200


# View Profile
@app.route('/profiles/<profile_id>', methods=['GET'])
def view_profile(profile_id):
    profile = profiles.document(profile_id).get()
    if not profile.exists:
        return jsonify({'error': 'profile not found'}), 404
    else:
        return jsonify(profile.to_dict()), 200




app.run(debug=True)