from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.pagination import PageNumberPagination
from .models import Property
from .serializer import PropertySerializer
from collections import OrderedDict


class PropertyViews(APIView, PageNumberPagination):
    def get(self, request, id=None):
        self.page_size = 10

        if id:
            item = Property.objects.get(id=id)
            serializer = PropertySerializer(item)

            return Response({'status': 'success', 'data': serializer.data}, status=status.HTTP_200_OK)

        items = Property.objects.all()
        results = self.paginate_queryset(items, request, view=self)
        serializer = PropertySerializer(results, many=True, context={'request': request})

        return self.get_paginated_response(serializer.data)

    def get_paginated_response(self, data):
        return Response(OrderedDict([
            ('count', self.page.paginator.count),
            ('next', self.get_next_link()),
            ('prev', self.get_previous_link()),
            ('status_code', status.HTTP_200_OK),
            ('results', data)
        ]))
