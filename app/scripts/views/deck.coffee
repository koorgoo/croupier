define [
  'underscore'
  'marionette'
  'cs!models/deck'
  'text!templates/deck.html'
], (_, Marionette, Deck, Template) ->
    Marionette.ItemView.extend
      model: Deck

      template: _.template(Template)
