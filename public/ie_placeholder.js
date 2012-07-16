// don't need to care about input#password or input#password_confirmation, because these two elements only appear in /log_in,
// and in log_in we include a javascript file login.js, which triggers .login.click function, inside of which there are functions
// select input#password input#password_confirmation.
$(document).ready(function() {
	$('input#smb_password[type=password]').css('display','none');
	$('input#smb_password_confirmation[type=password]').css('display','none');
	$('input#smb_password[type=text]').focus(function() {
		$(this).css('display','none'); // hide
		$('input#smb_password[type=password]').css('display', ''); // show
		$('input#smb_password[type=password]').select();
	});
	$('input#smb_password_confirmation[type=text]').focus(function() {
		$(this).css('display','none'); // hide
		$('input#smb_password_confirmation[type=password]').css('display', ''); // show
		$('input#smb_password_confirmation[type=password]').select();
	});
	
	$('input[placeholder]').focus(function() {
	  var input = $(this);
	  if (input.val() == input.attr('placeholder')) {
	    input.val('');
	    input.removeClass('placeholder');
	  }
	}).blur(function() {
	  var input = $(this);
	  if (input.val() == '' || input.val() == input.attr('placeholder')) {
	    if (input.attr('id') == 'smb_password' && input.attr('type') == 'password') {
			input.css('display', 'none'); // hide
			$('input#smb_password[type=text]').css('display','').blur(); // show and initialize
			$('input#smb_password[type=text]').addClass('placeholder');
			$('input#smb_password[type=text]').val(input.attr('placeholder'));	
		} else if (input.attr('id') == 'smb_password_confirmation' && input.attr('type') == 'password') {
			input.css('display', 'none'); // hide
			$('input#smb_password_confirmation[type=text]').css('display','').blur(); // show and initialize
			$('input#smb_password_confirmation[type=text]').addClass('placeholder');
		} else {
			input.addClass('placeholder');
			input.val(input.attr('placeholder'));	
		}
	  }
	}).blur();


	$('input#pin[type=password]').css('display','none');
	$('input#pin[type=text]').focus(function() {
		$(this).css('display','none'); // hide
		$('input#pin[type=password]').css('display', ''); // show
		$('input#pin[type=password]').select();
	});
	
	$('input[placeholder]').focus(function() {
	  var input = $(this);
	  if (input.val() == input.attr('placeholder')) {
	    input.val('');
	    input.removeClass('placeholder');
	  }
	}).blur(function() {
	  var input = $(this);
	  if (input.val() == '' || input.val() == input.attr('placeholder')) {
	    if (input.attr('id') == 'pin' && input.attr('type') == 'password') {
			input.css('display', 'none'); // hide
			$('input#pin[type=text]').css('display','').blur(); // show and initialize
			$('input#pin[type=text]').addClass('placeholder');
			$('input#pin[type=text]').val(input.attr('placeholder'));	
		} else {
			input.addClass('placeholder');
			input.val(input.attr('placeholder'));	
		}
	  }
	}).blur();

});
