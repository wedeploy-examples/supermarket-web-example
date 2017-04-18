package io.wedeploy.supermarket.model;

import android.support.v7.app.AppCompatActivity;
import android.view.View;

import org.json.JSONObject;

import io.wedeploy.supermarket.AddToCartRequest;

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

	public String getImageUrl() {
		return "http://public.supermarket.wedeploy.io/assets/images/" + filename;
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

	public void onAddToCartButtonClick(View view) {
		AppCompatActivity activity = (AppCompatActivity)view.getContext();
		AddToCartRequest.addToCart(activity, this);
	}

	private String description;
	private String filename;
	private String id;
	private double price;
	private String title;
	private String type;

}
