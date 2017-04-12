package io.wedeploy.supermarket;

import com.wedeploy.sdk.Callback;
import com.wedeploy.sdk.WeDeploy;

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

    private static final String AUTH_URL = "http://auth.supermarket.wedeploy.io";
}
