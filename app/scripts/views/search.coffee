define [
  'underscore',
  'marionette',
  'text!templates/search.html'
], (_, Marionette, Template) ->
  Marionette.ItemView.extend
    template: _.template(Template)
