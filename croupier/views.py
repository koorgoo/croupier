from django.contrib.auth import (authenticate, login as auth_login,
    logout as auth_logout)

from rest_framework import exceptions, generics, status
from rest_framework.authentication import SessionAuthentication
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import Card
from .serializers import UserSerializer, CardSerializer


class Login(APIView):
    def post(self, *args, **kwargs):
        u = self.request.DATA.get('username')
        p = self.request.DATA.get('password')

        user = authenticate(username=u, password=p)
        if not user:
            raise exceptions.NotAuthenticated()

        auth_login(self.request, user)
        return Response(UserSerializer(user).data)

login = Login.as_view()


class Logout(APIView):
    def get(self, *args, **kwargs):
        auth_logout(self.request)
        return Response()

logout = Logout.as_view()


class Cards(generics.ListCreateAPIView):
    queryset = Card.objects.all()
    serializer_class = CardSerializer

    def get_permissions(self):
        if not self.request.method == 'GET':
            self.permission_classes = [IsAdminUser]
        return super(Cards, self).get_permissions()

cards = Cards.as_view()
