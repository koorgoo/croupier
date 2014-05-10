define [
  'underscore'
  'marionette'
  'cs!models/card'
  'text!templates/card.html'
], (_, Marionette, Card, Template) ->
  Marionette.ItemView.extend
    model: Card

    template: _.template(Template)