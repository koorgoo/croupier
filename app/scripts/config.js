requirejs.config({
  paths: {
    jquery:     'lib/jquery',
    underscore: 'lib/underscore',
    backbone:   'lib/backbone',
    marionette: 'lib/backbone.marionette',
    coffee:     'lib/coffee-script',
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
  stubModules: ['cs', 'text'],
  exclude: ['coffee'],
  name: 'requireLib',
  include: ['main']
});
