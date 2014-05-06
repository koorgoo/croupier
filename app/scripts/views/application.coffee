define [
  'marionette', 
  'text!templates/application.html'
], (Backbone, Template) ->
  Marionette.ItemView.extend
    template: Template
    render: () ->
      @$el.html(@template)
      @
