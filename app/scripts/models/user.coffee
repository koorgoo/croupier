define [
  'backbone'
], (Backbone) ->
  window.User = Backbone.Model.extend
    defaults:
      username: ''
      email: ''

    url: '/api/user/me'