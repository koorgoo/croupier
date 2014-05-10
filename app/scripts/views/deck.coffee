define [
  'cs!app',
  'underscore'
  'marionette'
  'cs!models/deck'
  'text!templates/deck.html'
  'cs!controllers/cards'
  'cs!views/card'
], (app, _, Marionette, Deck, Template, DeckCardsContr, CardView) ->
    Marionette.Layout.extend
      model: Deck

      template: _.template(Template)

      regions:
        cardRegion: '#card'

      events:
        'click a': (e) ->
          e.preventDefault()
          app.vent.trigger 'goto:index'

      initialize: () ->
        @cardsContr = new DeckCardsContr @model

      onShow: () ->
        self = @
        if @hasCards()
          @cardsContr.random().done (card) ->
            self.cardRegion.show new CardView model: card
        else 
          self.$('#card').text 'No cards'

      hasCards: () ->
        @model.get('size') > 0