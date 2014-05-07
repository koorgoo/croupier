define [
  'marionette',
  'cs!views/layouts/application',
  'cs!views/search/form',
  'cs!views/search/list'
], (Marionette, AppLayout, SearchView, DeckListView) ->
  app = new Marionette.Application()

  app.addInitializer () ->
    layout = new AppLayout()
    search = new SearchView()
    decks = new DeckListView()

    layout.render()
    layout.header.show(search)
    layout.content.show(decks)

  app
