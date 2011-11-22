// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
var gpsX1 = 130.0;
var gpsY1 = 40.0;
var gpsX2 = 0.0;
var gpsY2 = 0.0;
var markers = '';
var countMarkers = 0;

function highlight_pension(itemid) {
	$('#pension-'+itemid).effect("highlight", {}, 3000);
}

function inputMarker(lng, lat, icon, hasHtml, name, itemid) {
	var comma = '';
	if (markers != '')
	comma = ', ';

	if (gpsX1 >= lng) gpsX1 = lng;
	if (gpsY1 >= lat) gpsY1 = lat;
	if (gpsX2 <= lng) gpsX2 = lng;
	if (gpsY2 <= lat) gpsY2 = lat;

	if (hasHtml) {
	 var content = "<h3 style=\'margin-top: 0px;\'>" + name + "<\/h3><a href=\'#pension-" + itemid + "\' onclick=\'highlight_pension("+itemid+")\'>리스트로 바로가기<\/a>";
	}

	if (!content) {
	 //markers += comma + '{ "latitude": ' + lat + ', "longitude": ' + lng + ', "icon": { "image": "/assets/map_pin_' + icon + '.png", "iconanchor": [12, 46], "infowindowanchor": [12, 0] } }';
	markers += comma + '{ "latitude": ' + lat + ', "longitude": ' + lng + '}';
	} else {
	 //markers += comma + '{ "latitude": ' + lat + ', "longitude": ' + lng + ', "icon": { "image": "/assets/map_pin_' + icon + '.png", "iconanchor": [12, 46], "infowindowanchor": [12, 0] }, "html": "' + content + '" }';
	markers += comma + '{ "latitude": ' + lat + ', "longitude": ' + lng + ', "html": "' + content + '" }';
	}
	countMarkers++;
}

function inputMarkerByAddress(address, icon, hasHtml, name, itemid)
{
	geocoder = new google.maps.Geocoder();

	if(address != "") {
		// GPS 좌표 지정
		if (geocoder) {
			geocoder.geocode({'address':address}, function(results, status) {
				if (status == google.maps.GeocoderStatus.OK) {
					inputMarker(results[0].geometry.location.lng(), results[0].geometry.location.lat(), icon, hasHtml, name, itemid);
				}
			});
		}
	}
}

// 검은 막 관련
function showPathMap(sAddress, elng, elat, sText, eText){
	geocoder = new google.maps.Geocoder();

	if(sAddress != "") {
		// GPS 좌표 지정
		if (geocoder) {
			geocoder.geocode({'address':sAddress}, function(results, status) {
				if (status == google.maps.GeocoderStatus.OK) {
					var dlevel = 4;
					//화면의 높이와 너비를 구한다.
					if ($(".window").outerHeight() < $(document).height() )
						$(".window").css("margin-top", "-" + $(".window").outerHeight()/2+"px");
					else
						$(".window").css("top", "0px");
					if ($(".window").outerWidth() < $(document).width() )
						$(".window").css("margin-left", "-" + $(".window").outerWidth()/2+"px");
					else
						$(".window").css("left", "0px");

					var maskHeight = $(document).height();
					var maskWidth = $(window).width();

					$("#mask").css({"width": maskWidth, "height": maskHeight});
					$("#mask").fadeTo("slow", 0.8);

					$(".window").show();
					$(".path-map").attr("src", "http://map.naver.com/?dlevel="+dlevel+"&lat=&lng=&slng="+results[0].geometry.location.lng()+"&slat="+results[0].geometry.location.lat()+"&elng="+elng+"&elat="+elat+"&pathType=0&dtPathType=2&menu=route&mapMode=0&sText="+sText+"&eText="+eText+"&");
				}
				else {
					alert("'"+sText + "'의 좌표를 찾지 못했습니다.");
				}
			});
		}
	}
}


function showPathMapFromAddress(sAddress, eAddress, sText, eText){
	geocoder = new google.maps.Geocoder();
	geocoder2 = new google.maps.Geocoder();

	if(sAddress != "") {
		// GPS 좌표 지정
		if (geocoder) {
			geocoder.geocode({'address':sAddress},
				function(results, status) {
					if (status == google.maps.GeocoderStatus.OK) {
						geocoder2.geocode({'address':eAddress},
							function(results, status) {
								if (status == google.maps.GeocoderStatus.OK) {
									var dlevel = 4;
									//화면의 높이와 너비를 구한다.
									if ($(".window").outerHeight() < $(document).height() )
										$(".window").css("margin-top", "-" + $(".window").outerHeight()/2+"px");
									else
										$(".window").css("top", "0px");
									if ($(".window").outerWidth() < $(document).width() )
										$(".window").css("margin-left", "-" + $(".window").outerWidth()/2+"px");
									else
										$(".window").css("left", "0px");

									var maskHeight = $(document).height();
									var maskWidth = $(window).width();
									
									$("#mask").css({"width": maskWidth, "height": maskHeight});
									$("#mask").fadeTo("slow", 0.8);
									
									$(".window").show();
									$(".path-map").attr("src", "http://map.naver.com/?dlevel="+dlevel+"&lat=&lng=&slng="+results[0].geometry.location.lng()+"&slat="+results[0].geometry.location.lat()+"&elng="+point2.lng()+"&elat="+point2.lat()+"&pathType=0&dtPathType=2&menu=route&mapMode=0&sText="+sText+"&eText="+eText+"&");
								}
								else {
									alert("'"+eText + "'의 좌표를 찾지 못했습니다.");
								}
							}
						);
					}
					else {
						alert("'"+sText + "'의 좌표를 찾지 못했습니다.");
					}
				}
			);
		}
	}
	else {
		alert("출발지를 입력해 주세요!");
	}
}

$(document).ready(function() {
	// 사이드바 more/less
	$('#sidebar h3').click(function() {
		$(this).toggleClass('hide');
		$(this).next('ul').children('.toggle-list').slideToggle(200);
	});

	// navi-landmarks 페이징 관련
	$(".spots-body").show();
	var nCountList = $(".spots-body > ul li").length;
	var len = 0;
	var nCurr = 0;
	var nPage = 1;
	while(nCurr < nCountList) {
		for(i = nCurr; i < nCountList; i++) {
			len += $("li:eq("+i+")", ".spots-body").width() + 10;
			if (len > 570) {
				nPage++;
				len = 0;
				break;
			}
			$("li:eq("+i+")", ".spots-body").addClass("p"+nPage);
			if(nPage > 1)
				$("li:eq("+i+")", ".spots-body").addClass("hidden");
			nCurr++;
		}
	}

	nCurr = 1;
	if (nPage > 1) {
		$(".spots-body .next").removeClass("hidden");
		$(".spots-body .prev").removeClass("hidden");
	}

	$(".spots-body .next").click(function() {
		if (nCurr == nPage) {
			nCurr = 1;
		}
		else {
			nCurr++;
		}
		$("li", ".spots-body").addClass("hidden");
		$(".p"+nCurr, ".spots-body").removeClass("hidden");
	});
	$(".spots-body .prev").click(function() {
		if (nCurr == 1) {
			nCurr = nPage;
		}
		else {
			nCurr--;
		}
		$("li", ".spots-body").addClass("hidden");
		$(".p"+nCurr, ".spots-body").removeClass("hidden");
	});

	// spot 더보기 관련
	$("#spot-info-more").click(function() {
		$("#spot-info-sum").addClass("hide");
		$("#spot-info-all").removeClass("hide");
	});
	$("#spot-info-less").click(function() {
		$("#spot-info-sum").removeClass("hide");
		$("#spot-info-all").addClass("hide");
	});
	
	// 검은 막 띄우기 관련
	$(window).resize(function() {
		$("#mask").css({"width": $(window).width()});
	});

	$(window).scroll(function() {
		$(".window").animate({"top" : $(".window").height()/2+$(window).scrollTop()+20+"px"}, 0);
	});

	$(".searchByGPS").click(function(e) {
		e.preventDefault();
		showPathMap($("#findway-word").attr("value"), $("#info-gps-x").text(), $("#info-gps-y").text(), $("#findway-word").attr("value"), $("h2").text());
	}); 
	
	$(".searchByAddress").click(function(e) {
		e.preventDefault();
		showPathMapFromAddress($("#findway-word").attr("value"), $("#spot-info-addr, #pension-info-addr").text(), $("#findway-word").attr("value"), $("h2").text());
	}); 
	
	$(".window .close").click(function(e) {
		e.preventDefault();
		$("#mask, .window").hide();
	}); 
	
	$("#mask").click(function() {
		$(this).hide();
		$(".window").hide();
	});
	// 지역 검색
	$('#search_button').click(function() {
		if(!$('#search_input').val() || $('#search_input').val() == '지역,펜션,여행지명으로 검색하세요.') {
			alert('검색어를 입력해 주세요.');
		}
 		else {
			addr = $('#search_input').val();
			key = 'SCZCvtrV34ErTv2a2ZdLauxFfsqApLenIVjl3Y.JdtAiB36Njp4Pv9VXHnbQ9fkNMg--'
			$.getJSON('http://kr.open.gugi.yahoo.com/service/poi.php?callback=?',
				{appid:key, q:$.trim(addr.replace('펜션', '').replace('팬션', '')), encoding:'utf-8', output:'json', results:1},
				function(data) {
					if(data.ResultSet.head.Error == 0 && data.ResultSet.head.Found > 0) {
						$('#address').val(addr);
						$('#longitude').val(data.ResultSet.locations.item[0].longitude);
						$('#latitude').val(data.ResultSet.locations.item[0].latitude);
						$('#search_box form').submit();
					}
					else {
						$('#address').val(addr);
						$('#search_box form').submit();
					}
				}
			);
		}
	});
	$('#search_input').keydown(function(event) {
		if(event.keyCode == '13') {
			$('#search_button').trigger('click');
		}
	});
});
