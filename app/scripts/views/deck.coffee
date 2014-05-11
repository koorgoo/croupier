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
