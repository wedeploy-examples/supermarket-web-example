package io.wedeploy.supermarket.model;

import android.content.Context;
import android.content.ContextWrapper;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import io.wedeploy.supermarket.AddToCartRequest;
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

	public String getImageUrl() {
		return "https://ui-supermarket.wedeploy.sh/assets/images/" + filename;
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

	private String description;
	private String filename;
	private String id;
	private double price;
	private String title;
	private String type;

}
