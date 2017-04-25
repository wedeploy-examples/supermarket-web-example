package io.wedeploy.supermarket.repository;

import com.wedeploy.sdk.Call;
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

	public Call<Response> sendCheckoutEmail(
		String name, String email, List<CartProduct> cartProducts) {

		WeDeploy weDeploy = new WeDeploy.Builder().build();

		return weDeploy.email(EMAIL_URL)
			.from("auto-confirm@supermarket.wedeploy.io")
			.to(email)
			.subject("Thank you " + name + ", your order was confirmed!")
			.message(getMessageFromCartProducts(cartProducts))
			.send();
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

}
