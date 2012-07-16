/*
 * Quiz plugin
 * all rights reserved
 * @author Sam Gallagher-Bishop & Frank Li
 * @updated Monday, Feb 27, 2012
*/
var answers_count = 20;
var answers = []; //this holds each answer, at the end we add up all the answers and get a result
var answers_text = ["We are going to find you a condo apartment!  You want the concierge, gym and underground parking.  You are willing to give up a certain “uniqueness” because you know that a condo apartment has the lowest days on market than the other two options and resale is important to you.  A view is also on your list of “want to have’s”.  Most of all, you are on the go and like being in the heart of the action; close to public transportation and near restaurants, bars and shopping.", 
	"You want me to find you a loft!  You are looking for something out of the ordinary, are willing to pay slightly more for it and know that there is a very specific buyer for resale of a loft.  You accept that many “hard” (authentic) lofts are built from old factories, and historically factories are on rail lines.  You love open spaces and embrace small imperfections as endearing to your living space, because with your decorating skills it will be a beautiful space!  You don’t really need amenities, but if your loft building has them, it is an added bonus.", 
	"A townhome is what you are looking for!  You are looking for the feel of a home, and are not yet ready to pay freehold home prices and/really want to want to live in an urban setting.  Maybe you have children and want to have an “upstairs” and “downstairs” feel to your home.  Or maybe you want a house and just don’t want to shovel the driveway.  You don’t need amenities and don’t necessarily want to pay the maintenance fees for features you won’t use."];
var answers_counter = [0,0,0];
var debug_mode = false; //for testing, displays variables inline
var slide_on_complete = true; //when finished, slide the quiz up 

var paginate = true; //will divide a question into multiple pages
var page_every = 5; //how many quiz questions per page
var pages = 1; //keeps track of the number of pages
var page_offset = 1; //keeps track of offset

$(document).ready(function () {
	for (var i = 0; i < answers_count; i++) {
		answers[i] = 0;
	}
	if (paginate) {
		$('div.field').each(function () {
			if ($(this).attr('question') > page_every) {
				$(this).hide();
			}
		});	
		pages = Math.ceil(answers.length / page_every)
		if (pages > 1) { //if there are most then one pages
			$('div.quiz_complete').hide();
			
			$('form').append('<span class="pages">0% 1 / ' + pages + ' pages</span> <a href="#" class="quiz_page_back">previous page</a> &nbsp;  <a href="#" class="quiz_page_next">next page</a>');
		}
		$('a.quiz_page_back').hide();
		$('a.quiz_page_next').click(function (event) {
			event.preventDefault();
			page_offset++;
			var temp_percent = (page_offset == 1)? '0' : Math.ceil(page_offset/pages*100);
			$('.pages').text(temp_percent + '%  ' + page_offset + ' / ' + pages + ' pages ');
			$('a.quiz_page_back').show();
			$('div.field').each(function () {
				if ($(this).attr('question') > (page_every * (page_offset - 1)) && $(this).attr('question') <= (page_every * page_offset) ) {
					$(this).show();
				} else {
					$(this).hide();
				}
			});
			if (page_offset >= pages) { //show the submit
				$('div.quiz_complete').show();
				$('a.quiz_page_next').hide();
			}
		});
		$('a.quiz_page_back').click(function (event) {
			event.preventDefault();
			page_offset--;
			var temp_percent = (page_offset == 1)? '0' : Math.ceil(page_offset/pages*100);
			$('.pages').text(temp_percent + '%  ' + page_offset + ' / ' + pages + ' pages ');
			$('a.quiz_page_next').show();
			$('div.field').each(function () {
				if ($(this).attr('question') > (page_every * (page_offset - 1)) && $(this).attr('question') <= (page_every * page_offset) ) {
					$(this).show();
				} else {
					$(this).hide();
				}
			});
			if (page_offset < pages) { //show the submit
				$('div.quiz_complete').hide();
			}
			if (page_offset == 1) $('a.quiz_page_back').hide();
		});
	}
	$('input[type="radio"]').change(function () {
		var question_number = parseInt($(this).attr('name').substr(1), 10);
		answers[question_number - 1] = parseInt($(this).val(), 10); // -1 because question 1 corresponds to array position 0
		if (debug_mode) {
			$('div.quiz_values').remove();
			$('form').prepend('<div class="quiz_values"><small>(set debug_mode = false to hide this)</small> ' + answers.toSource() + '</div>');
		}
	});

	$('input[type="submit"]').click(function (event) {
		event.preventDefault(); //stops the form from being submitted
		answers_counter = [0, 0, 0];
		for (var i = 0; i < answers.length; i++) { //get the most common value in the array
			answers_counter[answers[i]]++; //increment counter
		}
		var most_common = 0; //temp var to find our best answer
		var most_common_count = answers_counter[0]; //number of occurences of that answer
		for (var i = 1; i < answers_counter.length; i++) { //loop through our counter to find the largest value
			if (answers_counter[i] > most_common_count) { //if the current int is more picked, update our best answer
				most_common = i;
				most_common_count = answers_counter[i];
			}
		}
		if (debug_mode) {
			$('div.quiz_values').remove();
			$('form').prepend('<div class="quiz_values"><small>(set debug_mode = false to hide this)</small> ' + 'counter: ' + answers_counter.toSource() + ', most picked: ' + most_common + ', most common count: ' + most_common_count + '</div>');
		}
		$('.answer').remove();
		$('form').after('<div class="answer">' + answers_text[most_common] + '</div>');
		if (slide_on_complete) {
			$('form').slideUp();
			$('form').parent().append('<a href="#" class="quiz_retry" >try quiz again</a>');
			$('a.quiz_retry').click(function (event) {
				event.preventDefault();
				$('form').slideDown();
				$('.answer').remove();
				$('.quiz_retry').remove();
				$('input[type="radio"]').each(function () {
					$(this).prop('checked', false);
				});
				if (paginate) { //reset current page
					page_offset = 1;
					$('div.field').each(function () {
						if ($(this).attr('question') > page_every) {
							$(this).hide();
						} else {
							$(this).show();
						}
					});
					$('div.quiz_complete').hide();
					$('a.quiz_page_back').hide();
					$('a.quiz_page_next').show();
					var temp_percent = (page_offset == 1)? '0' : Math.ceil(page_offset/pages*100);
					$('.pages').text(temp_percent + '%  ' + page_offset + ' / ' + pages + ' pages ');
				}
			});
		}
	});
});
