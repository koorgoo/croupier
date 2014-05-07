define [
  'marionette',
  'cs!collections/decks',
  'cs!views/search/item'
], (Marionette, DeckSet, ItemView) ->
  Marionette.CollectionView.extend
    tagName: 'ul'
    itemView: ItemView
    collection: new DeckSet [{ name: 'Simple'}]