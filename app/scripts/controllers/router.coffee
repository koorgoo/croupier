define [
  'cs!app'
  'cs!views/layouts/application'
  'cs!views/search/form'
  'cs!views/search/list'
  'cs!views/deck'
], (app, layout, SearchView, DeckSetView, DeckView) ->
  index: () ->
    layout.header.show new SearchView()
    layout.content.reset()

    app.request('decks').done (deckSet) ->
      layout.content.show new DeckSetView(collection: deckSet)

  deck: (id) ->
    layout.header.reset()
    layout.content.reset()

    options = id : id
    app.request('deck', options).done (deck) ->
      layout.content.show new DeckView(model: deck)
