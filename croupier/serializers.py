from rest_framework import serializers

from .models import User, Deck, Card


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username', 'email')


class DeckSerializer(serializers.ModelSerializer):
    size = serializers.IntegerField(source='size', read_only=True)

    class Meta:
        model = Deck
        fields = ('id', 'owner', 'name', 'size')


class CardSerializer(serializers.ModelSerializer):
    class Meta:
        model = Card
        fields = ('id', 'deck', 'front', 'back')
