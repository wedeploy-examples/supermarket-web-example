package io.wedeploy.supermarket;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;

import com.wedeploy.sdk.Callback;
import com.wedeploy.sdk.transport.Response;

import org.json.JSONException;
import org.json.JSONObject;

import io.wedeploy.supermarket.login.LoginActivity;

/**
 * @author Silvio Santos
 */
public class SignUpRequest extends Fragment {

    public static void signUp(
            AppCompatActivity activity, String email, String password, String name) {

        SignUpRequest request = new SignUpRequest();
        request.setRetainInstance(true);
        request.email = email;
        request.password = password;
        request.name = name;

        FragmentTransaction transaction = activity.getSupportFragmentManager().beginTransaction();
        transaction.add(request, TAG);
        transaction.commit();
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);

        if (context instanceof SignUpListener) {
            this.listener = (SignUpListener) context;
        }
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        SupermarketAuth auth = new SupermarketAuth();
        auth.signUp(email, password, name, new Callback() {
            @Override
            public void onSuccess(Response response) {
                try {
                    saveToken(response);
                    listener.onSignUpSuccess(response);
                }
                catch (JSONException e) {
                    listener.onSignUpFailed(e);
                }

            }

            @Override
            public void onFailure(Exception e) {
                listener.onSignUpFailed(e);
            }
        });
    }

    private void saveToken(Response response) throws JSONException {
        JSONObject tokenJsonObject = new JSONObject(response.getBody());
        Settings.getInstance(getContext()).saveToken(tokenJsonObject.getString("access_token"));
    }

    private static final String TAG = SignUpActivity.class.getSimpleName();

    private String email;
    private SignUpListener listener;
    private String password;
    private String name;

}
