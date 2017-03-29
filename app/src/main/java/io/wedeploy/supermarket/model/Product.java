package io.wedeploy.supermarket.model;

import org.json.JSONObject;

/**
 * @author Silvio Santos
 */
public class Product {

	public Product(JSONObject jsonObject) {
		description = jsonObject.optString("description");
		filename = jsonObject.optString("filename", "");
		id = jsonObject.optString("id", "");
		price = jsonObject.optDouble("price", 0);
		title = jsonObject.optString("title", "");
		type = jsonObject.optString("type", "");
	}

	public String getFilename() {
		return filename;
	}

	public double getPrice() {
		return price;
	}

	public String getDescription() {
		return description;
	}

	public String getId() {
		return id;
	}

	public String getTitle() {
		return title;
	}

	public String getType() {
		return type;
	}

	private String description;
	private String filename;
	private String id;
	private double price;
	private String title;
	private String type;

}
