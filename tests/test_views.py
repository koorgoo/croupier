from django.core.urlresolvers import reverse
from django.test import TestCase

from rest_framework import status
from rest_framework.test import APIClient

from croupier.models import User, Deck, Card


class TestCase(TestCase):
    def setUp(self):
        self.client = APIClient()
        kwargs = dict(username='admin', password='admin', email='admin@test.com')
        self.admin = User.objects.create_superuser(**kwargs)
        self.user = User.objects.create_user(username='user', password='user')
        self.deck = Deck.objects.create(name='test')
        self.card = Card.objects.create(deck=self.deck, front='one', back='two')

    def login(self):
        self.client.login(username='user', password='user')

    def login_admin(self):
        self.client.login(username='admin', password='admin')


class ApiAuthTests(TestCase):
    url = reverse('api-login')

    def test_no_credentials(self):
        self.client.logout()
        resp = self.client.post(self.url, data={})
        assert resp.status_code == status.HTTP_400_BAD_REQUEST

    def test_empty_credentials(self):
        self.client.logout()
        data = {'username': '', 'password': ''}
        resp = self.client.post(self.url, data=data)
        assert resp.status_code == status.HTTP_400_BAD_REQUEST

    def test_login(self):
        self.client.logout()
        data = {'username': 'admin', 'password': 'admin'}
        resp = self.client.post(self.url, data=data)
        assert resp.status_code == status.HTTP_200_OK
        assert resp.data['username'] == 'admin'

    def test_logout(self):
        self.login()
        resp = self.client.get(reverse('api-logout'))
        assert resp.status_code == status.HTTP_200_OK



class ApiMeTest(TestCase):
    url = reverse('api-me')

    def test_cannot_retrieve_unauthed(self):
        resp = self.client.get(self.url)
        assert resp.status_code == status.HTTP_403_FORBIDDEN

    def test_retrieve_authed(self):
        self.login()
        resp = self.client.get(self.url)
        assert resp.status_code == status.HTTP_200_OK
        assert resp.data['username'] == 'user'


class ApiDecksTest(TestCase):
    url = reverse('api-decks')

    def test_retrieve_decks(self):
        resp = self.client.get(self.url)
        assert resp.status_code == status.HTTP_200_OK
        assert len(resp.data) == 1

    def test_retrieve_filtered_decks(self):
        Deck.objects.create(name='Super Mega Deck')
        resp = self.client.get(self.url, data=dict(q='mega'))
        assert resp.status_code == status.HTTP_200_OK
        assert len(resp.data) == 1

    def test_unauthed_cannot_create_deck(self):
        resp = self.client.post(self.url, data=dict(name='foo'))
        assert resp.status_code == status.HTTP_403_FORBIDDEN

    def test_authed_cannot_create_deck(self):
        self.login()
        resp = self.client.post(self.url, data=dict(name='foo'))
        assert resp.status_code == status.HTTP_403_FORBIDDEN

    def test_admin_can_create_deck(self):
        self.login_admin()
        resp = self.client.post(self.url, data=dict(name='foo'))
        assert resp.status_code == status.HTTP_201_CREATED
        assert resp.data['owner'] == self.admin.id


class ApiDeckTests(TestCase):
    url = reverse('api-deck', kwargs={'pk': 1})

    def test_retrieve_deck(self):
        resp = self.client.get(self.url)
        assert resp.status_code == status.HTTP_200_OK
        assert resp.data['id'] == self.deck.id
        assert resp.data['size'] == self.deck.size

    def test_unauthed_cannot_update_deck(self):
        resp = self.client.patch(self.url, data={'name': 'bar'})
        assert resp.status_code == status.HTTP_403_FORBIDDEN

    def test_authed_cannot_update_deck(self):
        self.login()
        resp = self.client.patch(self.url, data={'name': 'bar'})
        assert resp.status_code == status.HTTP_403_FORBIDDEN

    def test_admin_can_update_deck(self):
        self.login_admin()
        resp = self.client.patch(self.url, data={'name': 'bar'})
        assert resp.status_code == status.HTTP_200_OK

    def test_unauthed_cannot_delete_deck(self):
        resp = self.client.delete(self.url)
        assert resp.status_code == status.HTTP_403_FORBIDDEN

    def test_authed_cannot_delete_deck(self):
        self.login()
        resp = self.client.delete(self.url)
        assert resp.status_code == status.HTTP_403_FORBIDDEN

    def test_admin_can_delete_deck(self):
        self.login_admin()
        resp = self.client.delete(self.url)
        assert resp.status_code == status.HTTP_204_NO_CONTENT


class ApiDeckCardsTests(TestCase):
    url = reverse('api-deck-cards', kwargs={'pk': 1})

    def test_retrieve_cards(self):
        resp = self.client.get(self.url)
        assert resp.status_code == status.HTTP_200_OK

    def test_unauthed_cannot_create_card(self):
        resp = self.client.post(self.url, data=dict(front='x', back='y'))
        assert resp.status_code == status.HTTP_403_FORBIDDEN

    def test_authed_cannot_create_card(self):
        self.login()
        resp = self.client.post(self.url, data=dict(front='x', back='y'))
        assert resp.status_code == status.HTTP_403_FORBIDDEN

    def test_admin_can_create_card(self):
        self.login_admin()
        resp = self.client.post(self.url, data=dict(front='x', back='y'))
        assert resp.status_code == status.HTTP_201_CREATED
        assert resp.data['deck'] == self.deck.id


class ApiCardTests(TestCase):
    url = reverse('api-card', kwargs={'pk': 1})

    def test_retrieve_card(self):
        resp = self.client.get(self.url)
        assert resp.status_code == status.HTTP_200_OK

    def test_unauthed_cannot_update_card(self):
        resp = self.client.patch(self.url, data=dict(front='new'))
        assert resp.status_code == status.HTTP_403_FORBIDDEN

    def test_authed_cannot_update_card(self):
        self.login()
        resp = self.client.patch(self.url, data=dict(front='new'))
        assert resp.status_code == status.HTTP_403_FORBIDDEN

    def test_admin_can_update_card(self):
        self.login_admin()
        resp = self.client.patch(self.url, data=dict(front='new'))
        assert resp.status_code == status.HTTP_200_OK

    def test_unauthed_cannot_delete_card(self):
        resp = self.client.delete(self.url)
        assert resp.status_code == status.HTTP_403_FORBIDDEN

    def test_authed_cannot_delete_card(self):
        self.login()
        resp = self.client.delete(self.url)
        assert resp.status_code == status.HTTP_403_FORBIDDEN

    def test_admin_can_delete_card(self):
        self.login_admin()
        resp = self.client.delete(self.url)
        assert resp.status_code == status.HTTP_204_NO_CONTENT
