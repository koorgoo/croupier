define [
  'underscore',
  'marionette',
  'text!templates/search/form.html'
], (_, Marionette, Template) ->
  Marionette.ItemView.extend
    tagName: 'form'
    className: 'pure-form'
    template: _.template(Template)
