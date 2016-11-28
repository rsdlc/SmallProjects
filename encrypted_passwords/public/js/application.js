$(document).ready(function() {
  
  $("body").on("submit", "#registerform", function(event) 
  {
    event.preventDefault();
    var cadena = $(this).serialize();
    $.post('/user/register', cadena, function(response) 
    {
      console.log(response);
      $("#homepage").html(response);
    }); 
  });

  $("body").on("submit", "#updateform", function(event) 
  {
    event.preventDefault();
    var cadena = $(this).serialize();
    $.post('/user/update', cadena, function(response) 
    {
      console.log(response);
      alert("Your information has been updated successfully");
      $("#homepage").html(response);
    }); 
  });

  $("body").on("submit", "#deleteform", function(event) 
  {
    event.preventDefault();
    var cadena = $(this).serialize();
    $.post('/user/delete', cadena, function(response) 
    {
      $("#homepage").html(response);
    }); 
  });

  $("body").on("submit", "#loginform", function(event) 
  {
    event.preventDefault();
    var cadena = $(this).serialize();
    $.post('/user/login', cadena, function(response) 
    {
      $("#homepage").html(response);
    }); 
  });


});
