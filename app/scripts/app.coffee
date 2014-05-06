define [
  'marionette',
  'cs!views/application',
], (Marionette, AppView) ->
  app = new Marionette.Application()

  app.addRegion
    pageRegion: '#page'

  app.addInitialized () ->
    view = new AppView()
    app.pageRegion.show view
