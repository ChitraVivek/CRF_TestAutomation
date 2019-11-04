import json
import requests
import jsonpath

def Get_Users():
    para = {'format': 'json'}
    response = requests.get('http://127.0.0.1:8080/api/users', params=para,
                            headers={
                                'Content-Type': 'application/json',
                            }
                            )
    print("1. Get all users ")
    print(response.content)
    print(response.status_code)

def Register_User():
    para = {'format': 'json', 'username': 'user1',
            'password': '1234',
            'firstname': 'Put test',
            'lastname': 'test1',
            'phone': '734873423748'
            }
    with requests.Session() as s:
        response = s.put('http://127.0.0.1:8080/api/users/',
                   headers={ 'Content-Type': 'application/json',
                             #'Authorization': 'MzMyNjQyMzAzODMwNjk1Mzg1MDU4OTA3MTEyMDM3MTQ2NDg5Mzg2',
                             'action': 'submit'}, params=para)
        print("2. Register new user")
        print(response.content)
        print(response.status_code)

def Update_User():
    data = {'username': 'user1', 'password': '1234','firstname':'Update TestName', 'lastname':'TestLastName', 'phone':'32789743927423'}
    response = requests.post('http://127.0.0.1:8080/api/users/', data=json.dumps(data),
               headers = {'Content-Type': 'application/json'}) #'Authorization': 'MzMyNjQyMzAzODMwNjk1Mzg1MDU4OTA3MTEyMDM3MTQ2NDg5Mzg2'})
    print("3. Update User details")
    print(response.content)
    print(response.status_code)


def Get_Authentication():
    param = {'username':'dest'}
    response = requests.get('http://127.0.0.1:8080/api/auth/token', data=param,
               headers = {'Content-Type': 'application/json'})
    print("4. Get Specific User details")
    print(response.content)
    print(response.status_code)

Get_Users()
Register_User()
Update_User()
Get_Authentication()
