package io.wedeploy.supermarket;

import android.app.Activity;

import com.wedeploy.sdk.Callback;
import com.wedeploy.sdk.WeDeploy;
import com.wedeploy.sdk.WeDeployAuth;
import com.wedeploy.sdk.auth.AuthProvider;
import com.wedeploy.sdk.transport.Response;

import io.reactivex.SingleSource;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.annotations.NonNull;
import io.reactivex.functions.Consumer;
import io.reactivex.functions.Function;
import io.reactivex.schedulers.Schedulers;

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

    public void signUp(final String email, final String password, String name, final Callback callback) {
        final WeDeployAuth weDeployAuth = new WeDeploy.Builder().build()
                .auth(AUTH_URL);

        weDeployAuth.createUser(email, password, name)
                .asSingle()
                .flatMap(new Function<Response, SingleSource<Response>>() {
                    @Override
                    public SingleSource<Response> apply(@NonNull Response response) throws Exception {
                        return weDeployAuth.signIn(email, password).asSingle();
                    }
                })
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<Response>() {
                       @Override
                       public void accept(@NonNull Response response) throws Exception {
                           callback.onSuccess(response);
                       }
                   }, new Consumer<Throwable>() {
                       @Override
                       public void accept(@NonNull Throwable throwable) throws Exception {
                           callback.onFailure(new Exception(throwable));
                       }
                   }
                );
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
