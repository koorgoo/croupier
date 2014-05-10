define [
  'cs!app'
  'underscore'
  'marionette'
  'cs!models/deck'
  'text!templates/search/item.html'
], (app, _, Marionette, Deck, Template) ->
  Marionette.ItemView.extend
    model: Deck

    tagName: 'li'
    
    template: _.template(Template)

    events:
      'click a': (e) ->
        e.preventDefault()
        app.vent.trigger 'goto:deck', this.model

    templateHelpers:
      pluralize_card: (count) ->
        if count == 1
          'карточка'
        else if count in [2..4]
          'карточки'
        else
          'карточек'
