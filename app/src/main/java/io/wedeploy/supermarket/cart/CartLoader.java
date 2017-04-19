package io.wedeploy.supermarket.cart;

import android.content.Context;
import android.support.v4.content.AsyncTaskLoader;
import android.util.Log;
import com.wedeploy.sdk.exception.WeDeployException;
import io.wedeploy.supermarket.cart.model.CartProduct;
import io.wedeploy.supermarket.repository.SupermarketData;
import org.json.JSONException;

import java.util.List;

/**
 * @author Silvio Santos
 */
public class CartLoader extends AsyncTaskLoader<List<CartProduct>> {

	public CartLoader(Context context) {
		super(context);

		supermarketData = SupermarketData.getInstance();
	}

	@Override
	public List<CartProduct> loadInBackground() {
		try {
			products = supermarketData.getCart();

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

	private List<CartProduct> products;
	private final SupermarketData supermarketData;

}
