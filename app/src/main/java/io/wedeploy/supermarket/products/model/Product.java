package io.wedeploy.supermarket.products.model;

import org.json.JSONObject;

/**
 * @author Silvio Santos
 */
public class Product {

	public Product(JSONObject jsonObject) {
		filename = jsonObject.optString("filename", "");
		id = jsonObject.optString("id", "");
		price = jsonObject.optDouble("price", 0);
		title = jsonObject.optString("title", "");
	}

	public String getFilename() {
		return filename;
	}

	public String getImageUrl() {
		return "http://public.supermarket.wedeploy.io/assets/images/" + filename;
	}

	public double getPrice() {
		return price;
	}

	public String getId() {
		return id;
	}

	public String getTitle() {
		return title;
	}

	private final String filename;
	private final String id;
	private final double price;
	private final String title;

}
