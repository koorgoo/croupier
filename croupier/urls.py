from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()

from .views import cards


urlpatterns = patterns('',
    # Cards API
    url(r'api/cards$', cards, name='api-cards'),

    url(r'^admin/', include(admin.site.urls)),
)
