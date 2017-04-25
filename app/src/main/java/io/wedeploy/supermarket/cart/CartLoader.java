package io.wedeploy.supermarket.cart;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v4.content.AsyncTaskLoader;
import android.util.Log;
import com.wedeploy.sdk.exception.WeDeployException;
import com.wedeploy.sdk.transport.Response;
import io.wedeploy.supermarket.cart.model.CartProduct;
import io.wedeploy.supermarket.repository.SupermarketData;
import org.json.JSONArray;
import org.json.JSONException;

import java.util.ArrayList;
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
			Response response = supermarketData.getCart()
				.execute();

			cartProducts = parseCartProducts(response);

			return cartProducts;
		}
		catch (WeDeployException | JSONException e) {
			Log.e(getClass().getSimpleName(), e.getMessage());
		}

		return null;
	}

	@Override
	protected void onStartLoading() {
		if (cartProducts != null) {
			deliverResult(cartProducts);
		}
		else {
			forceLoad();
		}
	}

	@NonNull
	private List<CartProduct> parseCartProducts(Response response) throws JSONException {
		JSONArray jsonArray = new JSONArray(response.getBody());
		List<CartProduct> cartProducts = new ArrayList<>(50);

		for (int i = 0; i < jsonArray.length(); i++) {
			cartProducts.add(new CartProduct(jsonArray.getJSONObject(i)));
		}

		return cartProducts;
	}

	private List<CartProduct> cartProducts;
	private final SupermarketData supermarketData;

}
