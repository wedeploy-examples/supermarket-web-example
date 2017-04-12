package io.wedeploy.supermarket.login;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;

import com.wedeploy.sdk.Callback;
import com.wedeploy.sdk.transport.Response;

import io.wedeploy.supermarket.SupermarketAuth;

/**
 * @author Silvio Santos
 */
public class LoginRequest extends Fragment {

    public static final String TAG = "loginRequest";

    public LoginRequest() {
        setRetainInstance(true);
    }

    public static void login(AppCompatActivity activity, String email, String password) {
        LoginRequest request = new LoginRequest();
        request.email = email;
        request.password = password;

        FragmentTransaction transaction = activity.getSupportFragmentManager().beginTransaction();
        transaction.add(request, TAG);
        transaction.commit();
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);

        if (context instanceof LoginActivity) {
            this.listener = (LoginActivity)context;
        }
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        SupermarketAuth auth = new SupermarketAuth();
        auth.login(email, password, new Callback() {
            @Override
            public void onSuccess(Response response) {
                listener.onLoginSuccess(response);
            }

            @Override
            public void onFailure(Exception e) {
                listener.onLoginFailed(e);
            }
        });
    }

    private String password;
    private String email;
    private LoginListener listener;

}
