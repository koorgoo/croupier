define [
  'backbone'
], (Backbone) ->
  Backbone.Model.extend
    urlRoot: '/api/deck/'

    defaults:
      owner: undefined
      name: ''
