define [
  'marionette',
  'cs!views/layouts/application',
  'cs!views/search',
], (Marionette, AppLayout, SearchView) ->
  app = new Marionette.Application()

  app.addInitializer () ->
    layout = new AppLayout()
    view = new SearchView()

    layout.render()
    layout.search.show(view)

  app
