package io.wedeploy.supermarket.cart;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;
import android.widget.Toast;
import com.wedeploy.sdk.Callback;
import com.wedeploy.sdk.transport.Response;
import io.wedeploy.supermarket.R;
import io.wedeploy.supermarket.repository.SupermarketData;

/**
 * @author Silvio Santos
 */
public class DeleteCartItemRequest extends Fragment {

	public DeleteCartItemRequest() {
		setRetainInstance(true);
	}

	public static void delete(AppCompatActivity activity, String id) {
		DeleteCartItemRequest request = new DeleteCartItemRequest();
		request.id = id;

		FragmentTransaction transaction = activity.getSupportFragmentManager().beginTransaction();
		transaction.add(request, TAG);
		transaction.commit();
	}

	@Override
	public void onCreate(@Nullable Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		SupermarketData.getInstance().deleteFromCart(id)
			.execute(new Callback() {
				@Override
				public void onSuccess(Response response) {

				}

				@Override
				public void onFailure(Exception e) {
					if (!isAdded()) return;

					Toast.makeText(
						getActivity(), R.string.could_not_delete_product_from_cart,
						Toast.LENGTH_SHORT).show();
				}
			});
	}

	private String id;

	private static final String TAG = DeleteCartItemRequest.class.getSimpleName();

}
