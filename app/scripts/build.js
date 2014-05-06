({
  baseUrl: '.',
  paths: {
    jquery:     'lib/jquery',
    underscore: 'lib/underscore',
    backbone:   'lib/backbone',
    marionette: 'lib/backbone.marionette',
    requireLib: 'lib/requirejs/require',
    text:       'lib/requirejs/text',
    cs:         'lib/requirejs/cs',
  },
  shim: {
    jquery: {
      exports: '$'
    },
    underscore: {
      exports: '_'
    },
    backbone: {
      deps: ['jquery', 'underscore'],
      exports: 'Backbone'
    },
    marionette: {
      deps: ['backbone'],
      exports: 'Backbone.Marionette'
    }
  },
  name: 'requireLib',
  include: ['main'],
  out: '../../croupier/static/croupier/app.js',
})
