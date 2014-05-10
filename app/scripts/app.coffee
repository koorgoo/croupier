define [
  'backbone',
  'marionette',
  'cs!controllers/decks'
    'cs!views/layouts/application',
], (Backbone, Marionette, decksContr, appLayout) ->
  app = new Marionette.Application()

  app.reqres.setHandler 'deck', (options) ->
    decksContr.getDeck(options)

  app.reqres.setHandler 'decks', (options) ->
    decksContr.getDeckSet(options)

  app.addInitializer () ->
    appLayout.render()

  app.addInitializer () ->
    Backbone.history.start
      pushState: true
      root: '/'

  app
