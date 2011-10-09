// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
$.widget( "custom.catcomplete", $.ui.autocomplete, {
	_renderMenu: function( ul, items ) {
		var self = this,
			currentCategory = "";
		$.each( items, function( index, item ) {
			if ( item.category != currentCategory ) {
				ul.append( "<li class='autocomplete_category'>" + item.category + "</li>" );
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
			;
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
			$('#search_class').val(ui.item.search_class);
			$('#search_id').val(ui.item.id);
		}
	});
});

var gpsX1 = 130.0;
var gpsY1 = 40.0;
var gpsX2 = 0.0;
var gpsY2 = 0.0;
var markers = '';
var markersPrev = '';
var countMarkers = 0;

function inputMarker(lng, lat, icon, hasHtml, name, itemid) {
	markers = markersPrev;
	var comma = '';
	if (markers != '')
	comma = ', ';

	if (gpsX1 >= lng) gpsX1 = lng;
	if (gpsY1 >= lat) gpsY1 = lat;
	if (gpsX2 <= lng) gpsX2 = lng;
	if (gpsY2 <= lat) gpsY2 = lat;

	if (hasHtml) {

	 var content = "<h3 style=\'margin-top: 0px;\'>" + name + "<\/h3><a href=\'#pension-" + itemid + "\'>리스트로 바로가기<\/a>";
	}

	if (!content) {
	 markers += comma + '{ "latitude": ' + lat + ', "longitude": ' + lng + ', "icon": { "image": "/assets/map_pin_' + icon + '.png", "iconanchor": [12, 46], "infowindowanchor": [12, 0] } }';
	} else {
	 markers += comma + '{ "latitude": ' + lat + ', "longitude": ' + lng + ', "icon": { "image": "/assets/map_pin_' + icon + '.png", "iconanchor": [12, 46], "infowindowanchor": [12, 0] }, "html": "' + content + '" }';
	}
	countMarkers++;

	markersPrev = markers;
	if (countMarkers == 1) {
	 markers = markers + ', ' + markers;
	}
	markers = '[' + markers + ']';

	var jsonObj = jsonParse(markers);
	var zoom = parseInt(Math.sqrt((gpsY2-gpsY1)*10));
	var rev = (gpsY2-gpsY1)*0.5;
	if (rev == 0) {
	 zoom = -2;
	 rev = 0.015;
	}

	$("#map").gMap({
	 markers: jsonObj,
	 icon: { image: "/assets/map_pin_pension.png", iconanchor: [12, 46], infowindowanchor: [9, 2] },
	 latitude: gpsY2 + (gpsY1-gpsY2)/2 + rev,
	 longitude: gpsX1 + (gpsX2-gpsX1)/2,
	 zoom: 11 - zoom
	});
}

function inputMarkerByAddress(address, icon, hasHtml, name, itemid)
{
	geocoder = new GClientGeocoder();

	if(address != "") {
		// GPS 좌표 지정
		if (geocoder) {
			geocoder.getLatLng(
				address,
				function(point) {
					if (point) {
						inputMarker(point.lng(), point.lat(), icon, hasHtml, name, itemid)
					}
				}
			);
		}
	}
}

// 검은 막 관련
function showPathMap(sAddress, elng, elat, sText, eText){
	geocoder = new GClientGeocoder();

	if(sAddress != "") {
		// GPS 좌표 지정
		if (geocoder) {
			geocoder.getLatLng(
				sAddress,
				function(point) {
					if (!point) {
						alert("'"+sText + "'의 좌표를 찾지 못했습니다.");
					} else {
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
						$(".path-map").attr("src", "http://map.naver.com/?dlevel="+dlevel+"&lat=&lng=&slng="+point.lng()+"&slat="+point.lat()+"&elng="+elng+"&elat="+elat+"&pathType=0&dtPathType=2&menu=route&mapMode=0&sText="+sText+"&eText="+eText+"&");
					}
				}
			);
		}
	}
}


function showPathMapFromAddress(sAddress, eAddress, sText, eText){
	geocoder = new GClientGeocoder();
	geocoder2 = new GClientGeocoder();

	if(sAddress != "") {
		// GPS 좌표 지정
		if (geocoder) {
			geocoder.getLatLng(
				sAddress,
				function(point) {
					if (!point) {
						alert("'"+sText + "'의 좌표를 찾지 못했습니다.");
					} else {
						geocoder2.getLatLng(
							eAddress,
							function(point2) {
								if (!point2) {
									alert("'"+eText + "'의 좌표를 찾지 못했습니다.");
								} else {
															
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
									$(".path-map").attr("src", "http://map.naver.com/?dlevel="+dlevel+"&lat=&lng=&slng="+point.lng()+"&slat="+point.lat()+"&elng="+point2.lng()+"&elat="+point2.lat()+"&pathType=0&dtPathType=2&menu=route&mapMode=0&sText="+sText+"&eText="+eText+"&");
								}
							}
						);						
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
		$(this).next('ul').children('.toggle-list').toggleClass('hide');
	});

	// navi-landmarks 페이징 관련
	var nCountList = $(".spots-body > ul li").length;
	var len = 0;
	var nCurr = 0;
	var nPage = 1;
	while(nCurr < nCountList)
	{
		for(i = nCurr; i < nCountList; i++)
		{
			len += $("li:eq("+i+")", ".spots-body").width() + 10;
			if (len > 570)
			{
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
	if (nPage > 1)
	{
		$(".spots-body .next").removeClass("hidden");
		$(".spots-body .prev").removeClass("hidden");
	}

	$(".spots-body .next").click(function() {
		if (nCurr == nPage)
		{
			nCurr = 1;
		}
		else
		{
			nCurr++;
		}

		$("li", ".spots-body").addClass("hidden");
		$(".p"+nCurr, ".spots-body").removeClass("hidden");
	});
	$(".spots-body .prev").click(function() {
		if (nCurr == 1)
		{
			nCurr = nPage;
		}
		else
		{
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

	$("#map-toggle").click( function() {
		if ($("#openCloseIdentifier").is(":hidden")) {
			$(this).removeClass("open");
			$(this).animate({height: "65px"}, 0 );
			$(this).animate({marginTop: "310px"}, 0 );
			$("#map").animate({height: "65px"}, 300 );
			$(this).animate({marginTop: "0px"}, 300 );
			$("#map-rect").animate({height: "10px"}, 300 );
			$("#openCloseIdentifier").show();
		} else {
			$(this).animate({height: "10px"}, 0 );
			$(this).animate({marginTop: "60px"}, 0 );
			$("#map").animate({height: "365px"}, 300 );
			$(this).animate({marginTop: "355px"}, 300 );
			$("#map-rect").animate({height: "310px"}, 300 );
			$("#openCloseIdentifier").hide();
			$(this).addClass("open");
		}
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

});
