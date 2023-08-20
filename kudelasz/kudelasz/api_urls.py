from django.urls import path
from properties.views import PropertyViews

urlpatterns = [
    path('properties/', PropertyViews.as_view())
]