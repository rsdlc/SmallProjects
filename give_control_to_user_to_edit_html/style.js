$( document ).ready(function() {
  $(this).find('input[name="selector"]').focus();
    console.log( "ready!" );

  $("body").on("submit", "#style_editor", function(event) 
  {
    event.preventDefault();
    var cadena = $(this).serialize();
    var selector = $(this).find('input[name="selector"]').val();
    var property = $(this).find('input[name="property"]').val();
    var value = $(this).find('input[name="value"]').val();
    $(selector).css(property,value);
    $(this).find('input[name="selector"]').val("");
    $(this).find('input[name="property"]').val("");
    $(this).find('input[name="value"]').val("");
    $(this).find('input[name="selector"]').focus();
  });
});