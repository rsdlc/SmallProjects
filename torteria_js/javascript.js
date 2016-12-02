$( document ).ready(function() {
  $('#historyform').hide();
  var interval;
// ===================================================
  $('body').on('submit','#ovenform',function(event){
      event.preventDefault();
      $('#ovenform').hide();
      $('.oven').css("visibility","visible");
      $('#historyform').show();
  });
// ===================================================
  $('body').on('submit','#cook',function(event){
      event.preventDefault();
      var type = $(this).children()[0].value
      var time = $(this).children()[1].value
      torta(type,time);
      finalstatus = status(type,time);
      $('#cook')[0].reset();
  });
});
// ===================================================
function torta(type,time) {
  var mytime = time;
  var newTime = parseInt(time);
  var cookTime = 0;
  interval = setInterval(function(){
    bake(type,newTime,cookTime);
    cookTime = cookTime + 1;
    newTime  = newTime - 1;
  }, 1000);
};
// ===================================================
function bake(type,time,cooktime) {
  if (time >= 0) {
    console.log(status(type,cooktime));
    $('#countdown').html(time);
    $('#status').html(status(type,cooktime));
    $('#timer').attr("class",status(type,cooktime));
  }
  else {
    $('#history').append("<li>"+type+"-"+status(type,cooktime-1)+"</li>");
    clearInterval(interval);
  };
};
// ===================================================
function bakeTimer(type) {
  var bakeTime = 0;
  switch(type) {
    case "jamon":
        bakeTime = 3
        break;
    case "queso":
        bakeTime = 8
        break;
    case "milanesa":
        bakeTime = 10      
  };
  return bakeTime;
};
// ===================================================
function status(type,time) {
  var estado = "";
  var cooktime = time/bakeTimer(type);
  switch(true) {
    case (cooktime < 0.5):
        estado = "CRUDO"
        break;
    case (cooktime < 1.0):
        estado = "CASI-LISTO"
        break;
    case (cooktime == 1.0):
        estado = "LISTO"
        break;
    case (cooktime > 1.0):
        estado = "QUEMADO"
        break;       
  };
  return estado;
};
// ===================================================


