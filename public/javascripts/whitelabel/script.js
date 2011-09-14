$(document).ready(function() {
	
	//for Caching
	var $content = $('#content');
		
		/*----------------------------------------------------------------------*/
		/* Navigation Stuff
		/*----------------------------------------------------------------------*/
		
		
		//Top Pageoptions
		$('#wl_config').click(function(){
			var $pageoptions = $('#pageoptions');
			if($pageoptions.height() < 200){
				$pageoptions.animate({'height':200});
				$(this).addClass('active');
			}else{
				$pageoptions.animate({'height':20});
				$(this).removeClass('active');
			}
			return false;
		});
		
		
		//Header navigation for smaller screens
		var $headernav = $('ul#headernav');
		
		$headernav.bind('click',function(){
			//if(window.innerWidth > 800) return false;
			var ul = $headernav.find('ul').eq(0);
			(ul.is(':hidden')) ? ul.addClass('shown') : ul.removeClass('shown');
		});
		
		$headernav.find('ul > li').bind('click',function(event){
			event.stopPropagation();
			var children = $(this).children('ul');
			
			if(children.length){
				(children.is(':hidden')) ? children.addClass('shown') : children.removeClass('shown');
			}
		});
		
		//Search Field Stuff		
		var $searchform = $('#searchform'),
			$searchfield = $('#search');
		
		$searchfield
			.bind('focus.wl',function(){
		   		$searchfield.parent().animate({width: '150px'},100).select();
			})
			.bind('blur.wl',function(){
	   			$searchfield.parent().animate({width: '90px'},100);
			});
			
		$searchform
			.bind('submit.wl',function(){
				//do something on submit				
				var query = $searchfield.val();
			});
			
		
		//Main Navigation		
		var $nav = $('#nav');
			
		$nav.delegate('li','click.wl', function(event){
			var _this = $(this),
				_parent = _this.parent(),
				a = _parent.find('a');
			_parent.find('ul').slideUp('fast');
			a.removeClass('active');
			_this.find('ul:hidden').slideDown('fast');
			_this.find('a').eq(0).addClass('active');
			event.stopPropagation();
		});
		
		/*----------------------------------------------------------------------*/
		/* Helpers
		/*----------------------------------------------------------------------*/
		
		//placholder in inputs is not implemented well in all browsers, so we need to trick this		
		$("[placeholder]").bind('focus.placeholder',function() {
			var el = $(this);
			if (el.val() == el.attr("placeholder") && !el.data('uservalue')) {
				el.val("");
				el.removeClass("placeholder");
			}
		}).bind('blur.placeholder',function() {
			var el = $(this);
			if (el.val() == "" || el.val() == el.attr("placeholder") && !el.data('uservalue')) {
				el.addClass("placeholder");
				el.val(el.attr("placeholder"));
				el.data("uservalue",false);
			}else{
			
			}
		}).bind('keyup.placeholder',function() {
			var el = $(this);
			if (el.val() == "") {
				el.data("uservalue",false);
			}else{
				el.data("uservalue",true);
			}
		}).trigger('blur.placeholder');

});

