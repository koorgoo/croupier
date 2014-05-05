from django.contrib.auth import get_user_model
from django.db import models


User = get_user_model()


class Deck(models.Model):
    name = models.CharField(max_length=100)
    owner = models.ForeignKey(User, blank=False, null=True)

    def __str__(self):
        return self.name


class Card(models.Model):
    front = models.TextField()
    back = models.TextField()
    deck = models.ForeignKey(Deck, blank=False, null=True)

    def __str__(self):
        return self.front
