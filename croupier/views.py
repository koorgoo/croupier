from rest_framework import exceptions, generics
from rest_framework.permissions import IsAdminUser

from .models import Card
from .serializers import CardSerializer


class Cards(generics.ListCreateAPIView):
    queryset = Card.objects.all()
    serializer_class = CardSerializer

    def get_permissions(self):
        if not self.request.method == 'GET':
            self.permission_classes = [IsAdminUser]
        return super(Cards, self).get_permissions()

cards = Cards.as_view()
