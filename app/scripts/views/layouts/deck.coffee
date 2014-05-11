define [
  'cs!app'
  'underscore'
  'marionette'
  'text!templates/layouts/deck.html'
  'cs!views/deck'
  'cs!views/card'
], (app, _, Marionette, Template, DeckView, DeckCardView) ->
    Marionette.Layout.extend
      template: _.template(Template)

      regions:
        deckRegion: '#deck'
        cardRegion: '#card'

      events:
        'click #next': 'nextCard'
        'click a': (e) ->
          e.preventDefault()
          app.vent.trigger 'goto:index'

      initialize: (options) ->
        @deck = options.deck

      onShow: () ->
        @deckRegion.show new DeckView model: @deck
        @nextCard()

      nextCard: (e) ->
        self = @
        e.preventDefault() if e
        app.request('randomDeckCard', deck: @deck).done (card) ->
          self.cardRegion.show new DeckCardView model: card, deck: self.deck