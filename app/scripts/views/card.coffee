define [
  'underscore'
  'marionette'
  'cs!models/card'
  'text!templates/card.html'
], (_, Marionette, Card, Template) ->
  Marionette.ItemView.extend
    template: _.template(Template)

    initialize: (options) ->
      @deck = options.deck
