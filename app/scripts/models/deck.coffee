define [
  'backbone'
], (Backbone) ->
  Backbone.Model.extend
    defaults:
      owner: undefined
      name: ''
      size: 0

    url: () ->
      "/api/deck/#{@get 'id'}"