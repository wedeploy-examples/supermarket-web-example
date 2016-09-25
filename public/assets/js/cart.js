var cartWrapper = $('.cd-cart-container');
var productId = '';
if( cartWrapper.length > 0 ) {
	//store jQuery objects
	var cartBody = cartWrapper.find('.body')
	var cartList = cartBody.find('ul').eq(0);
	var cartTotal = cartWrapper.find('.checkout').find('span');
	var cartTrigger = cartWrapper.children('.cd-cart-trigger');
	var cartCount = cartTrigger.children('.count')
	var undoTimeoutId;
	var undo = cartWrapper.find('.undo');
}

function initCart() {

	var addToCartBtn = $('.cd-add-to-cart');

	//add product to cart
	addToCartBtn.on('click', function(event){
		console.log('add');
		event.preventDefault();
		addToCart($(this));
	});

	//open/close cart
	cartTrigger.on('click', function(event){
		event.preventDefault();
		toggleCart();
	});

	//close cart when clicking on the .cd-cart-container::before (bg layer)
	cartWrapper.on('click', function(event){
		if( $(event.target).is($(this)) ) toggleCart(true);
	});

	//delete an item from the cart
	cartList.on('click', '.delete-item', function(event){
		event.preventDefault();
		removeProduct($(event.target).parents('.product'));
	});

	//update item quantity
	cartList.on('change', 'select', function(event){
		quickUpdateCart();
	});

	//reinsert item deleted from the cart
	undo.on('click', 'a', function(event){
		clearInterval(undoTimeoutId);
		event.preventDefault();
		cartList.find('.deleted').addClass('undo-deleted').one('webkitAnimationEnd oanimationend msAnimationEnd animationend', function(){
			$(this).off('webkitAnimationEnd oanimationend msAnimationEnd animationend').removeClass('deleted undo-deleted').removeAttr('style');
			quickUpdateCart();
		});
		undo.removeClass('visible');
	});
	
}

function toggleCart(bool) {
	var cartIsOpen = ( typeof bool === 'undefined' ) ? cartWrapper.hasClass('cart-open') : bool;
	
	if( cartIsOpen ) {
		cartWrapper.removeClass('cart-open');
		//reset undo
		clearInterval(undoTimeoutId);
		undo.removeClass('visible');
		cartList.find('.deleted').remove();

		setTimeout(function(){
			cartBody.scrollTop(0);
			//check if cart empty to hide it
			if( Number(cartCount.find('li').eq(0).text()) == 0) cartWrapper.addClass('empty');
		}, 500);
	} else {
		cartWrapper.addClass('cart-open');
	}
}

function addToCart(trigger) {
	var cartIsEmpty = cartWrapper.hasClass('empty');
	//update cart product list
	addProduct(trigger.data('id'), trigger.data('name'), trigger.data('price'), trigger.data('image'));
	//update number of items 
	updateCartCount(cartIsEmpty);
	//update total price
	updateCartTotal(trigger.data('price'), true);
	//show cart
	cartWrapper.removeClass('empty');
}

function addProduct(id, name, price, image) {

	var htmlProduct = '';
	htmlProduct += '<li class="product">';
	htmlProduct += '<div class="product-image">';
	htmlProduct += '<img src="' + image + '" alt="placeholder">';
	htmlProduct += '</div>';
	htmlProduct += '<div class="product-details">';
	htmlProduct += '<h3>' + name + '</h3>';
	htmlProduct += '<span class="price">$' + price + ' </span>';
	htmlProduct += '<div class="actions">';
	htmlProduct += '<a href="#0" class="delete-item">Delete</a>';
	htmlProduct += '<div class="quantity">';
	htmlProduct += '<label for="cd-product-'+ id +'">Qty</label>';
	htmlProduct += '<span class="select">';
	htmlProduct += '<select id="cd-product-'+ id +'" name="quantity">';
	htmlProduct += '<option value="1">1</option>';
	htmlProduct += '<option value="2">2</option>';
	htmlProduct += '<option value="3">3</option>';
	htmlProduct += '<option value="4">4</option>';
	htmlProduct += '<option value="5">5</option>';
	htmlProduct += '</select>';
	htmlProduct += '</span>';
	htmlProduct += '</div>';
	htmlProduct += '</div>';
	htmlProduct += '</div>';
	htmlProduct += '</li>';

	var productAdded = $(htmlProduct);
	cartList.prepend(productAdded);
}

function removeProduct(product) {
	clearInterval(undoTimeoutId);
	cartList.find('.deleted').remove();
	
	var topPosition = product.offset().top - cartBody.children('ul').offset().top ,
		productQuantity = Number(product.find('.quantity').find('select').val()),
		productTotPrice = Number(product.find('.price').text().replace('$', '')) * productQuantity;
	
	product.css('top', topPosition+'px').addClass('deleted');

	//update items count + total price
	updateCartTotal(productTotPrice, false);
	updateCartCount(true, -productQuantity);
	undo.addClass('visible');

	//wait 8sec before completely remove the item
	undoTimeoutId = setTimeout(function(){
		undo.removeClass('visible');
		cartList.find('.deleted').remove();
	}, 8000);
}

function quickUpdateCart() {
	var quantity = 0;
	var price = 0;
	
	cartList.children('li:not(.deleted)').each(function(){
		var singleQuantity = Number($(this).find('select').val());
		quantity = quantity + singleQuantity;
		price = price + singleQuantity*Number($(this).find('.price').text().replace('$', ''));
	});

	cartTotal.text(price.toFixed(2));
	cartCount.find('li').eq(0).text(quantity);
	cartCount.find('li').eq(1).text(quantity+1);
}

function updateCartCount(emptyCart, quantity) {
	if( typeof quantity === 'undefined' ) {
		var actual = Number(cartCount.find('li').eq(0).text()) + 1;
		var next = actual + 1;
		
		if( emptyCart ) {
			cartCount.find('li').eq(0).text(actual);
			cartCount.find('li').eq(1).text(next);
		} else {
			cartCount.addClass('update-count');

			setTimeout(function() {
				cartCount.find('li').eq(0).text(actual);
			}, 150);

			setTimeout(function() {
				cartCount.removeClass('update-count');
			}, 200);

			setTimeout(function() {
				cartCount.find('li').eq(1).text(next);
			}, 230);
		}
	} else {
		var actual = Number(cartCount.find('li').eq(0).text()) + quantity;
		var next = actual + 1;
		
		cartCount.find('li').eq(0).text(actual);
		cartCount.find('li').eq(1).text(next);
	}
}

function updateCartTotal(price, bool) {
	bool ? cartTotal.text( (Number(cartTotal.text()) + Number(price)).toFixed(2) )  : cartTotal.text( (Number(cartTotal.text()) - Number(price)).toFixed(2) );
}
