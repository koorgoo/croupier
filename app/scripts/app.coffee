define [
  'marionette',
  'cs!controllers/decks'
], (Marionette, DecksController) ->
  app = new Marionette.Application()
  contr = new DecksController()

  app.reqres.setHandler 'decks', (options) ->
    contr.getDeckSet(options)

  app
