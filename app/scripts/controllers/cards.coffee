define [
  'jquery'
  'underscore'
  'marionette'
  'cs!models/card'
  'cs!collections/cards'
], ($, _, Marionette, Card, CardSet) ->
  Marionette.Controller.extend
    initialize: () ->
      @cache = {}

    getDeckCards: (options) ->
      self = @
      defer = $.Deferred()
      key = options.deck.get 'id'
      cards = _.result @cache, key 

      if cards?
        setTimeout () ->
          defer.resolve cards
      else
        new CardSet(deck: options.deck).fetch
          success: (cards) ->
            self.cache[key] = cards
            defer.resolve cards

      defer.promise()

    getRandomDeckCard: (options) ->
      defer = $.Deferred()

      @getDeckCards(deck: options.deck).then (cards) ->
        defer.resolve cards.at _.random(cards.length - 1)

      defer.promise()
