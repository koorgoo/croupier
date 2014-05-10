define [
  'cs!app'
  'marionette'
  'cs!controllers/router'
], (app, Marionette, routerContr) ->
  router = new Marionette.AppRouter
    controller: routerContr
    appRoutes:
      ''          : 'index'
      'deck/:id'  : 'deck'

  router.listenTo app.vent, 'goto:deck', (model) ->
    url = 'deck/' + model.get('id')
    router.navigate url, { trigger: true }

  router