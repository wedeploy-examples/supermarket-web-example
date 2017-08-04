package io.wedeploy.supermarket.cart;

import io.wedeploy.supermarket.cart.model.CartProduct;

/**
 * @author Silvio Santos
 */
public interface DeleteFromCartListener {

	void onDeleteFromCart(CartProduct cartProduct);

}
