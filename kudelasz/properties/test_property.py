from django.test import Client, TestCase
from properties.models import Property


class ProperyTestCase(TestCase):
    test_properties = [
        {
            'name': 'Building 1',
            'address': '23  Test Street',
            'city': 'Frankfurt',
            'postcode': '3334',
            'offer_type': 'rent',
            'price': 657
        },
        {
            'name': 'Building 2',
            'address': '90  Test Avenue',
            'city': 'Antwerp',
            'postcode': '3rfewr',
            'offer_type': 'rent',
            'price': 990
        },
        {
            'name': 'Building 3',
            'address': '01  Test Boulevard',
            'city': 'Budapest',
            'postcode': '33432324',
            'offer_type': 'sale',
            'price': 90000
        }
    ]

    def setup(self):
        self.client = Client(headers={"user-agent": "curl/7.79.1"})

        for new_property in self.test_properties:
            Property.objects.create(new_property)

    def test_get_properties(self):
        response = self.client.get('/properties', {}, True)
        print(response.data)
        self.assertEquals(response.status_code, 200)
        # self.assertEqual(len(response.data), 2)





