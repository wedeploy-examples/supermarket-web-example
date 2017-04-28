package io.wedeploy.supermarket.products;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v4.content.AsyncTaskLoader;
import android.util.Log;
import com.wedeploy.android.exception.WeDeployException;
import com.wedeploy.android.transport.Response;
import io.wedeploy.supermarket.products.model.Product;
import io.wedeploy.supermarket.repository.SupermarketData;
import org.json.JSONArray;
import org.json.JSONException;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Silvio Santos
 */
public class ProductsLoader extends AsyncTaskLoader<List<Product>> {

	public ProductsLoader(Context context, String filter) {
		super(context);

		this.filter = filter;
		this.supermarketData = SupermarketData.getInstance();
	}

	@Override
	public List<Product> loadInBackground() {
		try {
			String type = ("all".equalsIgnoreCase(filter)) ? null : filter;

			Response response = supermarketData.getProducts(type)
				.execute();

			products = parseProducts(response);

			return products;
		}
		catch (WeDeployException | JSONException e) {
			Log.e(getClass().getSimpleName(), e.getMessage());
		}

		return null;
	}

	@Override
	protected void onStartLoading() {
		if (products != null) {
			deliverResult(products);
		}
		else {
			forceLoad();
		}
	}

	@NonNull
	private List<Product> parseProducts(Response response) throws JSONException {
		JSONArray jsonArray = new JSONArray(response.getBody());
		List<Product> products = new ArrayList<>(50);

		for (int i = 0; i < jsonArray.length(); i++) {
			products.add(new Product(jsonArray.getJSONObject(i)));
		}

		return products;
	}

	private final String filter;
	private List<Product> products;
	private final SupermarketData supermarketData;

}
