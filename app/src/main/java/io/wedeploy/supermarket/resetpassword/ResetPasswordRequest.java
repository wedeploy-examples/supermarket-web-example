package io.wedeploy.supermarket.resetpassword;

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
public class ResetPasswordRequest extends Fragment {

    public static final String TAG = "resetPasswordRequest";

    public ResetPasswordRequest() {
        setRetainInstance(true);
    }

    public static void resetPassword(AppCompatActivity activity, String email) {
        ResetPasswordRequest request = new ResetPasswordRequest();
        request.email = email;

        FragmentTransaction transaction = activity.getSupportFragmentManager().beginTransaction();
        transaction.add(request, TAG);
        transaction.commit();
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);

        if (context instanceof ResetPasswordListener) {
            this.listener = (ResetPasswordListener)context;
        }
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        SupermarketAuth auth = new SupermarketAuth();
        auth.resetPassword(email, new Callback() {
            @Override
            public void onSuccess(Response response) {
                listener.onResetPasswordSuccess(response);
            }

            @Override
            public void onFailure(Exception e) {
                listener.onResetPasswordFailed(e);
            }
        });
    }

    private String email;
    private ResetPasswordListener listener;

}
