$(document).ready(function() {
	$('.feedback_button').remove();
	$('#users').dataTable({
		"sPaginationType": "full_numbers"
	});
	$('#approved_users').dataTable({
		"sPaginationType": "full_numbers"
	});
	$('div#users_filter input').attr('placeholder','Search by Name, Date, etc.');
	$('div#approved_users_filter input').attr('placeholder','Search by User, Date, etc.');
	$('table#approved_users tbody tr').live('hover', function(event) {
		if ($(this).attr('userid') != undefined) {
			var current_row = $(this);
			if (event.type == 'mouseenter') {
				current_row.find('td').css('background-color','#d3d644');
				current_row.find('a').css('color', 'black');
			} else {
				current_row.find('td').css('background-color','');
				current_row.find('a').css('color', '');
			}
		}
	});
	
	$('table#users tbody tr').live('hover', function(event) {
		if ($(this).attr('userid') != undefined) {
			var current_row = $(this);
			if (event.type == 'mouseenter') {
				current_row.find('td').css('background-color','#d3d644').css('cursor', 'pointer');
				current_row.click( function() {
					if (!current_row.data('clicked')) {
						$('.user_info').remove();
						$('table#users tbody tr').find('td').css('background-color','').css('cursor', '');
						current_row.find('td').css('background-color','#d3d644').css('cursor', 'pointer');
						$('table#users tbody tr').data('clicked',false);
						$('table#users tbody tr').data('fetched', false);
						$('body').append('<div class="user_info" style="display:none"><img src="/x_button.png" style="float:right;cursor:pointer;margin-top:-20px; margin-right:-20px;" id="close_info" /><center><img id="loading" src="/loading.gif" style="margin-top:70px" /></center></div>');
						current_row.data('clicked',true);
						$('.user_info').fadeIn('fast', function() {
							$('img#close_info').click(function() {
								$('.user_info').fadeOut('fast', function() {
									$(this).remove();
									current_row.data('clicked', false).data('fetched', false);
									current_row.find('td').css('background-color','').css('cursor', '');
								}); 
							});
							if (!current_row.data('fetched')) {
								current_row.data('fetched', true);
								$.ajax({
									url: '../fetch_smb_user_data',
									data: 'user_id=' + current_row.attr('userid'),
									dataType: 'json', 
									type: 'POST',
									success: function (j) {
										//alert(j.toSource());
										$('img#loading').parent().remove();
										if (j.ok) {
											$('.user_info').addClass('expanded');
											$('.user_info').append(
												'<div class="info_leftbox">'+
												((j.site_url != null)? ('<div class="buz_title" style="min-height:31px;"><a onhover="underline" target="_blank" href="'+ j.site_url +'">'+ j.full_name + '</a></div>') : ('<div class="buz_title" style="min-height:31px;">'+ j.full_name + '</div>')) +
												'<label>Username: </label>'+
												'<div class="buz_fields field">'+ j.username + '</div>'+
												'<label>E-mail: </label>'+
												'<div class="buz_fields field" style="min-height:20px;"><a href="mailto:' + j.email + '">'+ j.email + '</a></div>'+
												'<label>Phone #: </label>'+
												'<div class="buz_fields field" style="min-height:20px;">'+ j.phone + '</div>'+
												'<label>Address: </label>'+
												'<div class="buz_fields field" style="min-height:60px;">'+ j.st_name_num + '<br/>' + j.city + ', ' + ((j.state_id != null)? j.state_name : j.state_prov) + ',<br/> ' + j.country_name + '&nbsp;&nbsp;' + j.zip_pos +'</div>' +
												'<label>Business Category: </label>'+
												'<div class="buz_fields field" style="min-height:20px;">' + ((j.biz_category != null)? j.biz_category : '') + '</div>' +
												'<label>Social Media: </label>'+
												'<div class="buz_fields field" style="min-height:37px;">'+
												((j.facebook_url != null)? '<a target="_blank" href="'+ j.facebook_url +'"><img src="/credvine_facebook.png" /></a>' : '' ) +
												((j.twitter_url != null)? '<a target="_blank" href="'+ j.twitter_url +'"><img src="/credvine_twitter.png" /></a>' : '' ) +
												((j.yelp_url != null)? '<a target="_blank" href="'+ j.yelp_url +'"><img src="/credvine_yelp.png" /></a>' : '' ) +
												((j.linkedin_url != null)? '<a target="_blank" href="'+ j.linkedin_url +'"><img src="/credvine_linkedin.png" /></a>' : '' ) +
												 '</div>' +
												 '<div class="promo_credit_fields"><label>Current credit: </label>'+
												'<div class="credit buz_fields field" style="display:inline;margin-left: 50px;">'+ j.credit +'</div>'+
												'<br><label>Promo code: </label>'+
												'<div class="promocode_block buz_fields">'+
												'</div>'+
												'<div class="buz_fields" style="width:300px">'+
												'<input id="p_code" readonly="readonly" type="text" placeholder="code" style="padding:0px; width:120px;font-size:14px;">'+ 
												'<input id="p_credit" type="text" placeholder="credit" style="padding:0px; width:40px;font-size:14px;margin-left:10px">'+ 
												'<span class="smb_info_buttons" id="gen_code" style="margin-left:15px;">GEN CODE</span>'+
												'<span class="smb_info_buttons" id="add_code" style="margin-left:10px;">ADD</span>'+
												'</div>'+
												'</div>'+
												'</div>'+
												'<div class="info_rightbox">'+
												'<div style="height:150px;text-align:center;"><img src="' + j.logo_url + '" style="max-width: 200px;max-height:150px;margin-bottom:10px"/></div>'+
												'<br/><label>Business description: </label><br/>'+
												'<p class="buz_des" style="min-height:60px;">'+ j.business_description +'</p>'+
												'<div style="height:150px;margin-bottom:15px;text-align:center;"><img src="'+ j.featured_photo_url +'" style="max-width: 200px;max-height:150px;"/></div>'+
												'<div class="smb_info_big_buttons set_admin">'+
												((!j.admin)? 'SET AS ADMIN' : 'TURN OFF ADMIN')+
												'</div>'+
												'<div class="smb_info_big_buttons set_payment">'+
												((j.credit == 'free')? 'TURN ON PAYMENT' : 'TURN OFF PAYMENT')+
												'</div>'+
												'<div class="smb_info_big_buttons del_smb" style="background-color:red">DELETE ACCOUNT</div>'+
												'</div>'
												
											);
											for (var i = 0; i < j.pcs.length; i++) {
												$('.promocode_block').prepend(
													'<div class="each_code" id="'+ j.pcs[i]['id'] +'">'+ j.pcs[i]['promo_code'] +
													((j.pcs[i]['promo_credit'] == 'free')? '' : '<img id="delete_code" style="float:right;margin-right:10px;margin-left:5px;" src="/x_button.png" />')+
													'<span style="float:right;">'+ j.pcs[i]['promo_credit'] +'</span>'+
													'</div>'
												);
											}
											$('span#gen_code').click(function() {
												$.ajax({
													url: '../gen_promocode',
													data: '',
													dataType: 'json', 
													type: 'GET',
													success: function (j) {
														$('input#p_code').val(j.p_code).keydown();
													}
												});
											});
											$('span#add_code').click(function() {
												var p_code = $('input#p_code');
												var p_credit = $('input#p_credit');
												var function_return = false;
												if (p_code.val() == '' || p_code.val() == p_code.attr('placeholder')) {
													p_code.css('outline', "1px solid red");
													setTimeout(function() {
														p_code.css('outline', "");
													}, 600);
													function_return = true
												}
												if (p_credit.val() == '' || p_credit.val() == p_credit.attr('placeholder') || !is_int(p_credit.val())) {
													p_credit.css('outline', "1px solid red");
													setTimeout(function() {
														p_credit.css('outline', "");
													}, 600);
													function_return = true
												}
												if (function_return) return;
												$.ajax({
													url: '../add_promocode',
													data: 'p_code=' + $('input#p_code').val() + '&' + 'p_credit=' + $('input#p_credit').val() + '&' + 'userid=' + current_row.attr('userid'),
													dataType: 'json', 
													type: 'POST',
													success: function (j) {
														//alert(j.ok);
														if (j.ok) {
															p_credit.val('').blur();
															p_code.val('').blur();
															var updated_credit = parseInt($('div.credit').text()) + parseInt(j.p['promo_credit']);
															$('div.credit').text(updated_credit);
															current_row.find('td').last().text(updated_credit);
															$('.promocode_block').prepend(
																'<div class="each_code" id="'+ j.p['id'] +'" style="font-weight:bold;">'+ j.p['promo_code'] +'<img id="delete_code" style="float:right;margin-right:10px;margin-left:5px;" src="/x_button.png" />'+
																'<span style="float:right;">'+ j.p['promo_credit'] +'</span>'+
																'</div>'
															);
															setTimeout(function() {
																$('div.each_code#'+j.p['id']).css('font-weight','');
															}, 600);
															$('img#delete_code').click(function() {
																delete_promo($(this), current_row);
															});
														} else {
															if (j.deleted) {
																alert('This account has been deleted');
															} else {
																alert('Cannot add promo code when payment is turned off');
															}
														}
													} 
												});
											});
											$('img#delete_code').click(function() {
												delete_promo($(this), current_row);
											});
											$('div.set_admin').click(function() {
												var username = j.username;
												var is_admin = j.admin;
												var setAdminButton = $(this);
												var confirmed = confirm('Are you sure?');
												if (confirmed) {
													$.ajax({
														url: '../set_admin',
														data: 'userid=' + current_row.attr('userid') + '&' + 'button_status=' + ((setAdminButton.text() == "SET AS ADMIN")? 'to_admin' : 'to_non_admin'),
														dataType: 'json', 
														type: 'POST',
														success: function (j) {
															if (!j.deleted) {
																if (j.admin) {
																	setAdminButton.text('TURN OFF ADMIN');
																	$('div.admins').append(
																		'<span class="admin_user" id="'+ current_row.attr('userid') +'">'+ username +'</span>'
																	);
																} else {
																	setAdminButton.text('SET AS ADMIN');
																	$('span.admin_user#'+current_row.attr('userid')).remove();
																}
															} else {
																alert('This account has been deleted');
															}
														}
													});
												}
											});
											$('div.set_payment').click(function() {
												var setPayButton = $(this);
												var confirmed = confirm('Are you sure to change the payment status?');
												if (confirmed) {
													$.ajax({
														url: '../set_payment',
														data: 'userid=' + current_row.attr('userid') + '&' + 'button_status=' + ((setPayButton.text() == "TURN ON PAYMENT")? 'to_pay' : 'not_to_pay'),
														dataType: 'json', 
														type: 'POST',
														success: function (j) {
															if (!j.deleted) {
																$('div.credit').text(j.credit);
																current_row.find('td').last().text(j.credit);
																if (j.credit == 'free') {
																	setPayButton.text('TURN ON PAYMENT');
																} else {
																	setPayButton.text('TURN OFF PAYMENT');
																}
																
															} else {
																alert('This account has been deleted');
															}
														}
													});
												} 
											});
											$('div.del_smb').click(function() {
												var setDelButton = $(this);
												var confirmed = confirm('Are you really sure to delete this account?');
												if (confirmed) {
													$.ajax({
														url: '../del_smb',
														data: 'userid=' + current_row.attr('userid'),
														dataType: 'json', 
														type: 'POST',
														success: function (j) {
															if (j.ok) {
																var deleted = confirm('This account was successfully deleted');
																if (deleted) {
																	location.reload(true);
																}
															} else {
																var deleted = confirm('This account has been deleted by another administrator');
																if (deleted) {
																	location.reload(true);
																}
															}
														}
													});
												}
											});
										} else {
											$('.user_info').append(
												'<center><div style="margin-top:80px">THIS ACCOUNT HAS ALREADY BEEN DELETED</div></center>'
											);
										}
									}
								});
							}
						});
						
					}
				});
			} else {
				if (!current_row.data('clicked')) {
					current_row.find('td').css('background-color','').css('cursor', '');
				}
			}
		}
	});
	
	
	
	$('.request_button#approve').click(function() {
		var approve_button = $(this);
		var credit = approve_button.parent().find('input#promo_credit');
		var code = approve_button.parent().find('input#promo_code');
		if (credit.val() == '' || credit.val() == credit.attr('placeholder') || !is_int(credit.val(), 'free')) {
			credit.css('outline', "1px solid red");
			setTimeout(function() {
				credit.css('outline', "");
			}, 300);
			return;
		}
		if (code.val() == '' || code.val() == code.attr('placeholder')) {
			code.css('outline', "1px solid red");
			setTimeout(function() {
				code.css('outline', "");
			}, 300);
			return;
		}
		var approve = confirm("Are you sure to approve this user to sign up?");
		if (approve) {
			$.ajax({
				url: '../approve',
				data: 'request_id=' + approve_button.attr('request_id') + '&' + 'promo_code=' + code.val() + '&' + 'promo_credit=' + credit.val(),
				dataType: 'json',
				type: 'POST',
				success: function (j) {
					if (!j.ok) {
						alert('This user has been approved by another administrator.');						
					}
					var counter = 0;
					var pointer;
					$('.processed_requests#' + approve_button.attr('package_type')).find('.each_processed_container').find('.each_processed_request').each(function() {
						counter++;
						pointer = $(this);
					});
					if (counter >= 3) {
						pointer.remove();
					}
					$('.processed_requests#' + approve_button.attr('package_type')).find('.each_processed_container').prepend('<div class="each_processed_request">' + approve_button.attr('request_email').split("@")[0] + '</div>');
					var unprocessed_counter = parseInt($('span.unprocessed_request_counter').text());
					unprocessed_counter -= 1;
					$('span.unprocessed_request_counter').text(unprocessed_counter);
					var processed_counter = parseInt($('.processed_requests_num#' + approve_button.attr('package_type')).text());
					processed_counter += 1;
					$('.processed_requests_num#' + approve_button.attr('package_type')).text(processed_counter);
					approve_button.parent().fadeOut(300, function() {
						approve_button.parent().remove();
						if (unprocessed_counter == 0) {
							$('.requests_left').append('<div class="each_unprocessed_request">NO UNPROCESSED REQUEST</div>');
						}
					});
				}
			});
		}
	});
	
	$('.request_button#ignore').click(function() {
		var ignore_button = $(this);
		var ignore = confirm("Are you sure to ignore this user?");
		if (ignore) {
			$.ajax({
				url: '../ignore',
				data: 'request_id=' + ignore_button.attr('request_id'),
				dataType: 'json',
				type: 'POST',
				success: function (j) {
					if (!j.ok) {
						alert('This user has been ignored by another administrator.');
					}
					var unprocessed_counter = parseInt($('span.unprocessed_request_counter').text());
					unprocessed_counter -= 1;
					$('span.unprocessed_request_counter').text(unprocessed_counter);
					ignore_button.parent().fadeOut(300, function() {
						ignore_button.parent().remove();
						if (unprocessed_counter == 0) {
							$('.requests_left').append('<div class="each_unprocessed_request">NO UNPROCESSED REQUEST</div>');
						}
					});
				}
			});
		}
	});
	$('.each_processed_request').live('hover', function(event) {
		var thisRequest = $(this);
 		if (event.type == 'mouseenter') {
 			if (!thisRequest.find('.processed_request_info').data('hovered')) {
 				$('.processed_request_info').remove();
 			}
 			if (thisRequest.find('.processed_request_info').length == 0) {
			thisRequest.prepend(
				'<div class="processed_request_info"><img src="/loading.gif" style="margin-top:30px" /></div>'
			);
			var info = thisRequest.find('.processed_request_info');
			info.css('top', thisRequest.position().top - 34 - parseInt(info.css('height').replace('px', '')) + 'px').css('left', thisRequest.position().left + parseInt(thisRequest.css('width').replace('px', '')) / 2 + 'px');
			$.ajax({
				url: '../fetch_request',
				data: 'req_id=' + thisRequest.attr('id'),
				dataType: 'json', 
				type: 'POST',
				success: function (j) {
					info.find('img').remove();
					info.append(
						'<table style="text-align: left;" class="info-table">'+
						'<tr>'+
						'<td>E-MAIL: </td>'+
						'<td><a href="mailto:' + j.req_email + '">' + j.req_email + '</a></td>'+
						'</tr>'+
						'<tr>'+
						'<td>BETA KEY: </td>'+
						'<td>' + j.bk + '</td>'+
						'</tr>'+
						'<tr>'+
						'<td>SENT AT: </td>'+
						'<td>' + j.sent_at + '</td>'+
						'</tr>'+
						'<tr>'+
						'<td>APPROVED AT: </td>'+
						'<td>' + j.approved_at + '</td>'+
						'</tr>'+
						'<tr>'+
						'<td>BUSINESS TYPE: </td>'+
						'<td>' + j.type + '</td>'+
						'</tr>'+
						'</table>'
					);
					try
					{
						info.find('.info-table').append(
							'<tr>'+
							'<td>PROMO CODE: </td>'+
							'<td>' + j.pcs[0]["promo_code"] + '</td>'+
							'</tr>'+
							'<tr>'+
							'<td>CREDIT: </td>'+
							'<td>' + j.pcs[0]["promo_credit"] + '</td>'+
							'</tr>'
						);
					}
					catch(err) {
						info.find('.info-table').append(
							'<tr>'+
							'<td>PROMO CODE: </td>'+
							'<td></td>'+
							'</tr>'+
							'<tr>'+
							'<td>CREDIT: </td>'+
							'<td></td>'+
							'</tr>'
						);
					}
					info.css('top', thisRequest.position().top - 24 - parseInt(info.css('height').replace('px', '')) + 'px');
					//alert('req_email: ' + j.req_email + ', bk: ' + j.bk + ', sent_at: ' + j.sent_at + ', type: ' + j.type + ', pcs: ' + j.pcs);
					info.hover(function() {
						info.data('hovered', true);
					}, function() {
						info.data('hovered', false);
					});
				}
			});
			}
	  	} else {
	  		setTimeout(function() {
	  			if (!thisRequest.find('.processed_request_info').data('hovered')) {
	  				thisRequest.find('.processed_request_info').remove();
	  			}
	  		}, 300);
	  		
	  	}
	});

});
function is_int(value, exception) {
	if (exception != undefined) {
		if(((parseFloat(value) == parseInt(value)) && !isNaN(value)) || value == exception){
	    	return true;
	  	} else {
	      	return false;
	  	}
	} else {
		if(((parseFloat(value) == parseInt(value)) && !isNaN(value))){
	    	return true;
	  	} else {
	      	return false;
	  	}
	}
}

function delete_promo(elem, row) {
	var thisXButton = elem;
	var delete_confirmed = confirm('Are you sure to delete this promo code and credit?');
	if (delete_confirmed) {
			//alert('working');
		$.ajax({
			url: '../del_promocode',
			data: 'p_id=' + thisXButton.parent().attr('id') + '&' + 'u_id=' + row.attr('userid'),
			dataType: 'json', 
			type: 'POST',
			success: function (j) {
				if (j.ok) {
					var updated_credit = parseInt($('div.credit').text()) - parseInt(j.p['promo_credit']);
					$('div.credit').text(updated_credit);
					row.find('td').last().text(updated_credit);
					thisXButton.parent().fadeOut('fast', function() {
						thisXButton.parent().remove();
					});
				} else {
					if (j.deleted) {
						alert('This account has been deleted');
					} else {
						alert('Cannot add promo code when payment is turned off');	
					}
				}
			}
		});
	}
}
									


