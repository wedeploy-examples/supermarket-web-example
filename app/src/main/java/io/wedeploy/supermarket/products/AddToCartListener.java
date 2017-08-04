package io.wedeploy.supermarket.products;

import io.wedeploy.supermarket.products.model.Product;

/**
 * @author Silvio Santos
 */
public interface AddToCartListener {

	void onItemAddedToCart(Product product);

}
