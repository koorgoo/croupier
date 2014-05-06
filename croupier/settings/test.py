from croupier.settings.base import *

DEBUG = False
TEMPLATE_DEBUG = DEBUG

SECRET_KEY = 'local'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': ':memory:',
    }
}

INSTALLED_APPS = INSTALLED_APPS + (
    'tests',
)

PASSWORD_HASHERS = (
    'django.contrib.auth.hashers.MD5PasswordHasher',
)
