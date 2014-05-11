define [
  'backbone',
  'marionette',
  'cs!views/layouts/application'
  'cs!controllers/decks'
  'cs!controllers/cards'
], (Backbone, Marionette, appLayout, decksContr, cardsContr) ->
  app = new Marionette.Application()


  ### Request Handlers ###

  app.reqres.setHandler 'deck', (options) ->
    decksContr.getDeck(options)

  app.reqres.setHandler 'decks', (options) ->
    decksContr.getDeckSet(options)

  app.reqres.setHandler 'randomDeckCard', (options) ->
    cardsContr.getRandomDeckCard(options)


  ### Initializers ###

  app.addInitializer () ->
    appLayout.render()

  app.addInitializer () ->
    Backbone.history.start
      pushState: true
      root: '/'

  app
