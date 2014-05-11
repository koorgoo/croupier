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
        'click #next'    : 'nextCard'
        'click #answer'  : 'showAnswer'
        'click a': (e) ->
          e.preventDefault()
          app.vent.trigger 'goto:index'

      initialize: (options) ->
        @deck = options.deck

      onShow: () ->
        @deckView = new DeckView model: @deck
        @deckRegion.show @deckView
        @nextCard()

      nextCard: () ->
        self = @
        app.request('randomDeckCard', deck: @deck).done (card) ->
          self.cardView = new DeckCardView model: card, deck: self.deck
          self.cardRegion.show self.cardView

      showAnswer: () ->
        @cardView?.showBack()