import uuid
from django.db import models


class Property(models.Model):
    PROPERTY_OFFER_TYPES = [
        ('sale', 'Rental'),
        ('rent', 'For Sale')
    ]

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=30)
    address = models.CharField(max_length=255)
    city = models.CharField(max_length=30)
    country = models.CharField(max_length=30)
    postcode = models.CharField(max_length=30)
    offer_type = models.CharField(max_length=4, choices=PROPERTY_OFFER_TYPES)
    price = models.PositiveBigIntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)