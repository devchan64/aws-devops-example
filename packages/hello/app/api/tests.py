from rest_framework.test import APITestCase
from django.urls import reverse

class HelloWorldTestCase(APITestCase):
    def test_hello_endpoint(self):
        response = self.client.get("/hello")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data, {"message": "Hello, world!"})
