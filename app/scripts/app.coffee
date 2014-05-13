define [
  'backbone'
  'marionette'
  'cs!views/layouts/application'
  'cs!controllers/user'
  'cs!controllers/decks'
  'cs!controllers/cards'
], (Backbone, Marionette, appLayout, UserController, DecksController, DeckCardsController) ->
  app = new Marionette.Application()

  userContr = new UserController()
  decksContr = new DecksController()
  cardsContr = new DeckCardsController()

  ### Request Handlers ###

  app.reqres.setHandler 'user', (options) ->
    userContr.getCurrentUser(options)

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
      hashChange: true
      root: '/'

  app
