$(document).ready(function() {
	$('.green_content#init_thx').hover(function() {
		if (!$(this).data('clicked')) {
			$(this).data('clicked', false);
			$(this).fadeTo('fast', 0.6);
			$(this).find('div#click_edit').fadeIn('fast');
			//$('.right_edit_box#cust_sent_thx').fadeTo('fast', 0.5);
		}
	}, function() {
		if (!$(this).data('clicked')) {
			$(this).fadeTo('fast', 1);
			$(this).find('div#click_edit').fadeOut('fast');
			// $('.right_edit_box#cust_sent_thx').fadeTo('fast', 0, function() {
				// $(this).hide();
			// });
		}
	}).click(function() {
		$('input#pos').val('cust_init');
		$(this).find('div#click_edit').fadeOut('fast');
		$('.right_edit_box#cust_sent_thx').fadeTo('fast', 1);
		$(this).data('clicked', true);
		$('img#close_init_thx_edit').click(function() {
			$('.green_content#init_thx').fadeTo('fast', 1);
			$('.right_edit_box#cust_sent_thx').fadeOut('fast');
			$('.green_content#init_thx').data('clicked', false);
		});
	});
	
	$('.green_content#cust_success').hover(function() {
		if (!$(this).data('clicked')) {
			$(this).data('clicked', false);
			$(this).fadeTo('fast', 0.6);
			$(this).find('div#click_edit').fadeIn('fast');
			//$('.right_edit_box#cust_success_thx').fadeTo('fast', 0.5);
		}
	}, function() {
		if (!$(this).data('clicked')) {
			$(this).fadeTo('fast', 1);
			$(this).find('div#click_edit').fadeOut('fast');
			// $('.right_edit_box#cust_success_thx').fadeTo('fast', 0, function() {
				// $(this).hide();
			// });
		}
	}).click(function() {
		$('input#pos').val('cust_suc');
		$(this).find('div#click_edit').fadeOut('fast');
		$('.right_edit_box#cust_success_thx').fadeTo('fast', 1);
		$(this).data('clicked', true);
		$('img#close_cust_success_edit').click(function() {
			$('.green_content#cust_success').fadeTo('fast', 1);
			$('.right_edit_box#cust_success_thx').fadeOut('fast');
			$('.green_content#cust_success').data('clicked', false);
		});
	});
	
	$('.green_content#frien_final').hover(function() {
		if (!$(this).data('clicked')) {
			$(this).data('clicked', false);
			$(this).fadeTo('fast', 0.6);
			$(this).find('div#click_edit').fadeIn('fast');
			//$('.right_edit_box#frien_final').fadeTo('fast', 0.5);
		}
	}, function() {
		if (!$(this).data('clicked')) {
			$(this).fadeTo('fast', 1);
			// $('.right_edit_box#frien_final').fadeTo('fast', 0, function() {
				// $(this).hide();
			// });
			$(this).find('div#click_edit').fadeOut('fast');
		}
	}).click(function() {
		$('input#pos').val('frien_f');
		$(this).find('div#click_edit').fadeOut('fast');
		$('.right_edit_box#frien_final').fadeTo('fast', 1);
		$(this).data('clicked', true);
		$('img#close_frien_final_edit').click(function() {
			$('.green_content#frien_final').fadeTo('fast', 1);
			$('.right_edit_box#frien_final').fadeOut('fast');
			$('.green_content#frien_final').data('clicked', false);
		});
	});
	
	
	$('.green_content#frien_welc').hover(function() {
		if (!$(this).data('clicked')) {
			$(this).data('clicked', false);
			$(this).fadeTo('fast', 0.6);
			$(this).find('div#click_edit').fadeIn('fast');
			//$('.right_edit_box#frien_welc').fadeTo('fast', 0.5);
		}
	}, function() {
		if (!$(this).data('clicked')) {
			if (!$('.right_edit_box#frien_welc').data('hovered')) {
				$(this).fadeTo('fast', 1);
				// $('.right_edit_box#frien_welc').fadeTo('fast', 0, function() {
					// $(this).hide();
				// });
				$(this).find('div#click_edit').fadeOut('fast');
			}
		}
	}).click(function() {
		$('input#pos').val('frien_wel');
		$(this).find('div#click_edit').fadeOut('fast');
		$('.right_edit_box#frien_welc').fadeTo('fast', 1);
		$(this).data('clicked', true);
		$('img#close_frien_welc_edit').click(function() {
			$('.green_content#frien_welc').fadeTo('fast', 1);
			$('.right_edit_box#frien_welc').fadeOut('fast');
			$('.green_content#frien_welc').data('clicked', false);
		});
	});
	
	
	
	$(function() {
			$(".frien_post_redemp#tabs").tabs();
			$(".cust_init#tabs").tabs();
			$(".cust_success#tabs").tabs();
			$(".header_message#tabs").tabs();
			$(".tool_tip[title]").tooltip({
	  			 // tweak the position
	   			offset: [15, -15],
				position: 'top right',
	   			// use the "slide" effect
	   			effect: 'slide'
				// add dynamic plugin with optional configuration for bottom edge
			}).dynamic({ bottom: { direction: 'down', bounce: true } });

	});
	
	var current_page = params_page;
	var last_page = 4;
	if (current_page == 1) {
		$('#prev').hide();
		$('#finish').hide();
		$('#next').show();
	} else if (current_page == last_page) {
		$('#prev').show();
		$('#finish').show();
		$('#next').hide();
	} else {
		$('#prev').show();
		$('#next').show();
		$('#finish').hide();
	}
	$('div.pre_pages').each(function() {
    	if ($(this).attr('page') == current_page) {
    		$(this).show();
    	}
    });
    $('span#' + current_page).attr('class', 'active num');
    $('#edit').click(function(event) {
    	event.preventDefault();
    	$('div.' + current_page).slideToggle('fast');
    	$('div.actions').slideToggle('fast');
    });
    
    function showBlock() {
		$("#block").show();
		$("#x").animate({
			fontSize: "100%"
		},300);
	
	$("#block").animate({
		    width: "35%",
			height:"35%",
		    opacity: 0.9,
		    left: "32.5%",
			top: "32.5%",
		    fontSize: "100%"
		}, 300 );
	}
	
	$("#x").click(function() {
		$("#x").animate({
			fontSize: "0px"
		},300);
		$("#block").animate({
			width: "0%",
			height:"0%",
	    	opacity: 0,
	    	left: "50%",
			top: "50%",
	    	fontSize: "0px"
		}, 300, function() {
			$("#block").hide();
		});
	});
	
	$("#ex1").click(function(event){
		event.preventDefault();
		$('p#ex').text("Free appetizer when you order an entree");
		showBlock();
	});
	
	$("#ex2").click(function(event){
		event.preventDefault();
		$('p#ex').text("Free glass of wine.");
		showBlock();
	});
	
	$("#ex3").click(function(event){
		event.preventDefault();
		$('p#ex').text("Enjoy a complimentary appetizer when you get any of our delicious entrees. Choose from eight great plates that can satiate any appetite.");
		showBlock();
	});
	
	$("#ex4").click(function(event){
		event.preventDefault();
		$('p#ex').text("Enjoy a complimentary glass of wine.  Choose any wine available by the glass.");
		showBlock();
	});
	
	$("#ex5").click(function(event){
		event.preventDefault();
		$('p#ex').text("Bonus cannot be used with other promotional offers, and must be redeemed at 28 5th Street location in Brooklyn, NY.");
		showBlock();
	});
	
	$("#ex6").click(function(event){
		event.preventDefault();
		$('p#ex').text("Bonus cannot be used with other promotional offers, and must be redeemed at 28 5th Street location in Brooklyn, NY.");
		showBlock();
	});
	
	$("#ex7").click(function(event){
		event.preventDefault();
		$('p#ex').text("Free glass of wine.");
		showBlock();
	});
	
	$("#ex8").click(function(event){
		event.preventDefault();
		$('p#ex').text("Enjoy a complimentary glass of wine.  Choose any wine available by the glass.");
		showBlock();
	});
	
	$("#ex9").click(function(event){
		event.preventDefault();
		$('p#ex').text("Bonus cannot be used with other promotional offers, and must be redeemed at 28 5th Street location in Brooklyn, NY.");
		showBlock();
	});

	
	$('span.num').click(function() {
    	current_page = $(this).attr('page_clicked');
    	$('span.num').attr('class','num');
   		$(this).attr('class', 'active num');
  		// $('div.pre_pages').each(function() {
			// if ($(this).attr('page') != current_page) {
    			// $(this).hide();
    		    // $('div.' + current_page).find('div').each(function() {
    				// $(this).hide();
    			// });
    		// } else {
    			// $(this).show();
    			// $('div.' + current_page).find('div').each(function() {
    				// $(this).show();
    			// });
    		// }
			// if (current_page == 1) {
				// $('#prev').hide();
			// } else {
				// $('#prev').show();
			// }
			// if (current_page == last_page) {
				// $('#next').hide();
			// } else {
				// $('#next').show();
			// }
		// });
		window.location = loc + current_page;
   	});
	
	$("#prev").click(function() {
    	$('#next').show();
    	current_page--;
    	// $('span.num').each(function() {
    		// if ($(this).attr('page_clicked') == current_page) {
    			// $(this).attr('class', 'active num');	
    		// } else {
    			// $(this).attr('class', 'num');
    		// }
    	// });
		// $('div.pre_pages').each(function() {
			// if ($(this).attr('page') != current_page) {
    			// $(this).hide();
    		    // $('div.' + current_page).find('div').each(function() {
    				// $(this).hide();
    			// });
    		// } else {
    			// $(this).show();
    			// $('div.' + current_page).find('div').each(function() {
    				// $(this).show();
    			// });
    		// }
			// if (current_page == 1) {
				// $('#prev').hide();
			// } else {
				// $('#prev').show();
			// }
		// });
		window.location = loc + current_page;
	});

	$("#next").click(function() {
		$('#prev').show();
		current_page++;
		// $('span.num').each(function() {
    		// if ($(this).attr('page_clicked') == current_page) {
    			// $(this).attr('class', 'active num');	
    		// } else {
    			// $(this).attr('class', 'num');
    		// }
    	// });
		// $('div.pre_pages').each(function() {
			// if ($(this).attr('page') != current_page) {
    			// $(this).hide();
    		    // $('div.' + current_page).find('div').each(function() {
    				// $(this).hide();
    			// });
    		// } else {
    			// $(this).show();
    			// $('div.' + current_page).find('div').each(function() {
    				// $(this).show();
    			// });
    		// }
			// if (current_page == last_page) {
				// $('#next').hide();
			// } else {
				// $('#next').show();
			// }
    	// });
    	window.location = loc + current_page;
	});
	
	if($('#campaign_give_cust_ref_sent:checked').length) { 
        	$(".a1 :input").attr('disabled', false);   
        } else { 
            $(".a1 :input").attr('disabled', true);
        } 
        $("#campaign_give_cust_ref_sent").click(function() { 
            if($('#campaign_give_cust_ref_sent:checked').length) { 
                $(".a1 :input").attr('disabled', false);
            } else { 
                $(".a1 :input").attr('disabled', true);
            } 
        }); 
        
      	if($('#campaign_give_cust_success:checked').length) { 
        	$(".a2 :input").attr('disabled', false);  
        } else { 
            $(".a2 :input").attr('disabled', true);  
        } 
        $("#campaign_give_cust_success").click(function() { 
            if($('#campaign_give_cust_success:checked').length) { 
                $(".a2 :input").attr('disabled', false);   
            } else { 
                $(".a2 :input").attr('disabled', true);  
            } 
        }); 
        
        if($('#campaign_give_frien:checked').length) { 
        	$(".a3 :input").attr('disabled', false);
        	$(".a3").attr('disabled', false);   
        } else { 
            $(".a3 :input").attr('disabled', true);
            $(".a3").attr('disabled', true);    
        } 
        $("#campaign_give_frien").click(function() { 
            if($('#campaign_give_frien:checked').length) { 
                $(".a3 :input").attr('disabled', false);
                $(".a3").attr('disabled', false);    
            } else { 
                $(".a3 :input").attr('disabled', true);
                $(".a3").attr('disabled', true);    
            } 
        });
        
        $('#campaign_cust_successful_incentive_long').focus(function() {
        	$(this).attr('rows', '9');
        });
        $('#campaign_cust_successful_incentive_long').blur(function() {
        	$(this).attr('rows', '5');
        });
        
        $('#campaign_cust_sent_incentive_long').focus(function() {
        	$(this).attr('rows', '9');
        });
        $('#campaign_cust_sent_incentive_long').blur(function() {
        	$(this).attr('rows', '5');
        });
        
     	// var maxChar1 = 40;
     	// var maxChar2 = 40;
     	// var maxChar3 = 120;
     	// var maxChar4 = 120;
		// var numChar1 = $("#campaign_cust_sent_incentive").val().length;
		// var numChar2 = $("#campaign_cust_successful_incentive").val().length;
		// var numChar3 = $("#campaign_cust_sent_incentive_long").val().length;
		// var numChar4 = $("#campaign_cust_successful_incentive_long").val().length;
		// $('#cust_sent_short_label').text((maxChar1-numChar1) + ' chars left');
		// $('#cust_successful_short_label').text((maxChar2-numChar2) + ' chars left');
		// $('#cust_sent_long_label').text((maxChar3-numChar3) + ' chars left');
		// $('#cust_successful_long_label').text((maxChar4-numChar4) + ' chars left');
// 
	// $('#campaign_cust_sent_incentive').keypress(function(event) {
	  // if (event.keyCode == '13') {
	     // event.preventDefault();
	   // }
	   // numChar1 = $(this).val().length;
	  // $('#cust_sent_short_label').text((maxChar1-numChar1) + ' chars left');
	  // if (numChar1 < 0) { numChar1 = 0; }
	   // if (numChar1 >= maxChar1 && event.which != 8 && event.which != 46 && (event.which > 40 || event.which < 37) && (!event.ctrlKey || event.which == 118)) {
	     // $('#cust_sent_short_label').text('0 chars left');
	     // event.preventDefault();
	     // $(this).val($(this).val().slice(0, maxChar1));
	   // } else {
	     // $('#cust_sent_short_label').text((maxChar1-numChar1) + ' chars left');
	   // }
	  // }); 
// 	  
	  // $('#campaign_cust_sent_incentive').keyup(function(event) {
	  // if (event.keyCode == '13') {
	     // event.preventDefault();
	   // }
	  // numChar1 = $(this).val().length;
	  // $('#cust_sent_short_label').text((maxChar1-numChar1) + ' chars left');
	  // if (numChar1 >= maxChar1 && event.which != 8 && event.which != 46 && (event.which > 40 || event.which < 37) && (!event.ctrlKey || event.which == 118)) { numChar1 = maxChar1; $(this).val($(this).val().slice(0, maxChar1)); }
	  // }); 
// 	  
// 	  
// 	  
	  // $('#campaign_cust_successful_incentive').keypress(function(event) {
	  // if (event.keyCode == '13') {
	     // event.preventDefault();
	   // }
	   // numChar2 = $(this).val().length;
	  // $('#cust_successful_short_label').text((maxChar2-numChar2) + ' chars left');
	  // if (numChar2 < 0) { numChar2 = 0; }
	   // if (numChar2 >= maxChar2&& event.which != 8 && event.which != 46 && (event.which > 40 || event.which < 37) && (!event.ctrlKey || event.which == 118)) {
	     // $('#cust_successful_short_label').text('0 chars left');
	     // event.preventDefault();
	     // $(this).val($(this).val().slice(0, maxChar2));
	   // } else {
	     // $('#cust_successful_short_label').text((maxChar2-numChar2) + ' chars left');
	   // }
	  // }); 
// 	  
	  // $('#campaign_cust_successful_incentive').keyup(function(event) {
	  // if (event.keyCode == '13') {
	     // event.preventDefault();
	   // }
	  // numChar2 = $(this).val().length;
	  // $('#cust_successful_short_label').text((maxChar2-numChar2) + ' chars left');
	  // if (numChar2 >= maxChar2 && event.which != 8 && event.which != 46 && (event.which > 40 || event.which < 37) && (!event.ctrlKey || event.which == 118)) { numChar2 = maxChar2; $(this).val($(this).val().slice(0, maxChar2)); }
	  // }); 
// 	  
// 	  
// 	  
	  // $('#campaign_cust_sent_incentive_long').keypress(function(event) {
	  // if (event.keyCode == '13') {
	     // event.preventDefault();
	   // }
	   // numChar3 = $(this).val().length;
	  // $('#cust_sent_long_label').text((maxChar3-numChar3) + ' chars left');
	  // if (numChar3 < 0) { numChar3 = 0; }
	   // if (numChar3 >= maxChar3 && event.which != 8 && event.which != 46 && (event.which > 40 || event.which < 37) && (!event.ctrlKey || event.which == 118)) {
	     // $('#cust_sent_long_label').text('0 chars left');
	     // event.preventDefault();
	     // $(this).val($(this).val().slice(0, maxChar3));
	   // } else {
	     // $('#cust_sent_long_label').text((maxChar3-numChar3) + ' chars left');
	   // }
	  // }); 
// 	  
	  // $('#campaign_cust_sent_incentive_long').keyup(function(event) {
	  // if (event.keyCode == '13') {
	     // event.preventDefault();
	   // }
	  // numChar3 = $(this).val().length;
	  // $('#cust_sent_long_label').text((maxChar3-numChar3) + ' chars left');
	  // if (numChar3 >= maxChar3 && event.which != 8 && event.which != 46 && (event.which > 40 || event.which < 37) && (!event.ctrlKey || event.which == 118)) { numChar3 = maxChar3; $(this).val($(this).val().slice(0, maxChar3)); }
	  // }); 
// 	  
// 	  
	  // $('#campaign_cust_successful_incentive_long').keypress(function(event) {
	  // if (event.keyCode == '13') {
	     // event.preventDefault();
	   // }
	   // numChar4 = $(this).val().length;
	  // $('#cust_successful_long_label').text((maxChar4-numChar4) + ' chars left');
	  // if (numChar4 < 0) { numChar4 = 0; }
	   // if (numChar4 >= maxChar4 && event.which != 8 && event.which != 46 && (event.which > 40 || event.which < 37) && (!event.ctrlKey || event.which == 118)) {
	     // $('#cust_successful_long_label').text('0 chars left');
	     // event.preventDefault();
	     // $(this).val($(this).val().slice(0, maxChar4));
	   // } else {
	     // $('#cust_successful_long_label').text((maxChar4-numChar4) + ' chars left');
	   // }
	  // }); 
//    
//     
    // $('#campaign_cust_successful_incentive_long').keyup(function(event) {
	  // if (event.keyCode == '13') {
	     // event.preventDefault();
	   // }
	  // numChar4 = $(this).val().length;
	  // $('#cust_successful_long_label').text((maxChar4-numChar4) + ' chars left');
	  // if (numChar4 >= maxChar4 && event.which != 8 && event.which != 46 && (event.which > 40 || event.which < 37) && (!event.ctrlKey || event.which == 118)) { numChar4 = maxChar4; $(this).val($(this).val().slice(0, maxChar4)); }
	  // }); 
// 	  

});
