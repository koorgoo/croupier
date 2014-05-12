define [
  'marked',
  'underscore'
  'marionette'
  'cs!models/card'
  'text!templates/card.html'
], (marked, _, Marionette, Card, Template) ->
  Marionette.ItemView.extend
    tagName: 'p'

    className: 'card'

    template: _.template(Template)

    ui:
      back: '.back'

    initialize: (options) ->
      @deck = options.deck

    onShow: () ->
      @ui.back.hide()

    showBack: () ->
      @ui.back.show()

    serializeData: () ->
      data = @model.toJSON()
      data['front'] = marked(data['front'])
      data['back'] = marked(data['back'])
      data