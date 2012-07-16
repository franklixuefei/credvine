$(document).ready(function() {
	$('.resend_button').live('click', function() {
		$('body').prepend('<div class="mask" style="display:none"></div>');
		$('.mask').fadeIn('fast');
		$('body').prepend('<div class="feedback_container" style="display:none">'+
								  '<img src="/x_button.png" class="close_feedback">'+
								  '<div class="feedback_text">We appreciate your feedback.  We\'d love your ideas on important new features, ways to make Credvine easier to use and any other thoughts to help us make Credvine better.</div>'+
								  '<div style="margin-top: 5px;">'+
								  '<input id="feedback_name" type="text" placeholder="Name" name="feedback_name" style="width:200px">'+
								  '</div>'+
								  '<div style="margin-top: 5px;">'+
								  '<input id="feedback_email" type="email" placeholder="Email" name="feedback_email" style="width:200px">'+
								  '</div>'+
								  '<div style="margin-top: 5px;">'+
								  '<input id="feedback_subject" type="text" placeholder="Subject" name="feedback_subject" style="width:200px">'+
								  '</div>'+
								  '<div style="margin-top: 5px;">'+
								  '<textarea id="feedback_message" class="placeholder" placehold="Message" name="feedback_message" style="width:360px; height:110px; font-style:italic;">'+
								  '</textarea>'+
								  '</div>'+
								  '<div class="feedback_basic_button feedback_send_button">SEND</div>'+
								  '</div>');
		$('.feedback_container').fadeIn('fast');
		// the following resembles ie_placeholder.js, but because login_dropdown and getstarted_dropdown are appended, so need to write the following again.
			$('input[placeholder]').focus(function() { // for IE
			  var input = $(this);
			  if (input.val() == input.attr('placeholder')) {
			    input.val('');
			    input.removeClass('placeholder');
			  }
			}).blur(function() {
			  var input = $(this);
			  if (input.val() == '' || input.val() == input.attr('placeholder')) {
			  	if (input.attr('type') == 'password' && input.attr('id') == 'password') {
			  		input.css('display','none'); // hide
			  		$('input#password[type=text]').css('display','').blur(); // show and initialize
			  		$('input#password[type=text]').addClass('placeholder');
			    	$('input#password[type=text]').val(input.attr('placeholder'));	
			  	} else {
			  		input.addClass('placeholder');
			    	input.val(input.attr('placeholder'));	
			  	}
			  }
			}).blur();						
			// end of above	
			$('#feedback_message').focus(function() {
				var textarea = $(this);
				if (textarea.val() == textarea.attr('placehold')) {
					textarea.css('font-style','normal').css('color', '#66cc00');
					textarea.val('');
					textarea.removeClass('placeholder');
				}
			}).blur(function() {
				var textarea = $(this);
				if (textarea.val() == '' || textarea.val() == textarea.attr('placehold')) {
					textarea.css('font-style',''); // to make font-style in style attr disappear so that placeholder class can be added normally
				    textarea.addClass('placeholder');
				    textarea.val(textarea.attr('placehold'));
				} else {
					textarea.css('font-style','normal').css('color', '#66cc00');
				}
			}).blur();
			$('.feedback_send_button').click(function() {
				if ($('input#feedback_name').val() == '' || $('input#feedback_name').val() == $('input#feedback_name').attr('placeholder')) {
					$('input#feedback_name').parent().append('<label style="color:red">Please fill in your name</label>');
					$('input#feedback_name').css('outline','1px solid red');
					setTimeout(function() {
						$('input#feedback_name').parent().find('label').remove();
						$('input#feedback_name').css('outline','');
					}, 700);
				} else if ($('input#feedback_email').val() == '' || $('input#feedback_email').val() == $('input#feedback_email').attr('placeholder') || !/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test($('input#feedback_email').val())) {
					$('input#feedback_email').parent().append((!/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test($('input#feedback_email').val()) && $('input#feedback_email').val() != '')? '<label>Please fill in valid email address</label>' : '<label style="color:red">Please fill in your email address</label>');
					$('input#feedback_email').css('outline','1px solid red');
					setTimeout(function() {
						$('input#feedback_email').parent().find('label').remove();
						$('input#feedback_email').css('outline','');
					}, 700);
				} else if ($('input#feedback_subject').val() == '' || $('input#feedback_subject').val() == $('input#feedback_subject').attr('placeholder')) {
					$('input#feedback_subject').parent().append('<label style="color:red">Please fill in your email subject</label>');
					$('input#feedback_subject').css('outline','1px solid red');
					setTimeout(function() {
						$('input#feedback_subject').parent().find('label').remove();
						$('input#feedback_subject').css('outline','');
					}, 700);
				} else if ($('textarea#feedback_message').val() == '' || $('textarea#feedback_message').val() == $('textarea#feedback_message').attr('placehold')) {
					$('textarea#feedback_message').css('color','red').css('outline','1px solid red').val('Please fill in your email subject');
					setTimeout(function() {
						$('textarea#feedback_message').css('color','').css('outline','').val('').blur();
					}, 700);
				} else {
					$('input#feedback_name, input#feedback_email, input#feedback_subject, textarea#feedback_message').attr('disabled','disabled');
					$('.feedback_send_button').css('width','98px');
					$('.feedback_send_button').text('SENDING...');
					$.ajax({
						url: '/contact_send',
						data: 'contact_name=' + $('input#feedback_name').val() + '&' + 'contact_email=' + $('input#feedback_email').val() + '&' + 'contact_subject=' + $('input#feedback_subject').val() + '&' + 'contact_message=' + $('textarea#feedback_message').val(),
						dataType: 'json',
						type: 'POST',
						success: function(j) {
							if (j.ok) {
								$('input#feedback_name, input#feedback_email, input#feedback_subject, textarea#feedback_message').removeAttr('disabled');
								$('.feedback_send_button').css('width','');
								$('.feedback_send_button').text('SEND');
								$('input#feedback_name, input#feedback_email, input#feedback_subject, textarea#feedback_message').val('').blur();
								$('.feedback_text').html('Thanks again for your feedback! We\'re constantly working to improve Credvine, and we appreciate your suggestions.  If you\'d like to talk further, please e-mail us at <a href="mailto:elissa@credvine.com" style="text-decoration:underline;">elissa@credvine.com</a> or <a href="mailto:andrew@credvine.com" style="text-decoration:underline;">andrew@credvine.com</a>. We look forward to hearing your comments!');
								//$('.feedback_text').text('Thank you for your message.  We will get in touch shortly!');
							}
						}
					});
				}
			});
			$('.close_feedback').click(function() {
				$('.feedback_button').click();
			});
	});
});
