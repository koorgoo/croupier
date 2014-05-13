define [
  'jquery'
  'marionette'
  'cs!models/user'
], ($, Marionette, User) ->
  Marionette.Controller.extend
    getCurrentUser: (options) ->
      self = @
      defer = $.Deferred()

      if not @user?
        @user = new User()
        @user.fetch
          success: () ->
            defer.resolve self.user 
          error: () ->
            defer.resolve undefined
      else
        setTimeout () ->
          defer.resolve self.user

      defer.promise()