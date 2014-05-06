requirejs.config({
  paths: {
    jquery                : 'lib/jquery',
    underscore            : 'lib/underscore',
    backbone              : 'lib/backbone',
    'backbone.babysitter' : 'lib/backbone.babysitter',
    'backbone.wreqr'      : 'lib/backbone.wreqr',
    marionette            : 'lib/backbone.marionette',
    requireLib            : 'lib/requirejs/require',
    text                  : 'lib/requirejs/text',
    cs                    : 'lib/requirejs/cs',
    'coffee-script'       : 'lib/coffee-script',
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
      deps: [
        'jquery',
        'underscore',
        'backbone',
        'backbone.babysitter',
        'backbone.wreqr'
      ],
      exports: 'Backbone.Marionette'
    }
  },
  stubModules: ['cs', 'text'],
  exclude: ['coffee-script'],
  name: 'requireLib',
  include: ['main']
});
