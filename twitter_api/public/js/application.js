$(document).ready(function() {
  console.log("ready!");
  $('#frm_tweets').hide();
  $('#frm_make_tw').hide();
//==============================================================  
  $('body').on('submit','#frm_tweets',function(event){
    event.preventDefault();
    var $form = $(this)
    var cadena = $(this).serialize();
    $.post('/fetch',cadena,function(data){
      if (data) {
        $form.find('input[name="user"]').val("");
        $('#wait').html(data);
        $form.find('input[name="user"]').focus();
        //$(location).attr('href','/'+data);
      }else{
        alert("Error");
      }
    });
    $('#wait').html('<h2>Please wait...</h2>');
    $('#wait').append('<img src="/spinner.gif" height="200" width="250">');

  });
//==============================================================
$('body').on('submit','#frm_make_tw',function(event){
    event.preventDefault();
    var $form = $(this)
    var esto = $(this).find('textarea[name="tweet"]').val();
    var cadena = $(this).serialize();
    if (esto.length < 120 && esto.length > 0) {
      $.post('/tweet',cadena,function(data){
        if (data) {
          $('#wait').html("<h2>Enviado correctamente</h2>");
          $form.find('textarea[name="tweet"]').val("");
          $form.find('textarea[name="tweet"]').focus();
          tweet_is_ready(data);    
        }else{
          alert("Error making tweet");
        }
      });
      $('#wait').html('<h2>Please wait...</h2>');
      $('#wait').append('<img src="/spinner.gif" height="200" width="250">');
    }else{
      alert("Tweet between 1 and 120 characters")
    };

  }); 
//==============================================================  
  $(document).on("pageload",function(){
    alert("pageload event fired - the external page has been successfully loaded and inserted into the DOM!");
  });;
//==============================================================  
  $('body').on('click','#btn_tweets',function(event){
    $('#wait').html("");
    $('#frm_make_tw').hide();
    $('#frm_tweets').slideToggle();
  });
//============================================================== 
  $('body').on('click','#btn_make_tw',function(event){
    $('#wait').html("");
    $('#frm_tweets').hide();
    $('#frm_make_tw').slideToggle();
  });
//============================================================== 
  function tweet_is_ready(cadena) {
    var hash={};
    hash.job_id=cadena;
    $.post('/tweet_status',hash,function(data){
      if (data == "true") {
         alert("Publicado")
      }else{
        tweet_not_ready(cadena);
      };
    });
  };
//============================================================== 
  function tweet_not_ready(cadena){
    setTimeout(function(){ tweet_is_ready(cadena); }, 1000);
  };
       
//============================================================== 
});