define [
  'backbone'
], (Backbone) ->
  Backbone.Model.extend
    defaults:
      deck: undefined
      front: ''
      back: ''
