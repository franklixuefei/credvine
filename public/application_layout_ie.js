$(document).ready(function() {
 	$('body').click(function(event) {
			if ($("div.login").attr("id")=="active" && $(".login_dropdown").attr("hovered")=="false") $("div.login").click();
			if ($("div.getstarted").attr("id")=="active" && $(".getstarted_dropdown").attr("hovered")=="false") $("div.getstarted").click();
			if ($("div.settings").attr("id")=="active" && $(".settings_dropdown").attr("hovered")=="false") $("div.settings").click();
	});
	$(window).scroll(function(){
     	if ($(this).scrollTop() > 100) {
            $('.to_top').fadeIn();
        } else {
            $('.to_top').fadeOut();
        }
    }).scroll();
 
    $('.to_top').click(function(){
        $("html, body").animate({ scrollTop: 0 }, 600);
        return false;
    });
	$('.getstarted').click(function(e) {
		e.stopPropagation();
		if ($('div.login').attr('id')=='active') $('div.login').click();
		if ($("div.getstarted").attr("id")!="active") {
			$(".header_nav").append('<div class="getstarted_dropdown" hovered="false" >' +
									'<form id="new_smb" class="new_smb" method="post" action="/smbs" accept-charset="UTF-8">' +
									'<div style="margin:0;padding:0;display:inline">' +
									'<input type="hidden" value="✓" name="utf8">' +
									'<input type="hidden" value="6AHzx5PbBR6dN9kN3/WtUyN8jaLRBcpmo9r5Qh7cHzw=" name="authenticity_token">' +
									'</div>' +
									'<div class="field">' +
									'<input id="smb_username" type="text" size="30" placeholder="Username" name="smb[username]" style="width: 156px;"><br/>' +
									'</div>' +
									'<div class="field">' +
									'<input id="smb_email" type="email" size="30" placeholder="Email" name="smb[email]" style="width: 156px;"><br/>' +
									'</div>' +
									'<div class="field">' +
									'<input id="smb_password" type="text" value="" autocomplete="off" placeholder="Password" style="width: 156px;">'+
									'<input id="smb_password" type="password" value="" autocomplete="off" placeholder="Password" name="smb[password]" style="display:none;width: 156px;"><br/>'+
									'</div>'+
									'<div class="field">'+
									'<input id="smb_password_confirmation" type="text" placeholder="Password confirmation" style="width: 156px;">'+
									'<input id="smb_password_confirmation" type="password" name="smb[password_confirmation]" placeholder="Password confirmation" style="display:none;width: 156px;"><br/>'+
									'</div>'+
									'<div class="actions" style="margin-bottom: 0px;">'+
									'<input class="signup_button" type="submit" value="SIGN UP" name="commit" style="margin-bottom: 10px;">'+
									'</div>'+
									'</form>'+
									'<label class="signup_notice"></label>' +
									'</div>');
									
			// the following is for beta use. When go out of beta just COMMENT them out.
			 $('.signup_notice').css('color','#999999').css('font-size','10px').text('SIGN-UP IS CLOSED DURING BETA');
			 $('input.signup_button').css('font-family','CalcitePro-Bold').val('Request an invite');
			 $('input#smb_password, input#smb_password_confirmation, input#smb_username').attr('disabled','disabled');
			 $('.signup_button').click(function(event) {
			 	event.preventDefault();
			 	if ($(this).attr('sent') != 'sent') {
					if ($("input#smb_email").val() == '' || !/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test($("input#smb_email").val())) {
						$(this).val(($("input#smb_email").val() == '' || $("input#smb_email").val() == $("input#smb_email").attr('placeholder'))? 'Email required' : 'Invalid email');
						$("input#smb_email").css('outline', '1px solid red');
						//$(this).css('margin-left','8px');
						setTimeout(function () {
							$('.signup_button').val('Request an invite');
							$("input#smb_email").css('outline', '');
						}, 1200);
					} else {
						$(this).val("Sending request...");
						$.ajax({
							url: '/welcome/invite',
							data: 'request_email=' + $("input#smb_email").val() + '&' + 'package_type=small',
							dataType: 'json', 
							type: 'POST',
							success: function (j) {
								if (j.ok) {
									$('input#smb_email').attr('disabled','disabled');
									$('.signup_button').val("Request sent!");
									$('.signup_button').attr('sent','sent');
								} else {
									$("input#smb_email").css('outline', '1px solid red');
									$('.signup_button').val('Email requested');
									setTimeout(function () {
										$('.signup_button').val('Request an invite');
										$("input#smb_email").css('outline', '');
									}, 1200);
								}
							}
						});
					}
				}
			 });
			 
			 // end of the above						
									
									
									
			// the following resembles ie_placeholder.js, but because login_dropdown and getstarted_dropdown are appended, so need to write the following again.
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
			$('input[placeholder]').focus(function() { // for IE
			  var input = $(this);
			  if (input.val() == input.attr('placeholder')) {
			    input.val('');
			    input.removeClass('placeholder');
			  }
			}).blur(function() {
			  var input = $(this);
			  if (input.val() == '' || input.val() == input.attr('placeholder')) {
			  	if (input.attr('type') == 'password' && input.attr('id') == 'smb_password') {
			  		input.css('display','none'); // hide
			  		$('input#smb_password[type=text]').css('display','').blur(); // show and initialize
			  		$('input#smb_password[type=text]').addClass('placeholder');
			    	$('input#smb_password[type=text]').val(input.attr('placeholder'));
			    } else if (input.attr('type') == 'password' && input.attr('id') == 'smb_password_confirmation') {
			    	input.css('display','none'); // hide
			    	$('input#smb_password_confirmation[type=text]').css('display','').blur(); // show and initialize
			  		$('input#smb_password_confirmation[type=text]').addClass('placeholder');
			    	$('input#smb_password_confirmation[type=text]').val(input.attr('placeholder'));
			  	} else {
			  		input.addClass('placeholder');
			    	input.val(input.attr('placeholder'));	
			  	}
			  }
			}).blur();						
			// end of above
				
			$(window).keydown(function(a) {
				a.keyCode==13&&$("div.getstarted").attr("id")=="active"&&(a.preventDefault(),$("input.signup_button").click())
			});
			$("div.getstarted").attr("id","active");
			$(".getstarted_dropdown").hover(function(){ 
				$(this).attr("hovered","true")
			}, function() {
				$(this).attr("hovered","false")
			});
			
			// when go out of beta, just UNCOMMENT them.
			
			// $("input#smb_username[type=text]").select();
			// //$("input.signup_button").click(function(event) {
			// // the following handles what will happen when user focuses the fields
			// $('input#smb_username').focus(function() {
				// $(this).css('outline', '');
			// });
			// $('input#smb_email').focus(function() {
				// $(this).css('outline', '');
			// });
			// $('input#smb_password[type=password]').focus(function() {
				// $(this).css('outline', '');
			// });
			// $('input#smb_password_confirmation[type=password]').focus(function() {
				// $(this).css('outline', '');
			// });
			// // the following are handlers.
			// $('input#smb_username').blur(function() {  // 
				// if ($(this).val() == '' || $(this).val() == $(this).attr('placeholder') || !/^[-\w\._@]+$/i.test($(this).val())) {
					// $(this).css('outline', '1px solid red');
					// $('.signup_notice').text(($(this).val() == '' || $(this).val() == $(this).attr('placeholder'))? 'Please enter a valid username' : 'Should only contain letters, numbers, or .-_@');
					// $('form#new_smb').data('valid', false);
				// } else {
					// // now handles if taken.
					// $.ajax({
						// url: '/smbs/check_if_username_taken',
						// data: 'username=' + $(this).val(),
						// dataType: 'json',
						// type: 'POST',
						// success: function(j) {
							// if (!j.ok) {
								// $('#smb_username').css('outline','1px solid red');
								// $('.signup_notice').text('Username already taken');
								// $('form#new_smb').data('valid', false);
							// } else {
								// $('#smb_username').css('outline','');
								// $('.signup_notice').text('');
							// }
						// }
					// });
				// }
			// });
			// $('input#smb_email').blur(function() {  // 
				// if ($(this).val() == '' || $(this).val() == $(this).attr('placeholder') || !/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test($(this).val())) {
					// $(this).css('outline', '1px solid red');
					// $('.signup_notice').text(($(this).val() == '' || $(this).val() == $(this).attr('placeholder'))? 'Please enter a valid email' : 'Invalid email address');
					// $('form#new_smb').data('valid',false);
				// } else {
					// // now handles if taken.
					// $.ajax({
						// url: '/smbs/check_if_email_taken',
						// data: 'email=' + $(this).val(),
						// dataType: 'json',
						// type: 'POST',
						// success: function(j) {
							// if (!j.ok) {
								// $('#smb_email').css('outline','1px solid red');
								// $('.signup_notice').text('Email already taken');
								// $('form#new_smb').data('valid',false);
							// } else {
								// $('#smb_email').css('outline','');
								// $('.signup_notice').text('');
							// }
						// }
					// });
				// }
			// });
			// $('input#smb_password[type=password]').blur(function() {  // 
				// if ($(this).val() == '' || $(this).val() == $(this).attr('placeholder') || $(this).val().length > 15 || $(this).val().length < 6) { // maybe also add regular expression test.
					// $('input#smb_password').css('outline', '1px solid red');
					// $('.signup_notice').text(($(this).val() == '' || $(this).val() == $(this).attr('placeholder'))? 'Please enter a password' : 'Password not valid (length >=6 and <= 15)');
					// $('form#new_smb').data('valid',false);
				// } else {
					// $('input#smb_password').css('outline', '');
					// $('.signup_notice').text('');
				// }
			// });
			// $('input#smb_password_confirmation[type=password]').blur(function() {  // 
				// if ($(this).val() == '' || $(this).val() == $(this).attr('placeholder') || $(this).val() != $('input#smb_password[type=password]').val()) { // maybe also add regular expression test.
					// $('input#smb_password_confirmation').css('outline', '1px solid red');
					// $('.signup_notice').text(($(this).val() == '' || $(this).val() == $(this).attr('placeholder'))? 'Please enter password again' : 'Password not matching');
					// $('form#new_smb').data('valid',false);
				// } else {
					// $('input#smb_password_confirmation').css('outline', '');
					// $('.signup_notice').text('');
				// }
			// });
			// $("input.signup_button").click(function(event) {
				// event.stopPropagation();
				// $('form#new_smb').data('valid', true);
				// $('input#smb_username').blur();
				// $('input#smb_email').blur();
				// $('input#smb_password[type=password]').blur();
				// $('input#smb_password_confirmation[type=password]').blur();
				// if (!$('form#new_smb').data('valid')) {
					// event.preventDefault();
					// $('.signup_notice').text('Some fields are not valid');
				// } else {
					// $('form#new_smb').submit();
				// }
			// });
			
			// END OF THE ABOVE
			
		} else {
  			$(".getstarted_dropdown").remove();
  			$("div.getstarted").attr("id","");
  		}
	});
	
	$('.settings').click(function(e) {
		e.stopPropagation();
		if ($("div.settings").attr("id")!="active") {
			$(".header_nav").find(".settings_dropdown").css('display', ''); // show the dropdown
			$("div.settings").attr("id","active");
			$(".settings_dropdown").hover(function(){ 
				$(this).attr("hovered","true")
			}, function() {
				$(this).attr("hovered","false")
			});
		} else {
  			$(".settings_dropdown").css('display','none'); // hide
  			$("div.settings").attr("id","");
  		}
	});
	
	$('.user_dropdown#change_pin').live('click', function() {
		$('body').append(
			'<div class="mask" style="display:none"></div>'
		).append(
			'<div class="change_pin_container" style="display:none">'+
			'<img class="close_change" src="/x_button.png">'+
			'<div class="field" style="margin-bottom:10px">'+
			'<input type="text" id="new_pin" name="new_pin" style="width:250px" placeholder="Enter a new 4-digit PIN">'+
			'</div>'+
			'<div class="field" style="margin-bottom:10px">'+
			'<input type="password" id="pin_password" name="pin_password" style="width:250px;display:none" placeholder="Please enter you password">'+
			'</div>'+
			'<div class="field" style="margin-bottom:10px">'+
			'<input type="text" id="pin_password" style="width:250px" placeholder="Please enter you password">'+
			'</div>'+
			'<div style="padding-top:15px">'+
			'<button class="change_pin_button" id="change">CHANGE</button>'+
			'<button class="change_pin_button" style="float:right" id="cancel">CANCEL</button>'+
			'</div>'+
			'</div>'
		);
		// the following resembles ie_placeholder.js, but because login_dropdown and getstarted_dropdown are appended, so need to write the following again.
			$('input#pin_password[type=text]').focus(function() {
				$(this).css('display','none'); // hide
				$('input#pin_password[type=password]').css('display', ''); // show
				$('input#pin_password[type=password]').select();
			});
			$('input[placeholder]').focus(function() { // for IE
			  var input = $(this);
			  if (input.val() == input.attr('placeholder')) {
			    input.val('');
			    input.removeClass('placeholder');
			  }
			}).blur(function() {
			  var input = $(this);
			  if (input.val() == '' || input.val() == input.attr('placeholder')) {
			  	if (input.attr('type') == 'password' && input.attr('id') == 'pin_password') {
			  		input.css('display','none'); // hide
			  		$('input#pin_password[type=text]').css('display','').blur(); // show and initialize
			  		$('input#pin_password[type=text]').addClass('placeholder');
			    	$('input#pin_password[type=text]').val(input.attr('placeholder'));	
			  	} else {
			  		input.addClass('placeholder');
			    	input.val(input.attr('placeholder'));	
			  	}
			  }
			}).blur();						
			// end of above	
		$('.mask').fadeIn('fast');
		$('.change_pin_container').fadeIn('fast');
		$('.close_change, .change_pin_button#cancel').click(function() {
			$('.mask').fadeOut('fast', function() {
				$(this).remove();
			});
			$('.change_pin_container').fadeOut('fast', function() {
				$(this).remove();
			});
		});
		$('.change_pin_button#change').click(function() {
			var container = $(this).parent().parent();
			container.find('div').css('display','none'); // hide all divs
			container.css('height', '110px');
			container.append(
				'<div style="text-align:center;margin-top:30px"><img src="/loading.gif"/></div>'
			);
			$.ajax({
				url: '/smbs/'+ user_token +'/change_pin',
				data: 'new_pin=' + $("input#new_pin[name=new_pin]").val() + '&' + 'pin_password='+$("input#pin_password[name=pin_password]").val(),
				dataType: 'json', 
				type: 'POST',
				success: function (j) {
					if (j.ok) {
						container.find('div').remove();
						container.append(
							'<div style="text-align:center;margin-top:20px;font-size:20px;line-height:30px;">PIN has been updated successfully</div>'
						);
						setTimeout(function() {
							$('.close_change').click();
						},1500);
					} else {
						container.css('height','');
						$('div#loading_container').remove();
						$('input#new_pin, input#pin_password').val('').blur();
						container.find('div').css('display',''); // show previous divs
						$('input#pin_password').css('outline','1px solid red');
						$('input#pin_password').parent().append(
							'<label id="error_msg" style="color:red">Incorrect password</label>'
						);
						setTimeout(function() {
							$('label#error_msg').remove();
							$('input#pin_password').css('outline', '');
						}, 1000);
					}
				}
			});
		});
	});
	
	$('.user_dropdown#change_password').live('click', function() {
		$('body').append(
			'<div class="mask" style="display:none"></div>'
		).append(
			'<div class="change_password_container" style="display:none">'+
			'<img class="close_change" src="/x_button.png">'+
			'<div class="field" style="margin-bottom:10px">'+
			'<input id="old_password" type="password" name="old_password" style="width:250px;display:none;">'+
			'</div>'+
			'<div class="field" style="margin-bottom:10px">'+
			'<input id="old_password" type="text" style="width:250px" placeholder="Please enter your old password">'+
			'</div>'+
			'<div class="field" style="margin-bottom:10px">'+
			'<input id="new_password" type="password" name="new_password" style="width:250px;display:none;">'+
			'</div>'+
			'<div class="field" style="margin-bottom:10px">'+
			'<input id="new_password" type="text" style="width:250px" placeholder="Specify a new password">'+
			'</div>'+
			'<div class="field" style="margin-bottom:10px">'+
			'<input id="new_password_confirmation" type="password" name="new_password_confirmation" style="width:250px;display:none;">'+
			'</div>'+
			'<div class="field" style="margin-bottom:10px">'+
			'<input id="new_password_confirmation" type="text" style="width:250px" placeholder="Enter your new password again">'+
			'</div>'+
			'<div style="padding-top:15px">'+
			'<button class="change_password_button" id="change">CHANGE</button>'+
			'<button class="change_password_button" style="float:right" id="cancel">CANCEL</button>'+
			'</div>'+
			'<label class="login_notice" id="change_password"></div>'+
			'</div>'
		);
		// the following resembles ie_placeholder.js, but because login_dropdown and change password overlay are appended, so need to write the following again.
			$('input#old_password[type=text]').focus(function() {
				$(this).css('display','none'); // hide
				$('input#old_password[type=password]').css('display', ''); // show
				$('input#old_password[type=password]').select();
			});
			$('input#new_password[type=text]').focus(function() {
				$(this).css('display','none'); // hide
				$('input#new_password[type=password]').css('display', ''); // show
				$('input#new_password[type=password]').select();
			});
			$('input#new_password_confirmation[type=text]').focus(function() {
				$(this).css('display','none'); // hide
				$('input#new_password_confirmation[type=password]').css('display', ''); // show
				$('input#new_password_confirmation[type=password]').select();
			});
			$('input[placeholder]').focus(function() { // for IE
			  var input = $(this);
			  if (input.val() == input.attr('placeholder')) {
			    input.val('');
			    input.removeClass('placeholder');
			  }
			}).blur(function() {
			  var input = $(this);
			  if (input.val() == '' || input.val() == input.attr('placeholder')) {
			  	if (input.attr('type') == 'password' && input.attr('id') == 'old_password') {
			  		input.css('display','none'); // hide
			  		$('input#old_password[type=text]').css('display','').blur(); // show and initialize
			  		$('input#old_password[type=text]').addClass('placeholder');
			    	$('input#old_password[type=text]').val(input.attr('placeholder'));
			    } else if (input.attr('type') == 'password' && input.attr('id') == 'new_password') {
			    	input.css('display','none'); // hide
			    	$('input#new_password[type=text]').css('display','').blur(); // show and initialize
			  		$('input#new_password[type=text]').addClass('placeholder');
			    	$('input#new_password[type=text]').val(input.attr('placeholder'));
			    } else if (input.attr('type') == 'password' && input.attr('id') == 'new_password_confirmation') {
			    	input.css('display','none'); // hide
			    	$('input#new_password_confirmation[type=text]').css('display','').blur(); // show and initialize
			  		$('input#new_password_confirmation[type=text]').addClass('placeholder');
			    	$('input#new_password_confirmation[type=text]').val(input.attr('placeholder'));
			  	} else {
			  		input.addClass('placeholder');
			    	input.val(input.attr('placeholder'));	
			  	}
			  }
			}).blur();						
			// end of above
		$('.mask').fadeIn('fast');
		$('.change_password_container').fadeIn('fast');
		$('.close_change, .change_password_button#cancel').click(function() {
			$('.mask').fadeOut('fast', function() {
				$(this).remove();
			});
			$('.change_password_container').fadeOut('fast', function() {
				$(this).remove();
			});
		});
		
		$('.change_password_button#change').click(function() {
			if ($('input#old_password[type=password]').val() == '') {
				$('input#old_password[type=password]').css('outline', '1px solid red');
				$('label.login_notice#change_password').text('Please enter your old password.');
				setTimeout(function() {
					$('input#old_password[type=password]').css('outline', '');
					$('label.login_notice#change_password').text('');
				}, 800);
			} else {
				$.ajax({
					url: '/smbs/check_old_password',
					data: 'password_reset_email=' + $("input#user_email").val() + '&' + 'old_password=' + $("input#old_password[type=password]").val(),
					dataType: 'json', 
					type: 'POST',
					success: function (j) {
						if (!j.ok) { // password doesn't match
							$('input#old_password[type=password]').css('outline', '1px solid red');
							$('label.login_notice#change_password').text('Password is not correct.');
							setTimeout(function() {
								$('input#old_password[type=password]').css('outline', '');
								$('label.login_notice#change_password').text('');
							}, 800);
						} else {
							if ($('input#new_password[type=password]').val() == '' && $('input#new_password_confirmation[type=password]').val() == '') {
								$('input#new_password[type=password]').css('outline', '1px solid red');
								$('input#new_password_confirmation[type=password]').css('outline', '1px solid red');
								$('label.login_notice#change_password').text('Please fill in required fields.');
								setTimeout(function() {
									$('input#new_password[type=password]').css('outline', '');
									$('input#new_password_confirmation[type=password]').css('outline','');
									$('label.login_notice#change_password').text('');
								}, 800);
							} else if ($('input#new_password[type=password]').val() == '') {
								$('input#new_password[type=password]').css('outline', '1px solid red');
								$('label.login_notice#change_password').text('Please specify a new password.');
								setTimeout(function() {
									$('input#new_password[type=password]').css('outline', '');
									$('label.login_notice#change_password').text('');
								}, 800);
							} else if ($('input#new_password_confirmation[type=password]').val() == '') {
								$('input#new_password_confirmation[type=password]').css('outline', '1px solid red');
								$('label.login_notice#change_password').text('Please confirm your new password.');
								setTimeout(function() {
									$('input#new_password_confirmation[type=password]').css('outline', '');
									$('label.login_notice#change_password').text('');
								}, 800);
							} else {
								if ($('input#new_password[type=password]').val() != $('input#new_password_confirmation[type=password]').val()) {
									$('input#new_password[type=password]').css('outline', '1px solid red');
									$('input#new_password_confirmation[type=password]').css('outline', '1px solid red');
									$('label.login_notice#change_password').text('New password does not match confirmation.');
									setTimeout(function() {
										$('input#new_password[type=password]').css('outline', '');
										$('input#new_password_confirmation[type=password]').css('outline','');
										$('label.login_notice#change_password').text('');
									}, 800);
								} else {
									$.ajax({
										url: '/smbs/change_password',
										data: 'password_reset_email=' + $("input#user_email").val() + '&' + 'old_password='+ $('input#old_password[type=password]').val() + '&' + 'new_password=' + $("input#new_password[type=password]").val() + '&' + 'new_password_confirmation=' + $("input#new_password_confirmation[type=password]").val(),
										dataType: 'json', 
										type: 'POST',
										success: function (k) {
											if (k.ok) {
												$('input#old_password[type=password], input#new_password[type=password], input#new_password_confirmation[type=password]').attr('disabled', true);
												$('label.login_notice#change_password').css('color', '#66cc00').text('Password has been updated!');
												setTimeout(function() {
													$('.close_change').click();
												}, 800)
											} else {
												$('label.login_notice#change_password').text('Something wrong. Please retry.');
												setTimeout(function() {
													$('label.login_notice#change_password').text('');
												}, 800)
											}
										}
									});
								}
							}
						}
					}
				});
			}
		});
		
	});
	
	$(".login").click(function(e) {
  		e.stopPropagation();
  		if ($('div.getstarted').attr('id')=='active') $('div.getstarted').click();
  		if ($("div.login").attr("id")!="active") {
  			$(".header_nav").append('<div class="login_dropdown" hovered="false" >'+ '<form class="login_form" method="post" action="/sessions" data-remote="true" accept-charset="UTF-8">'+
									'<div style="margin:0;padding:0;display:inline">'+
									'<input type="hidden" value="✓" name="utf8">'+
									'<input type="hidden" value="swgPcTwx2zRxr04opfhlqQ4Ax5m3jLBc5lkVELp7MsU=" name="authenticity_token">'+
									'</div>'+
									'<div class="field">'+
									'<input id="email" type="text" placeholder="Email or username" name="email" style="width: 135px;">'+
									'</div>'+
									'<div class="field">'+
									'<input id="password" type="password" value="" placeholder="Password" name="password" style="display:none;width: 135px;" >'+
									'</div>'+
									'<div class="field">'+
									'<input id="password" type="text" value="" placeholder="Password" style="width: 135px;">'+
									'</div>'+
									'<div class="field">'+
									'<input id="remember_me" type="checkbox" value="1" name="remember_me" style=" margin: 0 10px 0 0;">'+
									'<span style="color: #999999;font-size: 14px; font-family: AvenirLTStd-Light;">Remember me</span>'+
									'</div>'+
									'<div class="button">'+
									'<input type="submit" value="LOG IN" name="commit" class="login_button">'+
									'</div>'+
									'</form>' +
									'<a href="/forgot" class="forgot">Forgot your password?</a><br/>' +
									'<div class="forgot_block" style="display:none; margin-top:10px">'+
									'<div class="field">'+
									'<input id="reset_password_email" type="email" placeholder="Enter your e-mail" name="reset_password_email" style="width: 135px;">'+
									'</div>'+
									'<div class="button">'+
									'<button class="forgot_button" style="cursor:pointer">SEND</button>'+
									'</div>'+
									'</div>'+
									'<label class="login_notice"></label>' +
									'</div>');
			$('a.forgot').click(function() {
				$('.login_dropdown').css('height', '300px');
				$('.forgot_block').show();
			});
			// the following resembles ie_placeholder.js, but because login_dropdown and getstarted_dropdown are appended, so need to write the following again.
			$('input#password[type=text]').focus(function() {
				$(this).css('display','none'); // hide
				$('input#password[type=password]').css('display', ''); // show
				$('input#password[type=password]').select();
			});
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
									
  			$(window).keydown(function(a) {
				a.keyCode==13&&$("div.login").attr("id")=="active"&&(a.preventDefault(),$("input.login_button").click())
			});
			$("div.login").attr("id","active");
			$(".login_dropdown").hover(function(){ 
				$(this).attr("hovered","true")
			}, function() {
				$(this).attr("hovered","false")
			});
			$("input#email[type=text]").select();
			$("input.login_button").click(function(event) {
				if (($('input#email[type=text]').val() == '' || $('input#email[type=text]').val() == 'Email or Username') && ($('input#password').val() == '' || $('input#password').val() == 'Password')) {
					event.preventDefault();
					$('.login_notice').text("Please fill in required fields");
					$('input#email[type=text]').css('outline','1px solid red');
					$('input#password').css('outline','1px solid red');
					setTimeout(function() {
						$('.login_notice').text("");
						$('input#email[type=text]').css('outline','');
						$('input#password').css('outline','');
					}, 1000);
				} else if ($('input#email[type=text]').val() == '' || $('input#email[type=text]').val() == 'Email or Username') {
					event.preventDefault();
					$('.login_notice').text("Please fill in username or email");
					$('input#email[type=text]').css('outline','1px solid red');
					setTimeout(function() {
						$('.login_notice').text("");
						$('input#email[type=text]').css('outline','');
					}, 1000);
				} else if ($('input#password').val() == '' || $('input#password').val() == 'Password') {
					event.preventDefault();
					$('.login_notice').text("Please fill in password");
					$('input#password').css('outline','1px solid red');
					setTimeout(function() {
						$('.login_notice').text("");
						$('input#password').css('outline','');
					}, 1000);
				} else {
					$.ajax({
						url: '/sessions/create',
						data: 'email=' + $('input#email[type=text]').val() + '&' + 'password=' + $('input#password[type=password]').val(),
						dataType: 'json',
						type: 'POST',
						success: function(j) {
							if (j.ok == false) {
								$('.login_notice').text('User not found');
								setTimeout(function() {
									$('.login_notice').text('');
								}, 1000);
							} else {
								window.location.href = j.url;
							}
						}
					});
				}
				
			});
			
			$('.forgot_button').click(function() {
				if (!/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test($('input#reset_password_email').val())) {
					$('.login_notice').text("Please enter a valid e-mail");
					$('input#reset_password_email').css('outline', '1px solid red');
					setTimeout(function() {
						$('.login_notice').text('');
						$('input#reset_password_email').css('outline', '');
					}, 800);
				} else {
					$('.forgot_button').text('SENDING...');
					$('input#reset_password_email').attr('disabled', true);
					$.ajax({
						url: '/password_resets/send_instruction',
						data: 'reset_password_email=' + $('input#reset_password_email').val(),
						dataType: 'json', 
						type: 'POST',
						success: function (j) {
							if (j.ok) {
								$('.forgot_button').text('SENT');
							} else {
								$('.forgot_button').text('SEND');
								$('input#reset_password_email').attr('disabled', false);
								$('input#reset_password_email').css('outline', '1px solid red');
								$('.login_notice').text("No such user");
								setTimeout(function() {
									$('input#reset_password_email').css('outline', '');
									$('.login_notice').text("");
								}, 800);
							}
						}
					});
				}
			});
  		} else {
  			$(".login_dropdown").remove();
  			$("div.login").attr("id","");
  		}
	});
	
	$('.feedback_button').click(function() {
		if (!$(this).attr('active')) {
			$(this).attr('active', true);
			$('body').prepend('<div class="mask" style="display:none"></div>');
			$('.mask').fadeIn('fast');
			$(this).css('background-color', '#f1f2f2').css('color', 'black');
				$('body').prepend('<div class="feedback_container" style="display:none">'+
								  '<img src="/x_button.png" class="close_feedback">'+
								  '<div class="feedback_text">We appreciate your feedback.  We\'d love your ideas on important new features, ways to make Credvine easier to use and any other thoughts to help us make Credvine better.</div>'+
								  '<div class="field">'+
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
		} else {
			$('.mask').fadeOut('fast', function() {
				$('.mask').remove();
			});
			$(this).css('background-color', 'black').css('color', 'white');
			$(this).parent().find('.feedback_container').fadeOut('fast', function() {
				$('.feedback_container').remove();
			});
			$(this).attr('active', '');
		}
	});
	
	//if ($('[placeholder]').val() == $('[placeholder]').attr('placeholder')) $('[placeholder]').val('');
	//if ($('[placehold]').val() == $('[placehold]').attr('placehold')) $('[placehold]').val('');
	$('[placeholder]').each(function() {
		if ($(this).val() != '' && $(this).val() != $(this).attr('placeholder')) $(this).css('font-style', 'normal').css('color', '#66cc00'); // initialize
		if ($(this).val() == $(this).attr('placeholder')) $(this).val('');
	});
	$('[placehold]').each(function() {
		if ($(this).val() != '' && $(this).val() != $(this).attr('placehold')) $(this).css('font-style', 'normal').css('color', '#66cc00'); // initialize
		if ($(this).val() == $(this).attr('placehold')) $(this).val('');

	});
	$('[placeholder]').live('keydown', function() {
		$(this).css('font-style','normal').css('color', '#66cc00');
	}).live('blur', function () {
		$(this).css('border', '');
		if ($(this).val() == '') $(this).css('font-style', '').css('color', '');
	}).live('focus', function() {
		$(this).css('border', '1px solid #66cc00');
		if ($(this).val() == $(this).attr('placeholder') || $(this).val() == $(this).attr('placehold')) $(this).val('');
	});
	$('textarea').focus(function() {
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
	}).live('focus', function() {
		$(this).css('border', '1px solid #66cc00');
	}).live('blur', function() {
		$(this).css('border', '');
	}).blur();
	$('select').change(function() {
		if ($(this).val() == '') {
			$(this).css('font-style','italic');
			$(this).find("option").css('font-style','normal');
			$(this).find("option[value='']").css('font-style','italic');
		} else {
			$(this).css('font-style','');
		}
	}).focus(function() {
		$(this).css('border', '1px solid #66cc00');
	}).blur(function() {
		$(this).css('border', '');
	}).change();
});