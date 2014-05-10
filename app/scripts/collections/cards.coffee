define [
  'backbone',
  'cs!models/card'
], (Backbone, Card) ->
  Backbone.Collection.extend
    model: Card

    initialize: (options) ->
      @deck = options.deck

    url: () ->
      "/api/deck/#{@deck.get('id')}/cards"
