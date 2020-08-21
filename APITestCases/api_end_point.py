import requests
import json
base_url = "http://localhost:8080/api/"


def call_auth(username, password):
    try:
        url = base_url + "auth/token"
        headers = {'Content-Type': 'application/json'}
        response = requests.get(url, headers=headers, auth=(username, password))
        if response.status_code == 200:
            data = response.json()
            if data['token'] is not None:
                return data['token']
    except NameError:
        print("Something went Wrong")
    return None


def call_users(username, password):
    try:
        url = base_url + "users"
        token = call_auth(username, password)
        if token is None:
            return None
        headers = {'Content-Type': 'application/json', 'Token': token}
        response = requests.get(url, headers=headers)
        if response.status_code == 200:
            data = response.json()
            if data['status'] == 'SUCCESS':
                return True
    except NameError:
        print("Something went wrong")
    return None


def call_username_get(username, password):
    try:
        url = base_url + "users/" + username
        token = call_auth(username, password)
        if token is None:
            return None
        headers = {'Content-Type': 'application/json', 'Token': token}
        response = requests.get(url, headers=headers)
        if response.status_code == 200:
            data = response.json()
            if data['status'] == 'SUCCESS':
                payload = data['payload']
                return payload
            else:
                return None
    except NameError:
        print("Something went wrong")
    return None


def call_username_put(username, password, payload):
    try:
        url = base_url + "users/" + username
        token = call_auth(username, password)
        if token is None:
            return None
        headers = {'Content-Type': 'application/json', 'Token': token}
        response = requests.put(url, headers=headers, data=json.dumps(payload))
        # print(data)
        if response.status_code == 201:
            data = response.json()
            return data['status']
    except NameError:
        print("Something went Wrong")
    return None
