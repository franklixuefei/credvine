$(document).ready(function() {
	$('div.contact_button').click(function() {
		if ($('input#contact_name').val() == '' || $('input#contact_name').val() == $('input#contact_name').attr('placeholder')) {
			$('input#contact_name').parent().append('<label style="color:red">Please fill in your name</label>');
			$('input#contact_name').css('outline','1px solid red');
			setTimeout(function() {
				$('input#contact_name').parent().find('label').remove();
				$('input#contact_name').css('outline','');
			}, 700);
		} else if ($('input#contact_email').val() == '' || $('input#contact_email').val() == $('input#contact_email').attr('placeholder') || !/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test($('input#contact_email').val())) {
			$('input#contact_email').parent().append((!/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test($('input#contact_email').val()) && $('input#contact_email').val() != '')? '<label>Please fill in valid email address</label>' : '<label style="color:red">Please fill in your email address</label>');
			$('input#contact_email').css('outline','1px solid red');
			setTimeout(function() {
				$('input#contact_email').parent().find('label').remove();
				$('input#contact_email').css('outline','');
			}, 700);
		} else if ($('input#contact_subject').val() == '' || $('input#contact_subject').val() == $('input#contact_subject').attr('placeholder')) {
			$('input#contact_subject').parent().append('<label style="color:red">Please fill in your email subject</label>');
			$('input#contact_subject').css('outline','1px solid red');
			setTimeout(function() {
				$('input#contact_subject').parent().find('label').remove();
				$('input#contact_subject').css('outline','');
			}, 700);
		} else if ($('textarea#contact_message').val() == '' || $('textarea#contact_message').val() == $('textarea#contact_message').attr('placehold')) {
			$('textarea#contact_message').css('color','red').css('outline','1px solid red').val('Please fill in your email subject');
			setTimeout(function() {
				$('textarea#contact_message').css('color','').css('outline','').val('').blur();
			}, 700);
		} else {
			$('input#contact_name, input#contact_email, input#contact_subject, textarea#contact_message').attr('disabled','disabled');
			$('.contact_button').css('width','98px');
			$('.contact_button').text('SENDING...');
			$.ajax({
				url: '../../contact_send',
				data: 'contact_name=' + $('input#contact_name').val() + '&' + 'contact_email=' + $('input#contact_email').val() + '&' + 'contact_subject=' + $('input#contact_subject').val() + '&' + 'contact_message=' + $('textarea#contact_message').val(),
				dataType: 'json',
				type: 'POST',
				success: function(j) {
					if (j.ok) {
						$('input#contact_name, input#contact_email, input#contact_subject, textarea#contact_message').removeAttr('disabled');
						$('.contact_button').css('width','');
						$('.contact_button').text('SEND');
						$('input#contact_name, input#contact_email, input#contact_subject, textarea#contact_message').val('').blur();
						$('.contact_text').text('Thank you for your message.  We will get in touch shortly!');
					}
				}
			});
		}
	});
});
