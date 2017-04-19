package io.wedeploy.supermarket;

import android.content.Context;
import android.content.SharedPreferences;
import com.wedeploy.sdk.auth.Auth;
import com.wedeploy.sdk.auth.TokenAuth;

/**
 * @author Silvio Santos
 */
public class Settings {

	public static Settings getInstance(Context context) {
		if (instance == null) {
			instance = new Settings(context);
		}

		return instance;
	}

	public String getCurrentUserId() {
		return preferences.getString(USER_ID, null);
	}

	public Auth getToken() {
		String token = preferences.getString(USER_TOKEN, null);

		TokenAuth auth = null;

		if (token != null) {
			auth = new TokenAuth(token);
		}

		return auth;
	}

	public boolean isLoggedIn() {
		return getToken() != null;
	}

	public void saveUser(String userId) {
		SharedPreferences.Editor editor = preferences.edit();
		editor.putString(USER_ID, userId);
		editor.commit();
	}

	public void saveToken(String token) {
		SharedPreferences.Editor editor = preferences.edit();
		editor.putString(USER_TOKEN, token);
		editor.commit();
	}

	private Settings(Context context) {
		preferences = context.getSharedPreferences("settings", Context.MODE_PRIVATE);
	}

	private final SharedPreferences preferences;
	private static Settings instance;
	private static final String USER_ID = "userId";
	private static final String USER_TOKEN = "userToken";

}
