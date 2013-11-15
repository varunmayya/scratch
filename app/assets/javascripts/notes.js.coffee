# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


var do_on_load = function() {  

	setTimeout(function(){$('.flash').hide()},3000);
	var container = document.querySelector('#container');
	var msnry = new Masonry( container, {
		  // options
		  columnWidth: 10,
		  itemSelector: '.note-card'
	});
	

};

        
    


$(document).ready(do_on_load);
$(window).bind('page:change', do_on_load);
