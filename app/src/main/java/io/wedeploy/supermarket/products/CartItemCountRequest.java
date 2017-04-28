package io.wedeploy.supermarket.products;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import com.wedeploy.android.Callback;
import com.wedeploy.android.transport.Response;
import io.wedeploy.supermarket.cart.CartItemListener;
import io.wedeploy.supermarket.repository.SupermarketData;

/**
 * @author Silvio Santos
 */
public class CartItemCountRequest extends Fragment {

	public CartItemCountRequest() {
		setRetainInstance(true);
	}

	public static void getCartItemCount(AppCompatActivity activity) {
		CartItemCountRequest request = new CartItemCountRequest();

		FragmentTransaction transaction = activity.getSupportFragmentManager().beginTransaction();
		transaction.add(request, TAG);
		transaction.commit();
	}

	@Override
	public void onAttach(Context context) {
		super.onAttach(context);

		if (context instanceof CartItemListener) {
			this.listener = (CartItemListener)context;
		}
	}

	@Override
	public void onCreate(@Nullable Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		SupermarketData.getInstance().getCartCount()
			.execute(new Callback() {

				@Override
				public void onSuccess(Response response) {
					listener.onGetCartItemCountSuccess(Integer.valueOf(response.getBody()));
				}

				@Override
				public void onFailure(Exception e) {
					Log.e(TAG, "Couldn't get cart items count", e);
				}
			});
	}

	private CartItemListener listener;

	private static final String TAG = CartItemCountRequest.class.getSimpleName();

}
