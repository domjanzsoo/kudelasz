from rest_framework import serializers
from .models import Property

class PropertySerializer(serializers.HyperlinkedModelSerializer):
    name = serializers.CharField(max_length=30)
    address = serializers.CharField(max_length=255)
    city = serializers.CharField(max_length=30)

    class Meta:
        model = Property
        fields = ['name', 'address', 'city', 'country', 'postcode', 'offer_type']