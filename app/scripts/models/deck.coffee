define [
  'backbone'
], (Backbone) ->
  Backbone.Model.extend
    defaults:
      owner: undefined
      name: ''
