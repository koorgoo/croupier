from croupier.settings.base import *

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'croupier.db'),
    }
}

DEBUG = True
TEMPLATE_DEBUG = DEBUG

SECRET_KEY = '@+!(k!2=60-cw40e7+sfysk5t#4jjhk1o+2@_gosfjd2gtb#b&'
