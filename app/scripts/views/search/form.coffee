define [
  'cs!app',
  'underscore',
  'marionette',
  'text!templates/search/form.html'
], (app, _, Marionette, Template) ->
  Marionette.ItemView.extend
    tagName: 'form'
    
    className: 'pure-form'

    template: _.template(Template)

    events:
      'keyup input': (e) ->
        options = q: $(e.target).val()
        app.vent.trigger 'search', options
