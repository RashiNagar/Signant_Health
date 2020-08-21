import unittest
import api_end_point as api


class User:
    def __init__(self, username, password, info):
        self.username = username
        self.password = password
        self.user_info = info


class ApiTestCase(unittest.TestCase):
    user1 = User('apiuser', 'test@123', {'firstname': 'Test', 'lastname': 'Api', 'phone': '45672389'})

    def test_api_auth(self):
        result = api.call_auth(self.user1.username, self.user1.password)
        flag = False
        if result is not None:
            flag = True
        self.assertEqual(flag, True)

    def test_api_users(self):
        result = api.call_users(self.user1.username, self.user1.password)
        flag = False
        if result is not None:
            flag = True
        self.assertEqual(flag, True)

    def test_api_username_get(self):
        result = api.call_username_get(self.user1.username, self.user1.password)
        self.assertEqual(result, self.user1.user_info)

    def test_api_username_put(self):
        result = api.call_username_put(self.user1.username, self.user1.password, self.user1.user_info)
        self.assertEqual(result, 'SUCCESS')


if __name__ == '__main__':
    unittest.main()
