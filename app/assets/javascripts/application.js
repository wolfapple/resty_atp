// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .
$.widget( "custom.catcomplete", $.ui.autocomplete, {
	_renderMenu: function( ul, items ) {
		var self = this,
			currentCategory = "";
		$.each( items, function( index, item ) {
			if ( item.category != currentCategory ) {
				ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
				currentCategory = item.category;
			}
			self._renderItem( ul, item );
		});
	}
});

$(function(){
	//한글 처리
	$('#search_input').keydown(function() {
		if(event.keyCode == '38' || event.keyCode == '40') {
			$('#search_input').focus();
		}
	});
	var cache = {}, lastXhr;
	$('#search_input').catcomplete({
		source: function(request, response) {
			var term = request.term;
			if (term in cache) {
				response(cache[term]);
				return;
			}
			lastXhr = $.getJSON("/search/autocomplete", request, function(data, status, xhr) {
				cache[term] = data;
				if(xhr === lastXhr) {
					response( data );
				}
			});
		},
		select: function(event,ui) {
			$('#search_class').val(ui.item.class);
			$('#search_id').val(ui.item.id)
		}
	});
});