var slider_img = new Array('/credvine_home_slider01.png', '/credvine_home_slider02.png', '/credvine_home_slider03.png', '/credvine_home_slider04.png', '/credvine_home_slider05.png');
var slider_counter = 0;
var slider_width = 596;
var slider_sliding = false;
var slider_counter_final;
var sliding_time = 1000;
var offset = 1;
var autoscroll = true;
var pause_time = 7000;
$(document).ready(function () {
	// $('.white_button').click(function(event) {
		// alert("show the demo overlay");
	// });
	$('span.slider_content').find('img').attr('src', slider_img[slider_counter]);
	$('div.slider_main').hover(function () {
		autoscroll = false;
	}, function () {
		autoscroll = true;
	});
	autoslide();
	$('.arrow#forward').click(function (event) {
		event.stopPropagation();
		if (slider_sliding) return;
		slider_sliding = true;
		slider_counter++;
		if (slider_counter > 4) slider_counter = 0;	
		$('div.square').attr('id','');
		$('div.square[slide=' + slider_counter + ']').attr('id','active');
		$('span.slider_content').append('<img class="newslide" style="left:' + slider_width + 'px;" />');
		$('span.slider_content').find('img.newslide').attr('src', slider_img[slider_counter]);
		$('span.slider_content').find('img:first').animate({ left: -1 * slider_width}, sliding_time, function () {
			$(this).remove();
			slider_sliding = false;
		});
		$('img.newslide').animate({ left: 0}, sliding_time, function () {
			$(this).removeClass('newslide');
			
		});
	});
	$('.arrow#back').click(function (event) {
		event.stopPropagation();
		if (slider_sliding) return;
		slider_sliding = true;
		slider_counter--;
		if (slider_counter < 0) slider_counter = 4;
		$('div.square').attr('id','');
		$('div.square[slide=' + slider_counter + ']').attr('id','active');
		$('span.slider_content').prepend('<img class="newslide" style="left:' + -1 * slider_width + 'px;" />');
		$('span.slider_content').find('img.newslide').attr('src', slider_img[slider_counter]);
		$('span.slider_content').find('img:last').animate({ left: slider_width}, sliding_time, function () {
			$(this).remove();
			slider_sliding = false;
		});
		$('img.newslide').animate({ left: 0}, sliding_time, function () {
			$(this).removeClass('newslide');
		});
	});
	$('div.square').attr('id','');
	$('div.square[slide=' + slider_counter + ']').attr('id','active');
	$('div.square').click(function() {
		if (slider_sliding) return;
		slider_sliding = true;
		$('div.square').attr('id','');
		$(this).attr('id','active');
		slider_counter_final = parseInt($(this).attr('slide'));
		$('span.slider_content').find('img:first').attr('class','oldslide').attr('id',slider_counter).attr('style','left:0px;');
		if (slider_counter < slider_counter_final) {
			for (var i = slider_counter+1; i <= slider_counter_final; i++) {
				if (i == slider_counter_final) {
					$('span.slider_content').append('<img class="newslide" id=' + i + ' style="left:' + offset * slider_width + 'px;" />');
				} else {
					$('span.slider_content').append('<img class="oldslide" id=' + i + ' style="left:' + offset * slider_width + 'px;" />');
				}
				$('span.slider_content').find('img#' + i).attr('src', slider_img[i]);
				//alert(i);
				offset++;
			}
			$('span.slider_content').find('img').animate({ left: '+=' + -1 * (slider_counter_final - slider_counter) *slider_width }, sliding_time, function () {
				$('span.slider_content').find('img.oldslide').remove();
				slider_sliding = false;
				$('img.newslide').removeClass('newslide').attr('id','');
			});
			slider_counter = slider_counter_final;
			offset = 1; // restore offset;
		} else if (slider_counter > slider_counter_final) {
			for (var i = slider_counter-1; i >= slider_counter_final; i--) {
				if (i == slider_counter_final) {
					$('span.slider_content').prepend('<img class="newslide" id=' + i + ' style="left:' + (-1 * offset * slider_width) + 'px;" />');
				} else {
					$('span.slider_content').prepend('<img class="oldslide" id=' + i + ' style="left:' + (-1 * offset * slider_width) + 'px;" />');
				}
				$('span.slider_content').find('img#' + i).attr('src', slider_img[i]);
				//alert(i);
				offset++;
			}
			$('span.slider_content').find('img').animate({ left: '+=' + (slider_counter - slider_counter_final) *slider_width }, sliding_time, function () {
				$('span.slider_content').find('img.oldslide').remove();
				slider_sliding = false;
				$('img.newslide').removeClass('newslide').attr('id','');
			});
			slider_counter = slider_counter_final;
			offset = 1; // restore offset;
		} else {
			slider_sliding = false;
		}
	});
	$(window).keydown(function(event) {
		if (event.which == 37) {
			$('.arrow#back').click();
		} else if (event.which == 39) {
			$('.arrow#forward').click();
		}
	});
	
	
	$('.black_button').click(function() {
		current_button = $(this);
		if (current_button.attr('sent') != 'sent') {
			if ($("input.request_invite").val() == '' || !/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test($("input.request_invite").val())) {
				current_button.text(($("input.request_invite").val() == '' || $("input.request_invite").val() == $("input.request_invite").attr('placeholder'))? 'Email required' : 'Invalid email');
				$("input.request_invite").css('outline', '1px solid red');
				//$(this).css('margin-left','8px');
				setTimeout(function () {
					current_button.text('Request an invite');
					$("input.request_invite").css('outline', '');
				}, 1000);
			} else {
				$(this).text("Sending request...");
				$(".invitation_container").find('form').append("<img src='/loading.gif' style='float: right;'/>");
				$.ajax({
					url: '../../invite',
					data: 'request_email=' + $("input.request_invite").val() + '&' + 'package_type=' + current_button.attr('id'),
					dataType: 'json', 
					type: 'POST',
					success: function (j) {
						if (j.ok) {
							$('input.request_invite').attr('disabled','disabled');
							current_button.text("Request sent!");
							current_button.attr('sent','sent');
							$(".invitation_container").find('img').remove();
						} else {
							$(".invitation_container").find('img').remove();
							$("input.request_invite").css('outline', '1px solid red');
							current_button.text("Email requested");
							setTimeout(function () {
								current_button.text('Request an invite');
								$("input.request_invite").css('outline', '');
							}, 1000);
						}
					}
				});
			}
		}
	});
});

function autoslide() {
	if (autoscroll) {
		$('.arrow#forward').click();
	} 
	setTimeout("autoslide()", pause_time);
}
