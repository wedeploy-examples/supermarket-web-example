package io.wedeploy.supermarket.repository;

import android.content.Context;
import android.content.SharedPreferences;
import com.wedeploy.sdk.auth.Auth;
import com.wedeploy.sdk.auth.TokenAuth;
import io.wedeploy.supermarket.SupermarketApplication;

/**
 * @author Silvio Santos
 */
public class Settings {

	public static String getCurrentUserId() {
		return getSettings().getString(USER_ID, null);
	}

	public static Auth getAuth() {
		String token = getSettings().getString(USER_TOKEN, null);

		TokenAuth auth = null;

		if (token != null) {
			auth = new TokenAuth(token);
		}

		return auth;
	}

	public static boolean isLoggedIn() {
		return getAuth() != null;
	}

	public static void saveUser(String userId) {
		SharedPreferences.Editor editor = getSettings().edit();
		editor.putString(USER_ID, userId);
		editor.commit();
	}

	public static void saveToken(String token) {
		SharedPreferences.Editor editor = getSettings().edit();
		editor.putString(USER_TOKEN, token);
		editor.commit();
	}

	private static SharedPreferences getSettings() {
		return SupermarketApplication.getContext().getSharedPreferences(
			"settings",
			Context.MODE_PRIVATE);
	}

	private static final String USER_ID = "userId";
	private static final String USER_TOKEN = "userToken";

}
