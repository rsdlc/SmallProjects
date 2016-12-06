$(document).ready(function() {
  var counter = 1;
var Board = function( selector ) {
  // Aqui denerá ir el código que tenga que ver con tu tablero 
  
  // Utiliza esta sintaxis para referirte al selector que representa al tablero.
  // De esta manera no dependerás tanto de tu HTML.  
  var selector = $(this.selector);
  
  function initialize() {
    // Que debe de pasar cuando se crea un nuevo tablero?
  };

  initialize();
};

var PostIt = function(x_pos,y_pos,target) {
  // Aquí va el código relacionado con un post-it
  var d = $('<div id="master" class="post-it"><div class="header"><div class="close">X</div></div><div class="content"  contenteditable="true">...</div></div>');
  d.appendTo('#board'+target).draggable({ 
    handle: ".header",
    stack: "#master"
  });
  d.css("left", x_pos+'px');
  d.css("top", y_pos+'px');
};

$(function() {
  // Esta es la fucnión que correrá cuando este listo el DOM 
  new Board('.board');
});
// ===========================================================================
$( "body" ).dblclick(".board",function(event) {
  var pageX = event.offsetX;
  var pageY = event.offsetY;
  var target2 = event.target.id;
  var lastChar = target2.substr(target2.length - 1);
  var target = event.target.className;
  console.log(lastChar);
   if(target === "board") {
    new PostIt(pageX,pageY,lastChar);
   }  
  });
// =========================================================================== 
$('body').on('click', '.close',function(){
  $(this).parent().parent().remove();
});
// ===========================================================================
function newBoard() {
  var boardName = prompt("Enter a name for the new board", "New Board");
  if (boardName != null) {
    $("<button id='boardbtn"+counter+"'>"+boardName+"</div>").appendTo('#leftmenu');
    var selector = $("<div class='board' id='board"+counter+"'></div>");
    selector.appendTo('body');
    counter++;
    hideBoards(selector);
  }else if (boardName == ""){
    alert("You need to specify a name for your new board!")
    newBoard();
  }
};
// ===========================================================================
function hideBoards(selector){
  $(".board").each(function(){
    $(this).hide();
  }); 
  selector.show();
}
// ===========================================================================
$('body').on('click','#newboardbtn', function(){
  newBoard();
})
// ===========================================================================
$("body").on('click',"button[id^='boardbtn']", function(){
  console.log($(this).attr("id"));
  var choice = $(this).attr("id")
  switch(choice) {
    case "boardbtn1":
        hideBoards($("#board1"))
        break;
    case "boardbtn2":
        hideBoards($("#board2"))
        break;
    case "boardbtn3":
        hideBoards($("#board3"))
        break;
    case "boardbtn4":
        hideBoards($("#board4"))
        break;
  }
});
// ===========================================================================
// ===========================================================================
});

