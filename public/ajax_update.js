$(document).ready(function() {
	$('.green_content#init_thx').hover(function() {
		$(this).fadeTo('fast', 0.6);
	}, function() {
		$(this).fadeTo('fast', 1);
	}).click(function() {
		$('.right_edit_box#cust_sent_thx').fadeIn('fast');
		$('img#close_init_thx_edit').click(function() {
			$('.right_edit_box#cust_sent_thx').fadeOut('fast');
		});
	});
	
	$('.green_content#cust_success').hover(function() {
		$(this).fadeTo('fast', 0.6);
	}, function() {
		$(this).fadeTo('fast', 1);
	}).click(function() {
		$('.right_edit_box#cust_success_thx').fadeIn('fast');
		$('img#close_cust_success_edit').click(function() {
			$('.right_edit_box#cust_success_thx').fadeOut('fast');
		});
	});
	
});
