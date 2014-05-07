define [
  'underscore',
  'marionette',
  'text!templates/layouts/application.html'
], (_, Marionette, Template) ->
  Marionette.Layout.extend
    el: '#page'

    template: _.template(Template)

    regions: 
      search: '#search'
