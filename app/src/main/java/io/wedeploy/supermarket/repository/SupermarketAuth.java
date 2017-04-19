package io.wedeploy.supermarket.repository;

import android.app.Activity;
import com.wedeploy.sdk.Callback;
import com.wedeploy.sdk.WeDeploy;
import com.wedeploy.sdk.WeDeployAuth;
import com.wedeploy.sdk.auth.Auth;
import com.wedeploy.sdk.auth.AuthProvider;
import com.wedeploy.sdk.auth.TokenAuth;
import com.wedeploy.sdk.transport.Response;
import io.reactivex.Single;
import io.reactivex.SingleSource;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.annotations.NonNull;
import io.reactivex.functions.Consumer;
import io.reactivex.functions.Function;
import io.reactivex.schedulers.Schedulers;
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

	public Single<Response> getUser(Auth authorization) {
		WeDeploy weDeploy = new WeDeploy.Builder().build();

		return weDeploy.auth(AUTH_URL)
			.auth(authorization)
			.getCurrentUser()
			.asSingle()
			.doOnSuccess(new Consumer<Response>() {
				@Override
				public void accept(@NonNull Response response) throws Exception {
					saveUser(response);
				}
			});
	}

	public void resetPassword(String email, Callback callback) {
		WeDeploy weDeploy = new WeDeploy.Builder().build();

		weDeploy.auth(AUTH_URL)
			.sendPasswordResetEmail(email)
			.execute(callback);
	}

	public void signIn(Activity activity, AuthProvider.Provider provider) {
		AuthProvider authProvider = new AuthProvider.Builder()
			.redirectUri("oauth-wedeploy://io.wedeploy.supermarket")
			.providerScope("email")
			.provider(provider)
			.build();

		WeDeploy weDeploy = new WeDeploy.Builder().build();

		weDeploy.auth(AUTH_URL)
			.signIn(activity, authProvider);
	}

	public Single<Response> signIn(String email, String password) {
		WeDeploy weDeploy = new WeDeploy.Builder().build();

		return weDeploy.auth(AUTH_URL)
			.signIn(email, password)
			.asSingle()
			.subscribeOn(Schedulers.io())
			.observeOn(AndroidSchedulers.mainThread())
			.flatMap(new Function<Response, SingleSource<? extends Response>>() {
				@Override
				public SingleSource<? extends Response> apply(@NonNull Response response)
					throws Exception {
					String token = saveToken(response);

					return getUser(new TokenAuth(token)).subscribeOn(Schedulers.io());
				}
			});
	}

	public Single<Response> signUp(final String email, final String password, String name) {
		final WeDeployAuth weDeployAuth = new WeDeploy.Builder().build()
			.auth(AUTH_URL);

		return weDeployAuth.createUser(email, password, name)
			.asSingle()
			.flatMap(new Function<Response, SingleSource<Response>>() {
				@Override
				public SingleSource<Response> apply(@NonNull Response response) throws Exception {
					return signIn(email, password).subscribeOn(Schedulers.io());
				}
			})
			.doOnSuccess(new Consumer<Response>() {
				@Override
				public void accept(@NonNull Response response) throws Exception {
					saveToken(response);
				}
			});
	}

	private String saveToken(Response response) throws JSONException {
		JSONObject tokenJsonObject = new JSONObject(response.getBody());
		String token = tokenJsonObject.getString("access_token");
		Settings.saveToken(token);

		return token;
	}

	private void saveUser(Response response) throws JSONException {
		JSONObject userJsonObject = new JSONObject(response.getBody());
		Settings.saveUser(userJsonObject.getString("id"));
	}

	private SupermarketAuth() {
	}

	private static SupermarketAuth instance;

	private static final String AUTH_URL = "http://auth.supermarket.wedeploy.io";
}
