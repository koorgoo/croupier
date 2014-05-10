define [
  'underscore'
  'marionette'
  'text!templates/layouts/application.html'
], (_, Marionette, Template) ->
  AppLayout = Marionette.Layout.extend
    el: '#home'

    template: _.template(Template)

    regions: 
      header   : '#header'
      content  : '#content'
      footer   : '#footer'

  new AppLayout()