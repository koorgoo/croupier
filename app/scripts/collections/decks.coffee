define [
  'backbone',
  'cs!models/deck'
], (Backbone, Deck) ->
  Backbone.Collection.extend
    url: '/api/decks'
    model: Deck