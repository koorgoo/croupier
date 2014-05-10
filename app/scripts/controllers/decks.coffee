define [
  'jquery',
  'marionette',
  'cs!models/deck'
  'cs!collections/decks'
], ($, Marionette, Deck, DeckSet) ->
  DecksController = Marionette.Controller.extend
    getDeck: (options) ->
      options or (options = {})
      defer = $.Deferred()

      setTimeout () ->
        deck = new Deck id: 1
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

  new DecksController()
