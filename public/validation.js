// put $('.actions').click or $('next').click functions into corresponding files, like in campaign's _form.html.erb.
// include this file separately not in application.html.erb but in like new.html.erb edit.html.erb...
// for now only used in campaign creation page.

$(document).ready(function() {
	$('input').focus(function () {
		$(this).css('border', '');
		$(this).parent().find('.error_validation').remove();
		//$(this).change();
		//$(this).blur(); // this is STUPID!!!!
	});
	$('textarea').focus(function () {
		$(this).css('border', '');
		$(this).parent().find('.error_validation').remove();
		//$(this).change();
		//$(this).blur();// this is STUPID!!!!
	});
	$('select').focus(function () {
		$(this).css('border', '');
		$(this).parent().find('.error_validation').remove();
		//$(this).change();
		//$(this).blur(); // this is STUPID!!!!
	});
	// setTimeout(function () {
		// $('input#campaign_start_date, input#campaign_end_date, input#campaign_exp_date').change();
	// }, 100); // allow for slow computers
	$('input#campaign_start_date').change(function () {
		get_date($(this), $(this).val());
	});
	$('input#campaign_end_date').change(function () {
		get_date($(this), $(this).val());
	});
	$('input#campaign_exp_date').change(function () {
		get_date($(this), $(this).val());
	});
	

	
	$('input#campaign_start_date').change(function () {
		var start = $(this);
		var end = $('input#campaign_end_date');
		var formatted_start = new Date($(start).data('month')+'/'+$(start).data('day')+'/'+$(start).data('year'));
		var formatted_end = new Date($(end).data('month')+'/'+$(end).data('day')+'/'+$(end).data('year'));
		if ($(end).val().length == 0) return;
		//alert(formatted_start + ' ' + end.val());
		if (formatted_start > formatted_end) { //greater then end date
			show_error($(this), 'must be less than end date');
		}
	});
	
	$('input#campaign_end_date').change(function () {
		
		var start = $('input#campaign_start_date');
		var end = $(this);
		var expiry = $('input#campaign_exp_date');
		var formatted_start = new Date($(start).data('month')+'/'+$(start).data('day')+'/'+$(start).data('year'));
		var formatted_end = new Date($(end).data('month')+'/'+$(end).data('day')+'/'+$(end).data('year'));
		var formatted_expiry = new Date($(expiry).data('month')+'/'+$(expiry).data('day')+'/'+$(expiry).data('year'));
	//	alert($(start).data('month')+'/'+$(start).data('day')+'/'+$(start).data('year'));
//		alert(formatted_end);
//		alert(formatted_expiry);
		//alert($(start).data('year') + ', ' + $(this).data('year') + ' month: ' + 
		//	$(start).data('month') + ', ' +  $(this).data('month') + ' day: ' +
		//	$(start).data('day') + $(this).data('day'));
		if ($(start).val().length == 0) return;
//		if ($(start).data('year') > $(this).data('year') || 
//			($(start).data('year') == $(this).data('year') && $(start).data('month') > $(this).data('month')) ||
//			($(start).data('year') == $(this).data('year') && $(start).data('month') == $(this).data('month') && 
//				$(start).data('day') > $(this).data('day')) ) { //less then start date
//			show_error($(this), 'must be greater than start date');
//		}
		if (formatted_end < formatted_start) { //less then start date
			show_error($(this), 'must be greater than start date');
		}
		if ($(expiry).val().length == 0) return;
		if ((formatted_expiry.getTime() - formatted_end.getTime())/1000/60/60/24 < 60) { //within 60 days before expiry date
			show_error($(this), 'must be 60 days less than expiry date');
		}
	}); //must be 2 months before expiry & greater than start_date
	
	$('input#campaign_exp_date').change(function () {
		var end = $('input#campaign_end_date');
		var expiry = $(this);
		var formatted_end = new Date($(end).data('month')+'/'+$(end).data('day')+'/'+$(end).data('year'));
		var formatted_expiry = new Date($(expiry).data('month')+'/'+$(expiry).data('day')+'/'+$(expiry).data('year'));
		if ($(end).val().length == 0) return;
		if ((formatted_expiry.getTime() - formatted_end.getTime())/1000/60/60/24 < 60) { //within 60 days before expiry date
			show_error($(this), 'must be 60 days greater than end date');
		}
	}); //must be 2 months after end
	
	
	
	$('input#campaign_camp_name').blur(function () { // sometimes such fields need blur because if there is nothing in 
													// input field, .change will not be triggered if tabbing out the field.
		
	}); //must be present
	
	// TODO add more here
	
	// the above is for campaign creation page.
	
	
});

function show_error(input, message) {
	$('form').data('validated', false);
	$(input).css('border', '2px solid red');
	$(input).parent().append('<div class="error_validation">' + message + '</div>');
}
function get_date(input, date) {
	if (date == '') show_error($(input), 'Please specify a date.');
	if (date.substr(2,1) == '/') {
		$(input).data('month', date.substr(0,2));
		$(input).data('day', date.substr(3,2));
		$(input).data('year', date.substr(6,4));
	} else if (date.substr(4,1) == '-') {
		$(input).data('month', date.substr(5,2));
		$(input).data('day', date.substr(8,2));
		$(input).data('year', date.substr(0,4));
	} else {
		// for IE actually: because ie's placeholder is fake, actually is value.
		if ($(input).val() == $(input).attr("placeholder") || $(input).val() == $(input).attr("placehold")) {
			show_error($(input), 'Please specify a date.');
		} else {
			show_error($(input), 'invalid format');
		}
	}
}
