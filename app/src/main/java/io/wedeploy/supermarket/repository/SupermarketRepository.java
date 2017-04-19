package io.wedeploy.supermarket.repository;

import com.wedeploy.sdk.Callback;
import com.wedeploy.sdk.WeDeploy;
import com.wedeploy.sdk.exception.WeDeployException;
import com.wedeploy.sdk.query.filter.Filter;
import com.wedeploy.sdk.transport.Response;
import io.wedeploy.supermarket.Settings;
import io.wedeploy.supermarket.model.CartProduct;
import io.wedeploy.supermarket.model.Product;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

import static com.wedeploy.sdk.query.filter.Filter.*;

/**
 * @author Silvio Santos
 */
public class SupermarketRepository {

	public SupermarketRepository(Settings settings) {
		this.settings = settings;
		this.weDeploy = new WeDeploy.Builder()
			.build();
	}

	public void addToCart(Product product, Callback callback) throws JSONException {
		JSONObject cartProductJsonObject = new JSONObject()
			.put("productTitle", product.getTitle())
			.put("productPrice", product.getPrice())
			.put("productFilename", product.getFilename())
			.put("productId", product.getId())
			.put("userId", settings.getCurrentUserId());

		weDeploy.data(DATA_URL)
			.auth(settings.getToken())
			.create("cart", cartProductJsonObject)
			.execute(callback);
	}

	public List<CartProduct> getCart() throws WeDeployException, JSONException {
		Response response = weDeploy
			.data(DATA_URL)
			.auth(settings.getToken())
			.where(equal("userId", settings.getCurrentUserId()))
			.orderBy("productTitle")
			.get("cart")
			.execute();

		JSONArray jsonArray = new JSONArray(response.getBody());
		List<CartProduct> cartProducts = new ArrayList<>(50);

		for (int i = 0; i < jsonArray.length(); i++) {
			cartProducts.add(new CartProduct(jsonArray.getJSONObject(i)));
		}

		return cartProducts;
	}

	public List<Product> getProducts(String type) throws WeDeployException, JSONException {
		Filter typeFilter = (type != null) ? match("type", type) : not("type", "");

		Response response = weDeploy
			.data(DATA_URL)
			.auth(settings.getToken())
			.where(typeFilter.and(exists("filename")))
			.orderBy("title")
			.get("products")
			.execute();

		JSONArray jsonArray = new JSONArray(response.getBody());
		List<Product> products = new ArrayList<>(50);

		for (int i = 0; i < jsonArray.length(); i++) {
			products.add(new Product(jsonArray.getJSONObject(i)));
		}

		return products;
	}

	private final Settings settings;
	private final WeDeploy weDeploy;
	private static final String DATA_URL = "http://data.supermarket.wedeploy.io";

}
