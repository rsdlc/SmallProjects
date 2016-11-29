$(document).ready(function() 
{
  $('#commentform').hide();

  $("body").on("click", "#new_comment_button", function(event) 
  {
    $('#commentform').slideToggle();
    $('#commentform').find('textarea[name="comentario"]').focus();
  });

  $("body").on("submit", "#commentform", function(event) 
  {
    event.preventDefault();
    var cadena = $(this).serialize();
      $.post('/comment/new',cadena,function(data)
      {       
         if (data) {
          alert('Your comment was saved successfully')
         }else{
          console.log(data)
          alert("We are sorry, but your comment wasn't saved successfully. Try again.")
         };
      });
    var comentario = $(this).find('textarea[name="comentario"]').val();
    var autor = $(this).find('input[name="autor"]').val();
    console.log(comentario)
    console.log(autor)
    $('#comment_list').append('<li>'+comentario+'<span class="author">'+autor+'</span></li>');
    $('#commentform')[0].reset();
    $('#commentform').slideToggle();
  }); 
});