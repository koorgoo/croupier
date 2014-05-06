require([
  'jquery', 
  'text!templates/foo.html',
  'cs!foo'
], function($, Template) {
  $('body').text(Template);
});
