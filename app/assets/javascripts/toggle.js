$(document).ready(function(){
//Hide the tooglebox when page load
$(".togglebox").hide();
//slide up and down when click over heading 2
$("h2.toggle#t1").click(function(){
// slide toggle effect set to slow you can set it to fast too.
$(this).next(".togglebox#tb1").slideToggle("slow");
$("a#1").text($(this).text() == 'Show Templates' ? 'Hide Templates' : 'Show Templates'); 
return true;
});


$("strong.toggle#t11").click(function(){
// slide toggle effect set to slow you can set it to fast too.
$(this).next(".togglebox#tb11").slideToggle("fast");
$(this).next(".togglebox#tb11").children(".content").css("width","300").css("padding", "10px").css("padding-top", "0px");
$(this).next(".togglebox#tb11").css("background-color", "#fff").css("width","300");
//$("a#11").text($(this).text() == 'Show Templates' ? 'Hide Templates' : 'Show Templates'); 
return true;
});

$("strong.toggle#t12").click(function(){
// slide toggle effect set to slow you can set it to fast too.
$(this).next(".togglebox#tb12").slideToggle("fast");
$(this).next(".togglebox#tb12").children(".content").css("width","500").css("padding", "10px").css("padding-top", "0px");
$(this).next(".togglebox#tb12").css("background-color", "#fff").css("width","500");
//$("a#12").text($(this).text() == 'Show Templates' ? 'Hide Templates' : 'Show Templates'); 
return true;
});


$("strong.toggle#t13").click(function(){
// slide toggle effect set to slow you can set it to fast too.
$(this).next(".togglebox#tb13").slideToggle("fast");
$(this).next(".togglebox#tb13").children(".content").css("width","500").css("padding", "10px").css("padding-top", "0px");
$(this).next(".togglebox#tb13").css("background-color", "#fff").css("width","500");
//$("a#13").text($(this).text() == 'Show Templates' ? 'Hide Templates' : 'Show Templates'); 
return true;
});


$("h2.toggle#t2").click(function(){
// slide toggle effect set to slow you can set it to fast too.
$(this).next(".togglebox#tb2").slideToggle("slow");
$("a#2").text($(this).text() == 'Show Templates' ? 'Hide Templates' : 'Show Templates'); 
return true;
});

$("strong.toggle#t21").click(function(){
// slide toggle effect set to slow you can set it to fast too.
$(this).next(".togglebox#tb21").slideToggle("fast");
$(this).next(".togglebox#tb21").children(".content").css("width","300").css("padding", "10px").css("padding-top", "0px");
$(this).next(".togglebox#tb21").css("background-color", "#fff").css("width","300");
//$("a#21").text($(this).text() == 'Show Templates' ? 'Hide Templates' : 'Show Templates'); 
return true;
});

$("strong.toggle#t22").click(function(){
// slide toggle effect set to slow you can set it to fast too.
$(this).next(".togglebox#tb22").slideToggle("fast");
$(this).next(".togglebox#tb22").children(".content").css("width","300").css("padding", "10px").css("padding-top", "0px");
$(this).next(".togglebox#tb22").css("background-color", "#fff").css("width","300");
//$("a#22").text($(this).text() == 'Show Templates' ? 'Hide Templates' : 'Show Templates'); 
return true;
});


$("strong.toggle#t23").click(function(){
// slide toggle effect set to slow you can set it to fast too.
$(this).next(".togglebox#tb23").slideToggle("fast");
$(this).next(".togglebox#tb23").children(".content").css("width","300").css("padding", "10px").css("padding-top", "0px");
$(this).next(".togglebox#tb23").css("background-color", "#fff").css("width","300");
//$("a#23").text($(this).text() == 'Show Templates' ? 'Hide Templates' : 'Show Templates'); 
return true;
});


$("h2.toggle#t3").click(function(){
// slide toggle effect set to slow you can set it to fast too.
$(this).next(".togglebox#tb3").slideToggle("slow");
$("a#3").text($(this).text() == 'Show Templates' ? 'Hide Templates' : 'Show Templates'); 
return true;
});

$("strong.toggle#t31").click(function(){
// slide toggle effect set to slow you can set it to fast too.
$(this).next(".togglebox#tb31").slideToggle("fast");
$(this).next(".togglebox#tb31").children(".content").css("width","500").css("padding", "10px").css("padding-top", "0px");
$(this).next(".togglebox#tb31").css("background-color", "#fff").css("width","500");
//$("a#31").text($(this).text() == 'Show Templates' ? 'Hide Templates' : 'Show Templates'); 
return true;
});

$("strong.toggle#t32").click(function(){
// slide toggle effect set to slow you can set it to fast too.
$(this).next(".togglebox#tb32").css("background-color", "#fff").css("width","500");
$(this).next(".togglebox#tb32").children(".content").css("width","500").css("padding", "10px").css("padding-top", "0px");
$(this).next(".togglebox#tb32").slideToggle("fast");
//$("a#32").text($(this).text() == 'Show Templates' ? 'Hide Templates' : 'Show Templates'); 
return true;
});


$("strong.toggle#t33").click(function(){
// slide toggle effect set to slow you can set it to fast too.
$(this).next(".togglebox#tb33").slideToggle("fast");
$(this).next(".togglebox#tb33").children(".content").css("width","500").css("padding", "10px").css("padding-top", "0px");
$(this).next(".togglebox#tb33").css("background-color", "#fff").css("width","500");
//$("a#33").text($(this).text() == 'Show Templates' ? 'Hide Templates' : 'Show Templates'); 
return true;
});


// $("h2.toggle#t4").click(function(){
// // slide toggle effect set to slow you can set it to fast too.
// $(this).next(".togglebox#tb4").slideToggle("slow");
// $("a#4").text($(this).text() == 'Show Advance' ? 'Hide Advance' : 'Show Advance'); 
// return true;
// });
});