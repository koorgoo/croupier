from django.core.urlresolvers import reverse
from django.test import TestCase

from rest_framework import status
from rest_framework.test import APIClient

from croupier.models import User, Card


class TestCase(TestCase):
    def setUp(self):
        self.client = APIClient()
        kwargs = dict(username='admin', password='admin', email='admin@test.com')
        self.admin = User.objects.create_superuser(**kwargs)
        self.user = User.objects.create_user(username='user', password='user')
        self.card = Card.objects.create(front='one', back='two')

    def login(self):
        self.client.login(username='user', password='user')

    def login_admin(self):
        self.client.login(username='admin', password='admin')


class AuthAPITests(TestCase):
    def test_login_fails(self):
        data = {'username': '', 'password': ''}
        resp = self.client.post(reverse('api-login'), data=data)
        assert resp.status_code == status.HTTP_403_FORBIDDEN

    def test_login(self):
        data = {'username': 'admin', 'password': 'admin'}
        resp = self.client.post(reverse('api-login'), data=data)
        assert resp.status_code == status.HTTP_200_OK
        # TODO: check logged-in user is admin

    def test_logout(self):
        resp = self.client.get(reverse('api-logout'))
        assert resp.status_code == status.HTTP_200_OK
        # TODO: check logged-in user is anonymous


class CardsAPITests(TestCase):
    def test_unauthed_can_retrieve_cards(self):
        resp = self.client.get(reverse('api-cards'))
        assert resp.status_code == status.HTTP_200_OK
        assert len(resp.data) == 1

    def test_authed_can_retrieve_cards(self):
        self.login()
        resp = self.client.get(reverse('api-cards'))
        assert resp.status_code == status.HTTP_200_OK
        assert len(resp.data) == 1

    def test_admin_can_retrieve_cards(self):
        self.login_admin()
        resp = self.client.get(reverse('api-cards'))
        assert resp.status_code == status.HTTP_200_OK
        assert len(resp.data) == 1

    def test_unauthed_cannot_create_card(self):
        before = Card.objects.count()
        resp = self.client.post(reverse('api-cards'), data=dict(front='three', back='four'))
        assert resp.status_code == status.HTTP_403_FORBIDDEN
        assert Card.objects.count() == before

    def test_authed_cannot_create_card(self):
        self.login()
        before = Card.objects.count()
        resp = self.client.post(reverse('api-cards'), data=dict(front='three', back='four'))
        assert resp.status_code == status.HTTP_403_FORBIDDEN
        assert Card.objects.count() == before

    def test_admin_can_create_card(self):
        self.login_admin()
        before = Card.objects.count()
        resp = self.client.post(reverse('api-cards'), data=dict(front='three', back='four'))
        assert resp.status_code == status.HTTP_201_CREATED
        assert Card.objects.count() == before + 1
