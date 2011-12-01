// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require_tree .
$(document).ready(function() {
	//검색버튼
	$('#search-btn').live('click', function() {
		$('#search-bar h3').trigger('click');
	});
	$('#search-form').submit(function() {
		event.preventDefault();
		addr = $('#search-input').val();
		if(!addr) {
	  	alert('검색어를 입력해 주세요.');
	  }
		else {
			key = 'SCZCvtrV34ErTv2a2ZdLauxFfsqApLenIVjl3Y.JdtAiB36Njp4Pv9VXHnbQ9fkNMg--'
			$.getJSON('http://kr.open.gugi.yahoo.com/service/poi.php?callback=?',
				{appid:key, q:$.trim(addr.replace('펜션', '').replace('팬션', '')), encoding:'utf-8', output:'json', results:1},
				function(data) {
					if(data.ResultSet.head.Error == 0 && data.ResultSet.head.Found > 0) {
						$('#longitude-hidden').val(data.ResultSet.locations.item[0].longitude);
						$('#latitude-hidden').val(data.ResultSet.locations.item[0].latitude);
						$('#search-form').submit();
					}
					else {
						$('#search-form').submit();
					}
				}
			);
		}
	});
});

function moveAds() {
	$('#adsense_hidden iframe').appendTo('#adsense');
	$('#adsense_hidden').remove();
}