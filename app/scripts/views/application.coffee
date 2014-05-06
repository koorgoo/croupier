define [
  'marionette',
  'text!templates/application.html'
], (Marionette, Template) ->
  Marionette.ItemView.extend
    template: Template
    render: () ->
      @$el.html(@template)
      @
