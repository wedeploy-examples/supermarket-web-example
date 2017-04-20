package io.wedeploy.supermarket.repository;

import android.content.Context;
import android.content.SharedPreferences;
import com.wedeploy.sdk.auth.Auth;
import com.wedeploy.sdk.auth.TokenAuth;
import io.wedeploy.supermarket.SupermarketApplication;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * @author Silvio Santos
 */
public class Settings {

	public static void clear() {
		getSettings().edit().clear().commit();
	}

	public static String getUserEmail() {
		return getSettings().getString(USER_EMAIL, null);
	}

	public static String getUserId() {
		return getSettings().getString(USER_ID, null);
	}

	public static String getUserName() {
		return getSettings().getString(USER_NAME, null);
	}

	public static String getUserPhoto() {
		return getSettings().getString(USER_PHOTO, null);
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

	public static void saveUser(JSONObject userJsonObject) throws JSONException {
		SharedPreferences.Editor editor = getSettings().edit();
		editor.putString(USER_ID, userJsonObject.optString("id"));
		editor.putString(USER_EMAIL, userJsonObject.optString("email"));
		editor.putString(USER_NAME, userJsonObject.optString("name"));
		editor.putString(USER_PHOTO, userJsonObject.optString("photoUrl"));
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
	private static final String USER_EMAIL = "userEmail";
	private static final String USER_NAME = "userName";
	private static final String USER_PHOTO = "userId";
	private static final String USER_TOKEN = "userToken";

}
