package io.wedeploy.supermarket.products.model;

import android.content.Context;
import android.content.ContextWrapper;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import io.wedeploy.supermarket.products.AddToCartRequest;
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

	public void onAddToCartButtonClick(View view) {
		AddToCartRequest.addToCart(getActivity(view.getContext()), this);
	}

	private AppCompatActivity getActivity(Context context) {
		while (context instanceof ContextWrapper) {
			if (context instanceof AppCompatActivity) {
				return (AppCompatActivity)context;
			}
			context = ((ContextWrapper)context).getBaseContext();
		}

		return null;
	}

	private final String filename;
	private final String id;
	private final double price;
	private final String title;

}
