define [
  'cs!app'
  'cs!controllers/router'
  'marionette'
], (app, routerController, Marionette) ->
  router = new Marionette.AppRouter
    controller: routerController
    appRoutes:
      'deck/:id': 'openDeck'

  router.listenTo app.vent, 'goto:deck', (id) ->
    router.navigate 'deck/'+id, { trigger: true }
