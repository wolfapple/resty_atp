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
var countMarkers = 0;

function inputMarker(lng, lat, icon, hasHtml, name)
{
	var comma = '';
	if (markers != '')
	comma = ', ';

	if (gpsX1 >= lng)	gpsX1 = lng;
	if (gpsY1 >= lat)	gpsY1 = lat;
	if (gpsX2 <= lng)	gpsX2 = lng;
	if (gpsY2 <= lat)	gpsY2 = lat;

	if (hasHtml) {
		var content = "<h3 style=\'margin-top: 0px;\'>" + name + "<\/h3>";
	}

	if (!content) {
		markers += comma + '{ "latitude": ' + lat + ', "longitude": ' + lng + ', "icon": { "image": "/assets/map_pin_' + icon + '.png", "iconanchor": [12, 46],	"infowindowanchor": [12, 0] } }';
	} else {
		markers += comma + '{ "latitude": ' + lat + ', "longitude": ' + lng + ', "icon": { "image": "/assets/map_pin_' + icon + '.png", "iconanchor": [12, 46],	"infowindowanchor": [12, 0] }, "html": "' + content + '" }';
	}
	countMarkers++;
};

// 검은 막 관련
function showPathMap(slng, slat, elng, elat, sText, eText){
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
	$(".path-map").attr("src", "http://map.naver.com/?dlevel="+dlevel+"&lat=&lng=&slng="+slng+"&slat="+slat+"&elng="+elng+"&elat="+elat+"&pathType=0&dtPathType=2&menu=route&mapMode=0&sText="+sText+"&eText="+eText+"&");
}

$(document).ready(function() {

	// 라디오버튼 모양 변경
	$("span[class='radio']").addClass("unchecked");
	$("input[checked='checked'][type='radio']").parent().addClass("checked");
	$("input[checked='checked'][type='radio']").parent().removeClass("unchecked");

	$(".radio").click(function() {
		$("input[name='"+$(this).children("input").attr("name")+"']").attr({checked: ""});
		$("input[name='"+$(this).children("input").attr("name")+"']").parent().addClass("unchecked");
		if ($(this).children("input").attr("checked")) {
			$(this).children("input").attr({checked: ""});
			$(this).removeClass("checked");
			$(this).addClass("unchecked");
		} else {
			$(this).children("input").attr({checked: "checked"});
			$(this).removeClass("unchecked");
			$(this).addClass("checked");
		}
	});

	// 체크박스 모양 변경
	$("span[class='checkbox']").addClass("unchecked");
	$("input[checked='checked'][type='checkbox']").parent().addClass("checked");
	$("input[checked='checked'][type='checkbox']").parent().removeClass("unchecked");

	$(".checkbox").click(function() {
		if($(this).children("input").attr("checked")) {
			$(this).children("input").attr({checked: ""});
			$(this).removeClass("checked");
			$(this).addClass("unchecked");
		} else {
			$(this).children("input").attr({checked: "checked"});
			$(this).removeClass("unchecked");
			$(this).addClass("checked");
		}
	});

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


	// review 더보기 관련
	$("#review-more").click(function() {
		if ($(".reviews").hasClass("hide")) {
			$(".reviews").removeClass("hide");
			$(this).addClass("open");
		} else {
			$(".reviews").addClass("hide");
			$(this).removeClass("open");
		}
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


	// 지도 관련
	if (countMarkers > 0) {
		if (countMarkers == 1) {
			markers = markers + ', ' + markers;
		}
		markers = '[' + markers + ']';

		var jsonObj = jsonParse(markers);
		var zoom = parseInt(Math.sqrt((gpsY2-gpsY1)*10));
		var rev = (gpsY2-gpsY1)*0.7;
		if (rev == 0) {
			zoom = -2;
			rev = 0.015;
		}
		
		$("#map").gMap({
			markers: jsonObj,
			icon: { image: "/assets/map_pin_pension.png", iconanchor: [12, 46],	infowindowanchor: [9, 2] },
			latitude: gpsY2 + (gpsY1-gpsY2)/2 + rev,
			longitude: gpsX1 + (gpsX2-gpsX1)/2,
			zoom: 11 - zoom
		});
	}
	else {
		if ($("#map").length > 0) {
			$("#map").gMap({
				icon: { image: "/assets/map_pin_pension.png", iconanchor: [12, 46],	infowindowanchor: [9, 2] },
				latitude: 37.3404259,
				longitude: 127.1081021,
				zoom: 16 });
		}
	}

	$("#map-toggle").click( function() {
		if ($("#openCloseIdentifier").is(":hidden")) {
			$(this).removeClass("open");
			$(this).animate({height: "65px"}, 0 );
			$(this).animate({marginTop: "210px"}, 0 );
			$("#map").animate({height: "65px"}, 300 );
			$(this).animate({marginTop: "0px"}, 300 );
			$("#map-rect").animate({height: "10px"}, 300 );
			$("#openCloseIdentifier").show();
		} else {
			$(this).animate({height: "10px"}, 0 );
			$(this).animate({marginTop: "60px"}, 0 );
			$("#map").animate({height: "265px"}, 300 );
			$(this).animate({marginTop: "255px"}, 300 );
			$("#map-rect").animate({height: "210px"}, 300 );
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

	$(".openMask").click(function(e) {
		e.preventDefault();
		showPathMap(127.1089935, 37.3398399, 126.3430618, 36.5068456, "오리역 분당선", "안면도펜션");
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

