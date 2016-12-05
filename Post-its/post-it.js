var Board = function( selector ) {
  // Aqui denerá ir el código que tenga que ver con tu tablero 
  
  // Utiliza esta sintaxis para referirte al selector que representa al tablero.
  // De esta manera no dependerás tanto de tu HTML.  
  var $elem = $( selector );
  
  function initialize() {
    // Que debe de pasar cuando se crea un nuevo tablero?
  };

  initialize();
};

var PostIt = function(x_pos,y_pos) {
  // Aquí va el código relacionado con un post-it
  var d = $('<div id="master" class="post-it"><div class="header"><div class="close">X</div></div><div class="content"  contenteditable="true">...</div></div>');
  d.appendTo('#board').draggable({ 
    handle: ".header",
    stack: "#master"
  });
  d.css("left", x_pos+'px');
  d.css("top", y_pos+'px');
};

$(function() {
  // Esta es la fucnión que correrá cuando este listo el DOM 
  new Board('#board');
});
// ===========================================================================
$( "#board" ).dblclick(function(event) {
  var pageX = event.pageX;
  var pageY = event.pageY;
  var target = event.target.id
  console.log(event.target);
   if(target === "board") {
    new PostIt(pageX,pageY);
   }  
  });
// =========================================================================== 
$('#board').on('click', '.close',function(){
  $(this).parent().parent().remove();
});
// ===========================================================================
