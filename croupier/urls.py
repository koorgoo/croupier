from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()

from .views import login, logout, cards


urlpatterns = patterns('',
    # Authentication API
    url(r'api/login$', login, name='api-login'),
    url(r'api/logout$', logout, name='api-logout'),

    # Cards API
    url(r'api/cards$', cards, name='api-cards'),

    url(r'^admin/', include(admin.site.urls)),
)
