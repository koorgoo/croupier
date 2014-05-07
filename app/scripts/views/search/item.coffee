define [
  'underscore',
  'marionette',
  'cs!models/deck',
  'text!templates/search/item.html'
], (_, Marionette, Deck, Template) ->
  Marionette.ItemView.extend
    tagName: 'li'
    template: _.template(Template)
    model: Deck
