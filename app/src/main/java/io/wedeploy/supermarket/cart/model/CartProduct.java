package io.wedeploy.supermarket.cart.model;

import org.json.JSONObject;

/**
 * @author Silvio Santos
 */
public class CartProduct {

	public CartProduct(JSONObject jsonObject) {
		id = jsonObject.optString("id", "");
		productFilename = jsonObject.optString("productFilename", "");
		productPrice = jsonObject.optDouble("productPrice", 0);
		productTitle = jsonObject.optString("productTitle", "");
	}

	public String getImageUrl() {
		return "https://ui-supermarket.wedeploy.sh/assets/images/" + productFilename;
	}

	public double getProductPrice() {
		return productPrice;
	}

	public String getProductTitle() {
		return productTitle;
	}

	public String getId() {
		return id;
	}

	private final String id;
	private final String productFilename;
	private final double productPrice;
	private final String productTitle;

}
