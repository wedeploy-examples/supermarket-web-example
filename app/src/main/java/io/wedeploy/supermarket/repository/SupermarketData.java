package io.wedeploy.supermarket.repository;

import com.wedeploy.sdk.Call;
import com.wedeploy.sdk.WeDeploy;
import com.wedeploy.sdk.exception.WeDeployException;
import com.wedeploy.sdk.query.filter.Filter;
import com.wedeploy.sdk.transport.Response;
import io.wedeploy.supermarket.products.model.Product;
import org.json.JSONException;
import org.json.JSONObject;

import static com.wedeploy.sdk.query.filter.Filter.*;

/**
 * @author Silvio Santos
 */
public class SupermarketData {

	public synchronized static SupermarketData getInstance() {
		if (instance == null) {
			instance = new SupermarketData();
		}

		return instance;
	}

	public synchronized static void destroy() {
		instance = null;
	}

	public Call<Response> addToCart(Product product) throws JSONException {
		JSONObject cartProductJsonObject = new JSONObject()
			.put("productTitle", product.getTitle())
			.put("productPrice", product.getPrice())
			.put("productFilename", product.getFilename())
			.put("productId", product.getId())
			.put("userId", currentUserId);

		return weDeploy.data(DATA_URL)
			.create("cart", cartProductJsonObject);
	}

	public Call<Response> getCart() throws WeDeployException, JSONException {
		return weDeploy.data(DATA_URL)
			.where(equal("userId", currentUserId))
			.orderBy("productTitle")
			.get("cart");
	}

	public Call<Response> getCartCount() {
		return weDeploy.data(DATA_URL)
			.where(equal("userId", currentUserId))
			.count()
			.get("cart");
	}

	public Call<Response> deleteFromCart(String id) {
		return weDeploy.data(DATA_URL)
			.delete("cart/" + id);
	}

	public Call<Response> getProducts(String type) throws WeDeployException, JSONException {
		Filter typeFilter = (type != null) ? match("type", type) : not("type", "");

		return weDeploy.data(DATA_URL)
			.where(typeFilter.and(exists("filename")))
			.orderBy("title")
			.get("products");
	}

	private SupermarketData() {
		weDeploy = new WeDeploy.Builder()
			.authorization(Settings.getAuthorization())
			.build();

		this.currentUserId = Settings.getUserId();
	}

	private final String currentUserId;
	private WeDeploy weDeploy;

	private static SupermarketData instance;

	private static final String DATA_URL = "http://data.supermarket.wedeploy.io";

}
