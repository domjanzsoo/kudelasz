from properties.models import Property
from rest_framework.test import APITestCase
from .mocks import test_properties
import json


class ProperyTestCase(APITestCase):
    url = '/api/properties'

    @classmethod
    def setUpTestData(cls):
        for new_property in test_properties:
            property = Property(
                name=new_property['name'],
                address=new_property['address'],
                city=new_property['city'],
                postcode=new_property['postcode'],
                offer_type=new_property['offer_type'],
                price=new_property['price']
            )
            property.save()

    def test_get_properties(self):
        response = self.client.get(self.url, {}, True)
        json_response_content = json.loads(response.content.decode('utf8').replace("'", '"'))


        self.assertEquals(response.status_code, 200)
        self.assertEquals(json_response_content['count'], len(test_properties))
        # self.assertIn(f'{self.url}?page=2', response.content.next)





