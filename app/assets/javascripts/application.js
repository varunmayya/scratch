// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .



var do_on_load = function() {  

	setTimeout(function(){$('.flash').hide()},3000);
	var container = document.querySelector('#container');
	var msnry = new Masonry( container, {
		  // options
		  columnWidth: 10,
		  itemSelector: '.note-card'
	});

	console.log('Modal registered');
	$('.modal').hide();
	$('.backdrop').hide();

	$('.open-modal, .backdrop').click(function() {
		$('.modal').fadeToggle(700);
		$('.backdrop').fadeToggle(700);
		$id = $(this).parent().parent().attr('id');
		$('input#note_id').val($id);
	});
	
	

};

        
    


$(document).ready(do_on_load);
$(window).bind('page:change', do_on_load);
