define [
  'marionette',
  'cs!views/application',
], (Marionette, AppView) ->
  app = new Marionette.Application()

  app.addRegions
    pageRegion: '#page'

  app.addInitializer () ->
    view = new AppView()
    app.pageRegion.show(view)

  app
