/*
 * Keep the `main` file in JavaScript to make build error message more verbose.
 */
require([
  'cs!router',
  'cs!app'
], function(router, app) {
  app.start()
});