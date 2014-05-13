define [
  'underscore'
  'marionette'
  'marked'
  'epiceditor'
  'cs!models/card'
  'text!templates/card/edit.html'
], (_, Marionette, marked, EpicEditor, Card, Template) ->
  Marionette.ItemView.extend
    model: Card

    template: _.template(Template)

    onShow: () ->
      opts = 
        basePath: '/static/croupier/css/epiceditor'
        container: @$('#epiceditor')[0]
        parser: marked
        button:
          preview: true
          fullscreen: false

      @editor = new EpicEditor(opts).load()
