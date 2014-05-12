from django.contrib import admin

from .models import Deck, Card


class CardAdmin(admin.ModelAdmin):
    search_fields = ('front', 'back')
    list_display = ('front', 'deck')
    list_filter = ('deck__name',)


admin.site.register(Deck)
admin.site.register(Card, CardAdmin)
