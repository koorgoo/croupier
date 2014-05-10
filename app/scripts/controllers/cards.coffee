define [
  'marionette'
  'cs!collections/cards'
], (Marionette, CardSet) ->
  Marionette.Controller.extend
    initialize: (deck) ->
      @deck = deck

    random: () ->
      self = @
      defer = $.Deferred()
     
      if not @cards
        @cards = new CardSet deck: @deck
        @cards.fetch
          success: () ->
            defer.resolve self._getRandom()
      else
        setTimeout () ->
          defer.resolve self._getRandom()

      defer.promise()
      

    _getRandom: () ->
      max = @cards.length - 1
      @cards.at _.random(max)