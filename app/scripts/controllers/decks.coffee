define [
  'jquery',
  'marionette',
  'cs!models/deck'
  'cs!collections/decks'
], ($, Marionette, Deck, DeckSet) ->
  Marionette.Controller.extend
    getDeck: (options) ->
      defer = $.Deferred()

      setTimeout () ->
        deck = new Deck id: options.id
        deck.fetch
          success: () ->
            defer.resolve deck

      defer.promise()

    getDeckSet: (options) ->
      options or (options = {})
      defer = $.Deferred()

      setTimeout () ->
        deckSet = new DeckSet()
        deckSet.fetch
          data: q: options.q
          success: () ->
            defer.resolve deckSet

      defer.promise()
