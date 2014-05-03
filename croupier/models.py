from django.contrib.auth import get_user_model
from django.db import models


User = get_user_model()


class Card(models.Model):
    front = models.TextField()
    back = models.TextField()
