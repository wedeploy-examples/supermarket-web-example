package io.wedeploy.supermarket.products;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;
import android.widget.Toast;
import com.wedeploy.sdk.Callback;
import com.wedeploy.sdk.transport.Response;
import io.wedeploy.supermarket.R;
import io.wedeploy.supermarket.repository.Settings;
import io.wedeploy.supermarket.products.model.Product;
import io.wedeploy.supermarket.repository.SupermarketData;
import org.json.JSONException;

/**
 * @author Silvio Santos
 */
public class AddToCartRequest extends Fragment {

	public static void addToCart(AppCompatActivity activity, Product product) {
		AddToCartRequest request = new AddToCartRequest();
		request.setRetainInstance(true);
		request.product = product;

		FragmentTransaction transaction = activity.getSupportFragmentManager().beginTransaction();
		transaction.add(request, TAG);
		transaction.commit();
	}

	@Override
	public void onCreate(@Nullable Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		SupermarketData supermarketData = SupermarketData.getInstance();

		try {
			supermarketData.addToCart(product, new Callback() {
				@Override
				public void onSuccess(Response response) {
					Toast.makeText(
						getContext(),
						R.string.item_added_to_cart,
						Toast.LENGTH_SHORT).show();
				}

				@Override
				public void onFailure(Exception e) {
					Toast.makeText(
						getContext(),
						R.string.could_not_add_item_to_cart,
						Toast.LENGTH_SHORT).show();
				}
			});
		}
		catch (JSONException e) {
			Toast.makeText(
				getContext(),
				R.string.could_not_add_item_to_cart,
				Toast.LENGTH_SHORT).show();
		}
	}

	private Product product;
	private static final String TAG = AddToCartRequest.class.getSimpleName();

}
