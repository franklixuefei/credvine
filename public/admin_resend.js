$(document).ready(function() {
	$('.resend_button').live('click', function() {
		var resendButton = $(this);
		$('body').prepend('<div class="mask" style="display:none"></div>');
		$('.mask').fadeIn('fast');
		$('body').prepend('<div class="resend_container" style="display:none">'+
								  '<img src="/x_button.png" class="close_resend">'+
								  '<div style="margin-top: 5px;">'+
								  '<input id="resend_subject" type="text" placeholder="Subject" name="resend_subject" style="width:300px" value="Welcome to Credvine Referrals.">'+
								  '</div>'+
								  '<div style="margin-top: 5px;">'+
								  '<input id="resend_from" type="text" placeholder="From e-mail address" name="resend_from" style="width:300px" value="Credvine Signup <signup@credvine.com>">'+
								  '</div>'+
								  '<div class="resend_text"><div class="important_paragraph">Loading...</div></div>'+ // to be AJAXed with 1st paragraph of send_invitation email
								  '<div style="margin-top: -1px;">'+
								  '<textarea id="resend_message" class="placeholder" placehold="Customizing message" name="resend_message" style="width:535px; height:150px; font-style:italic;">'+
								  'We are currently in beta, and we are excited that you\'re joining Credvine right from the start. We\'ve created a quick, easy, and seamless process for you to start building your business through quality referrals from your customers, but we\'re looking to continuously improve our product and fix any kinks, so any and all feedback will be appreciated.\nAt its core, Credvine Referrals is about people helping their friends. In fact, research shows that people would rather help out their friend and give THEM a perk than get rewarded themselves. And as business owners, we all know our customers are happy to help spread the word about our businesses; but more often than not, we just don’t have an easy way to ask for referrals.\nOur platform allows businesses to set up custom campaigns to allow friends to send recommendations to other people they know well. This means a targeted, qualified referral for your business, initiated by customers who know both the value of your business and the preferences of their friends. This isn’t attracting one-time deal-seekers who are in-and-out, but instead finds customers who are a great fit for your business and can become loyal, long-time, referring customers.\nThink about it - with Credvine Referrals, everybody wins! You get new customers, your customers get to help out their friends and get surprise rewards when their friends join you, and their friends of course get hooked up with a perk of your choosing.\nThanks for being a part of Credvine from the start. We look forward to hearing from you! And, please send any feedback to Elissa or Andrew any time.\n\nThanks!\nThe Credvine Team'+
								  '</textarea>'+
								  '</div>'+
								  '<div class="resend_basic_button resend_send_button">SEND</div>'+
								  '</div>');
		$('.resend_container').fadeIn('fast');
		$.ajax({
			url: '../pull_email_text',
			data: 'request_id=' + resendButton.parent().parent().attr('userid'),
			dataType: 'json',
			type: 'POST',
			success: function(j) {
				if (j.ok) {
					$('div.important_paragraph').text(j.importantParagraph);
				}
			}
		});
		$('.close_resend').click(function() {
			$('.mask').fadeOut('fast', function() {
				$(this).remove();
			});
			$('.resend_container').fadeOut('fast', function() {
				$(this).remove();
			});
		});
		$('input#resend_from, input#resend_subject').each(function() {
			$(this).keydown();
		});
		$('#resend_message').focus(function() {
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
			$('.resend_send_button').click(function() {
				if ($('input#resend_from').val() == '' || $('input#resend_from').val() == $('input#resend_from').attr('placeholder') ) {
					$('input#resend_from').parent().append('<label style="color:red">Please fill in the from email address</label>');
					$('input#resend_from').css('outline','1px solid red');
					setTimeout(function() {
						$('input#resend_from').parent().find('label').remove();
						$('input#resend_from').css('outline','');
					}, 700);
				} else if ($('input#resend_subject').val() == '' || $('input#resend_subject').val() == $('input#resend_subject').attr('placeholder')) {
					$('input#resend_subject').parent().append('<label style="color:red">Please fill in the email subject</label>');
					$('input#resend_subject').css('outline','1px solid red');
					setTimeout(function() {
						$('input#resend_subject').parent().find('label').remove();
						$('input#resend_subject').css('outline','');
					}, 700);
				} else if ($('textarea#resend_message').val() == '' || $('textarea#resend_message').val() == $('textarea#resend_message').attr('placehold')) {
					$('textarea#resend_message').css('color','red').css('outline','1px solid red').val('Please fill in the email content');
					setTimeout(function() {
						$('textarea#resend_message').css('color','').css('outline','').val('').blur();
					}, 700);
				} else {
					$('input#resend_from, input#resend_subject, textarea#resend_message').attr('disabled','disabled');
					$('.resend_send_button').css('width','98px');
					$('.resend_send_button').text('SENDING...');
					$.ajax({
						url: '../resend_send',
						data: 'resend_from=' + $('input#resend_from').val() + '&' + 'resend_subject=' + $('input#resend_subject').val() + '&' + 'resend_message=' + $('textarea#resend_message').val().replace(';',',') + '&' + 'request_id=' + resendButton.parent().parent().attr('userid'),
						dataType: 'json',
						type: 'POST',
						success: function(j) {
							if (j.ok) {
								$('.close_resend').click();
								resendButton.text('RESENT').css('background-color','#66cc00');
							}
						}
					});
				}
			});
			
	});
});
