package io.wedeploy.supermarket.repository;

import android.util.Log;
import com.wedeploy.sdk.Callback;
import com.wedeploy.sdk.WeDeploy;
import com.wedeploy.sdk.transport.Response;
import io.wedeploy.supermarket.cart.model.CartProduct;

import java.util.List;

/**
 * @author Silvio Santos
 */
public class SupermarketEmail {

	public static SupermarketEmail getInstance() {
		if (instance == null) {
			instance = new SupermarketEmail();
		}

		return instance;
	}

	public void sendCheckoutEmail(String name, String email, List<CartProduct> cartProducts) {
		WeDeploy weDeploy = new WeDeploy.Builder().build();

		weDeploy.email(EMAIL_URL)
			.from("auto-confirm@supermarket.wedeploy.io")
			.to(email)
			.subject("Thank you " + name + ", your order was confirmed!")
			.message(getMessageFromCartProducts(cartProducts))
			.send()
			.execute(new Callback() {
				@Override
				public void onSuccess(Response response) {
					Log.i(TAG, "Checkout email sent");
				}

				@Override
				public void onFailure(Exception e) {
					Log.e(TAG, "Failed to send checkout email", e);
				}
			});

	}

	private String getMessageFromCartProducts(List<CartProduct> cartProducts) {
		StringBuilder sb = new StringBuilder();

		for (CartProduct cartProduct : cartProducts) {
			sb.append("<div>");
			sb.append(cartProduct.getProductTitle());
			sb.append(" - ");
			sb.append(cartProduct.getProductPrice());
			sb.append("</div>");
		}

		return sb.append("<br>Thank you!").toString();
	}

	private static SupermarketEmail instance;

	private static final String EMAIL_URL = "http://email.supermarket.wedeploy.io";
	private static final String TAG = SupermarketEmail.class.getSimpleName();
}
