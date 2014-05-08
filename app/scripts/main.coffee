require [
  'cs!app'
  'cs!views/layouts/application'
  'cs!views/search/form'
  'cs!views/search/list'
  'cs!router'
], (app, AppLayout, SearchView, DeckSetView) ->
  app.addInitializer () ->
    layout = new AppLayout()
    search = new SearchView()
    promise = app.request('decks')

    layout.render()
    layout.header.show(search)

    promise.done (deckSet) ->
      deckSetView = new DeckSetView collection: deckSet
      layout.content.show(deckSetView)

  app.start()
