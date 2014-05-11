define [
  'underscore'
  'marionette'
  'cs!models/card'
  'text!templates/card.html'
], (_, Marionette, Card, Template) ->
  Marionette.ItemView.extend
    tagName: 'p'

    className: 'card'

    template: _.template(Template)

    ui:
      back: '.back'

    initialize: (options) ->
      @deck = options.deck

    showBack: () ->
      @ui.back.show()
