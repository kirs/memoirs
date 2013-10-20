Handlebars.registerHelper("join", function( array, sep, options ) {
  return array.map(function( item ) {
    return options.fn( item );
  }).join( sep );
});