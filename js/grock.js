$(function() {
	$('.disc').css('opacity', 0);
	$('.disc').on('inview', function(event, isInView, visiblePartX, visiblePartY) {
		if (isInView && visiblePartY == 'both') {
			$(this).css('background-image', "url('" + $(this).attr('data-grock-img') + "')");
			$(this).stop().animate({opacity: 1}, 800);
		}
	});

	$(".disc").click(function() {
		var $modal = $('[data-remodal-id=modal]');
		$modal.find("#disc-modal-title").text($(this).attr('data-grock-title'));
		$modal.find("#disc-modal-band").text($(this).attr('data-grock-band'));
		$modal.find("#disc-modal-label").text($(this).attr('data-grock-label'));
		$modal.find("img").attr('src', $(this).attr('data-grock-img'));

		var listen = $(this).attr('data-grock-listen');
		if (listen == '') {
			$modal.find(".listen").hide();
		} else {
			$modal.find(".listen").show().attr('href', listen);
		}

		var listen = $(this).attr('data-grock-free');
		if (listen == '') {
			$modal.find(".free").hide();
		} else {
			$modal.find(".free").show().attr('href', listen);
		}

		var itunes = $(this).attr('data-grock-itunes');
		if (itunes == '') {
			$modal.find(".itunes").hide();
		} else {
			$modal.find(".itunes").show().attr('href', itunes);
		}

		var amazon = $(this).attr('data-grock-amazon');
		if (amazon == '') {
			$modal.find(".amazon").hide();
		} else {
			$modal.find(".amazon").show().attr('href', amazon);
		}

		$modal.remodal({}).open();
	});
});