define [
  'jquery',
  'marionette',
  'cs!collections/decks'
], ($, Marionette, DeckSet) ->
  Marionette.Controller.extend
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
