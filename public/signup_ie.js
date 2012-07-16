$(document).ready(function() {
	$('.getstarted').hide();
	$('.login').click(function() {
		$('.login_dropdown').css('margin-right','-59px');
	});
	setTimeout(function() {
		$('input').css('outline','');
		$('.signup_notice').remove();
	});

	$(window).keydown(function(a) {
		a.keyCode==13&&$("div.getstarted").attr("id")=="active"&&(a.preventDefault(),$("input.signup_button").click())
	});
	$('input#smb_username').focus(function() {
		$(this).css('outline', '');
		$(this).parent().find('.signup_notice').remove();
		$(this).parent().find('label').show();
	});
	$('input#smb_email').focus(function() {
		$(this).css('outline', '');
		$(this).parent().find('.signup_notice').remove();
		$(this).parent().find('label').show();
	});
	$('input#smb_password').focus(function() {
		$(this).css('outline', '');
		$(this).parent().find('.signup_notice').remove();
		$(this).parent().find('label').show();
	});
	$('input#smb_password_confirmation').focus(function() {
		$(this).css('outline', '');
		$(this).parent().find('.signup_notice').remove();
		$(this).parent().find('label').show();
	});
	$('input#smb_PIN').focus(function() {
		$(this).css('outline', '');
		$(this).parent().find('.signup_notice').remove();
		$(this).parent().find('label').show();
	});
	
	
	$('input#smb_username').blur(function() {  // 
		if ($(this).val() == '' || $(this).val() == $(this).attr('placeholder') || !/^[-a-z\.\d_@]+$/.test($(this).val())) {
			$(this).css('outline', '1px solid red');
			$(this).parent().find('label').hide();
			$(this).parent().append(($(this).val() == '' || $(this).val() == $(this).attr('placeholder'))? '<label class="signup_notice">Please enter a valid username</label>' : '<label class="signup_notice">Should only contain SMALL letters, numbers, or .-_@</label>');
			$('form#new_smb').data('valid', false);
		} else {
			// now handles if taken.
			$.ajax({
				url: 'smbs/check_if_username_taken',
				data: 'username=' + $(this).val(),
				dataType: 'json',
				type: 'POST',
				success: function(j) {
					if (!j.ok) {
						$('#smb_username').css('outline','1px solid red');
						$('#smb_username').parent().find('label').hide();
						$('#smb_username').parent().append('<label class="signup_notice">Username already taken</label>');
						$('form#new_smb').data('valid', false);
					} else {
						$('#smb_username').css('outline','');
						$('#smb_username').parent().find('.signup_notice').remove();
						$('#smb_username').parent().find('label').show();
					}
				}
			});
		}
	});
	
	$('input#smb_email').blur(function() {  // 
		if ($(this).val() == '' || $(this).val() == $(this).attr('placeholder') || !/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test($(this).val())) {
			$(this).css('outline', '1px solid red');
			$(this).parent().find('label').hide();
			$(this).parent().append(($(this).val() == '' || $(this).val() == $(this).attr('placeholder'))? '<label class="signup_notice">Please specify an email address</label>' : '<label class="signup_notice">Invalid email format</label>');
			$('form#new_smb').data('valid',false);
		} else {
		// now handles if taken.
			$.ajax({
				url: 'smbs/check_if_email_taken',
				data: 'email=' + $(this).val(),
				dataType: 'json',
				type: 'POST',
				success: function(j) {
					if (!j.ok) {
						$('#smb_email').css('outline','1px solid red');
						$('#smb_email').parent().find('label').hide();
						$('#smb_email').parent().append('<label class="signup_notice">Email address already taken</label>');
						$('form#new_smb').data('valid',false);
					} else {
						$('#smb_email').css('outline','');
						$('#smb_email').parent().find('.signup_notice').remove();
						$('#smb_email').parent().find('label').show();
					}
				}
			});
		}
	});
	
	$('input#smb_password[type=password]').blur(function() {  // 
		if ($(this).val() == '' || $(this).val() == $(this).attr('placeholder')) { // maybe also add regular expression test.
			$('input#smb_password[type=text]').css('outline', '1px solid red');
			$('input#smb_password[type=text]').parent().find('label').hide();
			$('input#smb_password[type=text]').parent().append(($(this).val() == '' || $(this).val() == $(this).attr('placeholder'))? '<label class="signup_notice">Please enter a password</label>' : '<label class="signup_notice">Password not valid (length >=6 and <= 15)</label>');
			$('form#new_smb').data('valid',false);
		} else if ($(this).val().length > 15 || $(this).val().length < 6) {
			$(this).css('outline', '1px solid red');
			$(this).parent().find('label').hide();
			$(this).parent().append(($(this).val() == '' || $(this).val() == $(this).attr('placeholder'))? '<label class="signup_notice">Please enter a password</label>' : '<label class="signup_notice">Password not valid (length >=6 and <= 15)</label>');
			$('form#new_smb').data('valid',false);
		} else {
			$(this).css('outline', '');
			$(this).parent().find('.signup_notice').remove();
			$(this).parent().find('label').show();
		}
	});
	
	$('input#smb_password_confirmation[type=password]').blur(function() {  // 
		if ($(this).val() == '' || $(this).val() == $(this).attr('placeholder')) { // maybe also add regular expression test.
			$('input#smb_password_confirmation[type=text]').css('outline', '1px solid red');
			$('input#smb_password_confirmation[type=text]').parent().find('label').hide();
			$('input#smb_password_confirmation[type=text]').parent().append(($(this).val() == '' || $(this).val() == $(this).attr('placeholder'))? '<label class="signup_notice">Please enter password again</label>' : '<label class="signup_notice">Password not matching</label>');
			$('form#new_smb').data('valid',false);
		} else if ($(this).val() != $('input#smb_password').val()) {
			$(this).css('outline', '1px solid red');
			$(this).parent().find('label').hide();
			$(this).parent().append(($(this).val() == '' || $(this).val() == $(this).attr('placeholder'))? '<label class="signup_notice">Please enter password again</label>' : '<label class="signup_notice">Password not matching</label>');
			$('form#new_smb').data('valid',false);
		} else {
			$(this).css('outline', '');
			$(this).parent().find('.signup_notice').remove();
			$(this).parent().find('label').show();
		}
	});
	
	$('input#smb_PIN').blur(function() {  // 
		if ($(this).val() == '' || $(this).val() == $(this).attr('placeholder') || $(this).val().length != 4 || isNaN(parseInt($(this).val()))) { // maybe also add regular expression test.
			$(this).css('outline', '1px solid red');
			$(this).parent().find('label').hide();
			$(this).parent().append(($(this).val() == '' || $(this).val() == $(this).attr('placeholder'))? '<label class="signup_notice">Please specify a PIN</label>' : '<label class="signup_notice">PIN must be a 4-digit number</label>');
			$('form#new_smb').data('valid',false);
		} else {
			$(this).css('outline', '');
			$(this).parent().find('.signup_notice').remove();
			$(this).parent().find('label').show();
		}
	});
	
	$("input.signup_button").click(function(event) {
		signup_button = $(this);
		$('form#new_smb').data('valid', true);
		$('.signup_notice').remove();
		$('input#smb_PIN').blur();
		$('input#smb_username').blur();
		$('input#smb_email').blur();
		// if ($('input#smb_username').val() == '' || $('input#smb_username').val() == $('input#smb_username').attr('placeholder') || !/^[-\w\._@]+$/i.test($('input#smb_username').val())) {
			// $('input#smb_username').css('outline', '1px solid red');
			// $('input#smb_username').parent().append(($('input#smb_username').val() == '' || $('input#smb_username').val() == $('input#smb_username').attr('placeholder'))? '<label class="signup_notice">Please enter a valid username</label>' : '<label class="signup_notice">Should only contain letters, numbers, or .-_@</label>');
			// $('form#new_smb').data('valid', false);
		// }
		// if ($('input#smb_email').val() == '' || $('input#smb_email').val() == $('input#smb_email').attr('placeholder') || !/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test($('input#smb_email').val())) {
			// $('input#smb_email').css('outline', '1px solid red');
			// $('input#smb_email').parent().append(($('input#smb_email').val() == '' || $('input#smb_email').val() == $('input#smb_email').attr('placeholder'))? '<label class="signup_notice">Please specify an email address</label>' : '<label class="signup_notice">Invalid email format</label>');
			// $('form#new_smb').data('valid',false);
		// }
		$('input#smb_password').blur();
		$('input#smb_password_confirmation').blur();
		//check_beta_key();
		//check_promo_code();
		if (!$('form#new_smb').data('valid')) {
			event.preventDefault();
		} else {
			event.preventDefault();
			signup_button.text('CHECKING...');
			$.ajax({
				url: 'smbs/check_all',
				data: 'username=' + $('input#smb_username').val() + '&' + 'email=' + $('input#smb_email').val() + '&' + 'beta_key=' + $('input#bk').val() + '&' + 'promo_code=' + $('input#pc').val(),
				dataType: 'json', 
				type: 'POST',
				success: function (j) {
					if (j.username_ok && j.email_ok && j.betakey_ok && j.promocode_ok) {
						$('form#new_smb').submit();
					} else {
						event.preventDefault();
						signup_button.text('SIGN UP');
						if (!j.username_ok) {
							$('#smb_username').css('outline','1px solid red');
							$('#smb_username').parent().find('label').hide();
							$('#smb_username').parent().append('<label class="signup_notice">Username already taken</label>');
							$('form#new_smb').data('valid', false);
						} else {
							$('#smb_username').css('outline','');
							$('#smb_username').parent().find('.signup_notice').remove();
							$('#smb_username').parent().find('label').show();
						}
						if (!j.email_ok) {
							$('#smb_email').css('outline','1px solid red');
							$('#smb_email').parent().find('label').hide();
							$('#smb_email').parent().append('<label class="signup_notice">Email address already taken</label>');
							$('form#new_smb').data('valid',false);
						} else {
							$('#smb_email').css('outline','');
							$('#smb_email').parent().find('.signup_notice').remove();
							$('#smb_email').parent().find('label').show();
						}
						if (!j.betakey_ok) {
							alert("Beta Key is not valid or does not match the email address");
							$('form#new_smb').data('valid',false);
						} else {
							//signup_button.parent().find('.signup_notice').remove();
						}
						if (!j.promocode_ok) {
							signup_button.parent().find('label').hide();
							signup_button.parent().append('<label class="signup_notice">Promo Code is not valid.</label>');
							$('form#new_smb').data('valid',false);
						} else {
							signup_button.parent().find('.signup_notice').remove();
							signup_button.parent().find('label').show();
						}
					}
				}
			});
		}
	});
});

// function check_beta_key() {
	// $.ajax({
		// url: 'smbs/check_beta_key',
		// data: 'beta_key=' + $("input#bk").val() + '&' + 'request_email=' + $('input#smb_email').val(),
		// dataType: 'json', 
		// type: 'POST',
		// success: function (j) {
			// if (!j.ok) {
				// $('form#new_smb').data('valid', false);
				// $("input.signup_button").parent().append('<label class="signup_notice">Beta key is not valid</label>');
			// }
		// }
	// });
// }
// 
// function check_promo_code() {
	// $.ajax({
		// url: 'smbs/check_promo_code',
		// data: 'promo_code=' + $("input#pc").val(),
		// dataType: 'json', 
		// type: 'POST',
		// success: function (j) {
			// if (!j.ok) {
				// $('form#new_smb').data('valid', false);
				// $("input.signup_button").parent().append('<label class="signup_notice">Promo code is not valid</label>');
			// }
		// }
	// });
// }