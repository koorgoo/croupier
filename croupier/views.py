from django.contrib.auth import (authenticate, login as auth_login,
    logout as auth_logout)

from rest_framework import exceptions, generics, status
from rest_framework.authentication import SessionAuthentication
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import Deck, Card
from .serializers import UserSerializer, DeckSerializer, CardSerializer


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


class DeckList(generics.ListCreateAPIView):
    model = Deck
    serializer_class = DeckSerializer

    def pre_save(self, deck):
        deck.owner = self.request.user

    def get_permissions(self):
        if not self.request.method == 'GET':
            self.permission_classes = [IsAdminUser]
        return super(DeckList, self).get_permissions()

decks = DeckList.as_view()


class DeckDetail(generics.RetrieveUpdateDestroyAPIView):
    model = Deck
    serializer_class = DeckSerializer

    def get_permissions(self):
        if not self.request.method == 'GET':
            self.permission_classes = [IsAdminUser]
        return super(DeckDetail, self).get_permissions()

deck = DeckDetail.as_view()


class DeckCardList(generics.ListCreateAPIView):
    serializer_class = CardSerializer

    def get_deck(self):
        return Deck.objects.get(pk=self.kwargs['pk'])

    def pre_save(self, card):
        card.deck = self.get_deck()

    def get_queryset(self):
        return self.get_deck().card_set.all()

    def get_permissions(self):
        if not self.request.method == 'GET':
            self.permission_classes = [IsAdminUser]
        return super(DeckCardList, self).get_permissions()

deck_cards = DeckCardList.as_view()


class CardDetail(generics.RetrieveUpdateDestroyAPIView):
    model = Card
    serializer_class = CardSerializer

    def get_permissions(self):
        if not self.request.method == 'GET':
            self.permission_classes = [IsAdminUser]
        return super(CardDetail, self).get_permissions()

card = CardDetail.as_view()
