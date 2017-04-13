package io.wedeploy.supermarket;

import android.app.Activity;

import com.wedeploy.sdk.Callback;
import com.wedeploy.sdk.WeDeploy;
import com.wedeploy.sdk.auth.AuthProvider;

import static com.wedeploy.sdk.auth.AuthProvider.Provider.GOOGLE;

/**
 * @author Silvio Santos
 */

public class SupermarketAuth {

    public void login(String email, String password, Callback callback) {
        WeDeploy weDeploy = new WeDeploy.Builder().build();

        weDeploy.auth(AUTH_URL)
            .signIn(email, password)
            .execute(callback);
    }

    public void resetPassword(String email, Callback callback) {
        WeDeploy weDeploy = new WeDeploy.Builder().build();

        weDeploy.auth(AUTH_URL)
                .sendPasswordResetEmail(email)
                .execute(callback);
    }

    public void signUp(String email, String password, String name, Callback callback) {
        WeDeploy weDeploy = new WeDeploy.Builder().build();

        weDeploy.auth(AUTH_URL)
                .createUser(email, password, name)
                .execute(callback);
    }

    public static void signIn(Activity activity, AuthProvider.Provider provider) {
        AuthProvider authProvider = new AuthProvider.Builder()
                .redirectUri("oauth-wedeploy://io.wedeploy.supermarket")
                .providerScope("email")
                .provider(provider)
                .build();

        WeDeploy weDeploy = new WeDeploy.Builder().build();

        weDeploy.auth(AUTH_URL)
                .signIn(activity, authProvider);
    }

    private static final String AUTH_URL = "http://auth.supermarket.wedeploy.io";
}
