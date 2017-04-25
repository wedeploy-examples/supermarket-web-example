package io.wedeploy.supermarket.repository;

import android.app.Activity;
import com.wedeploy.sdk.Call;
import com.wedeploy.sdk.WeDeploy;
import com.wedeploy.sdk.auth.Authorization;
import com.wedeploy.sdk.auth.ProviderAuthorization;
import com.wedeploy.sdk.transport.Response;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * @author Silvio Santos
 */
public class SupermarketAuth {

	public static SupermarketAuth getInstance() {
		if (instance == null) {
			instance = new SupermarketAuth();
		}

		return instance;
	}

	public Call<Response> getUser(Authorization authorization) {
		WeDeploy weDeploy = new WeDeploy.Builder().build();

		return weDeploy.auth(AUTH_URL)
			.authorization(authorization)
			.getCurrentUser();
	}

	public Call<Response> resetPassword(String email) {
		WeDeploy weDeploy = new WeDeploy.Builder().build();

		return weDeploy.auth(AUTH_URL)
			.sendPasswordResetEmail(email);
	}

	public void signIn(Activity activity, ProviderAuthorization.Provider provider) {
		ProviderAuthorization authProvider = new ProviderAuthorization.Builder()
			.redirectUri("oauth-wedeploy://io.wedeploy.supermarket")
			.providerScope("email")
			.provider(provider)
			.build();

		WeDeploy weDeploy = new WeDeploy.Builder().build();

		weDeploy.auth(AUTH_URL)
			.signIn(activity, authProvider);
	}

	public Call<Response> signIn(String email, String password) {
		WeDeploy weDeploy = new WeDeploy.Builder().build();

		return weDeploy.auth(AUTH_URL)
			.signIn(email, password);
	}

	public Call<Response> signOut(Authorization authorization) {
		WeDeploy weDeploy = new WeDeploy.Builder().build();

		return weDeploy.auth(AUTH_URL)
			.authorization(authorization)
			.signOut();
	}

	public Call<Response> signUp(String email, String password, String name) {
		WeDeploy weDeploy = new WeDeploy.Builder().build();

		return weDeploy.auth(AUTH_URL)
			.createUser(email, password, name);
	}

	public void saveUser(Response response) throws JSONException {
		JSONObject userJsonObject = new JSONObject(response.getBody());
		Settings.saveUser(userJsonObject);
	}

	public String saveToken(Response response) throws JSONException {
		JSONObject tokenJsonObject = new JSONObject(response.getBody());
		String token = tokenJsonObject.getString("access_token");
		Settings.saveToken(token);

		return token;
	}

	private SupermarketAuth() {
	}

	private static SupermarketAuth instance;

	private static final String AUTH_URL = "http://auth.supermarket.wedeploy.io";
	private static final String TAG = SupermarketAuth.class.getSimpleName();

}
