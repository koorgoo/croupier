define [
  'backbone',
  'marionette',
  'cs!controllers/decks'
], (Backbone, Marionette, DecksController) ->
  app = new Marionette.Application()
  contr = new DecksController()

  app.reqres.setHandler 'decks', (options) ->
    contr.getDeckSet(options)

  app.addInitializer () ->
    Backbone.history.start
      pushState: true
      root: '/'

  app
