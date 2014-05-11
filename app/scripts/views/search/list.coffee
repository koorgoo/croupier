define [
  'cs!app',
  'marionette',
  'cs!collections/decks',
  'cs!views/search/item'
], (app, Marionette, DeckSet, ItemView) ->
  Marionette.CollectionView.extend
    tagName: 'ul'
    itemView: ItemView
    initialize: () ->
      self = @
      @listenTo app.vent, 'search', (options) ->
        app.request('decks', q: options.q).done (deckSet) ->
          self.collection = deckSet
          self.render()
