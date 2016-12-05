
$(document).ready(function() {

  var numbers = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
 
  for ( var i=0; i<10; i++ ) {
    number(i).attr( 'id', 'card'+numbers[i] ).appendTo( '#cardPile' ).draggable( {
      containment: '#content',
      cursor: 'move',
      helper: "clone",
      revert: true
    });
  };

  var calcnumbers = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'];
  for ( var i=1; i<=10; i++ ) {
    $('<div></div>').data( 'number', i ).appendTo( '#cardSlots' ).droppable( {
      accept: '#cardPile div',
      hoverClass: 'hovered',
      tolerance: 'pointer',
      drop: handleDropEvent
    });
  }

  function handleDropEvent(event, ui) {
    var droppable = $(this);
    var draggable = ui.draggable;
    draggable.clone().position( { of: $(this), my: 'left top', at: 'left top' } );
    console.log(draggable.data("number"));
    var current = parseInt($('#total_sum').text());
    var totalsum = current + draggable.data("number")
    $('#total_sum').html(totalsum);
    droppable.html(draggable.data("number"));
  };

  function number(num) {
    return $('<div>' + num + '</div>').data( 'number', num );
  };

});