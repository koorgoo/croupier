define [
  'jquery',
  'marionette',
  'cs!collections/decks'
], ($, Marionette, DeckSet) ->
  Marionette.Controller.extend
    getDeckSet: (options) ->
      options or (options = {})
      defer = $.Deferred()
      self = @

      setTimeout () ->
        deckSet = new DeckSet()
        deckSet.fetch
          data: q: options.q
          success: () ->
            self.deckSet = deckSet
            defer.resolve deckSet

      defer.promise()