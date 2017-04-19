package io.wedeploy.supermarket.products;

import android.content.Context;
import android.support.v4.content.AsyncTaskLoader;
import android.util.Log;
import com.wedeploy.sdk.exception.WeDeployException;
import io.wedeploy.supermarket.repository.Settings;
import io.wedeploy.supermarket.products.model.Product;
import io.wedeploy.supermarket.repository.SupermarketData;
import org.json.JSONException;

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

			products = supermarketData.getProducts(type);

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

	private List<Product> products;
	private final String filter;
	private final SupermarketData supermarketData;

}
