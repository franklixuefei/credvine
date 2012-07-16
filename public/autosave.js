var lastsave_cache = ''; //don't save twice if no changes
$(document).ready(function () {
	$.ajax({
		url: 'campaigns/autosave_create',
		data: '',
		dataType: 'json',
		type: 'GET',
		success: function (j) {
			if (j.temp) {
				for (name in j) {
					if (name == 'incentives') {
						for (incentives_number in j[name]) {
							for (incentives in j[name][incentives_number]) {
								$('textarea[name="campaign[incentives_attributes][' + incentives_number + '][' + incentives + ']"]').val(j[name][incentives_number][incentives]);
								$('input[name="campaign[incentives_attributes][' + incentives_number + '][' + incentives + ']"]').val(j[name][incentives_number][incentives]);
							}
						}
					}
					if ($('input#campaign_' + name).attr('type') == 'checkbox') {
						$('input#campaign_' + name).attr('checked', j[name]);
						if($('#campaign_give_cust_ref_sent:checked').length) { 
				        	$(".a1 :input").attr('disabled', false);   
				        } else { 
				            $(".a1 :input").attr('disabled', true);
				        }
				        if($('#campaign_give_cust_success:checked').length) { 
				        	$(".a2 :input").attr('disabled', false);  
				        } else { 
				            $(".a2 :input").attr('disabled', true);  
				        }
				        if($('#campaign_give_frien:checked').length) { 
				        	$(".a3 :input").attr('disabled', false);
				        	$(".a3").attr('disabled', false);   
				        } else { 
				            $(".a3 :input").attr('disabled', true);
				            $(".a3").attr('disabled', true);    
				        } 
					// } else if ($('input#campaign_' + name + '_true').attr('type') == 'radio') {
							// if (j[name]) {
								// $('input#campaign_' + name + '_true').attr('checked', true);
							// } else {
								// $('input#campaign_' + name + '_false').attr('checked', true);
							// } // don't update radio button for now.
							//alert('found radio button:' + name + ' -> ' + j[name]);
					} else {
						$('#campaign_' + name).val(j[name]);
					}
				}
			}
			$('body').data('camp_id', j.id);
			$('input#campaign_start_date').change();
			$('input#campaign_end_date').change();
			$('input#campaign_exp_date').change();
			// TODO add more here: $(...).change();
			if ($('[placeholder]').val() != '' && $('[placeholder]').val() != $('[placeholder]').attr('placeholder')) $('[placeholder]').css('font-style', 'normal').css('color', '#66cc00');
			if ($('[placehold]').val() != '' && $('[placehold]').val() != $('[placehold]').attr('placehold')) $('[placehold]').css('font-style', 'normal').css('color', '#66cc00');
			autosave_update();
		}
	});
});

function autosave_update() {
	//send POST ajax to update
	var cdata = '';
	$('input[autosave="true"], textarea[autosave="true"], select[autosave="true"]').each(function() {
		if ($(this).val() != $(this).attr('placeholder') && $(this).val() != $(this).attr('placehold')) {
			if ($(this).attr('type') == 'checkbox') {
				if ($(this).val() != '') cdata += $(this).attr('name') + '=' + $(this).is(':checked') + '&';
			} else if ($(this).attr('type') == 'radio') {
				if ($(this).attr('checked') == 'checked') {
				   cdata += $(this).attr('name') + '=' + $(this).attr('value') + '&';
				}
			} else {
				if ($(this).val() != '') cdata += $(this).attr('name') + '=' + $(this).val() + '&';
			}
		}
	});
	if (lastsave_cache == cdata) {		
		setTimeout("autosave_update()", 3000);
		return;
	}
	$.ajax({
		url: 'campaigns/' + $('body').data('camp_id') + '/autosave',
		data: cdata,
		dataType: 'json',
		type: 'POST',
		success: function (j) {
			lastsave_cache = cdata;
			// add some code to show "autosaved at (current time)" on each page of creation form
			$('.autosave_text').text('autosaving...');
			setTimeout(function() {
				$('.autosave_text').text('autosaved.');
			}, 100);
			setTimeout("autosave_update()", 3000);
		}
	});
}

