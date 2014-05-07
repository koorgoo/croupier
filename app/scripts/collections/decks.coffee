define [
  'backbone',
  'cs!models/deck'
], (Backbone, Deck) ->
  Backbone.Collection.extend
    model: Deck