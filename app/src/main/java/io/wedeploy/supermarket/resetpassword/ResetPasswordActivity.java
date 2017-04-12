package io.wedeploy.supermarket.resetpassword;

import android.databinding.DataBindingUtil;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

import com.wedeploy.sdk.transport.Response;

import io.wedeploy.supermarket.R;
import io.wedeploy.supermarket.databinding.ActivityResetPasswordBinding;

/**
 * @author Silvio Santos
 */
public class ResetPasswordActivity extends AppCompatActivity implements ResetPasswordListener {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = DataBindingUtil.setContentView(this, R.layout.activity_reset_password);

        binding.resetPasswordButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                ResetPasswordRequest.resetPassword(
                        ResetPasswordActivity.this, binding.editText.getText().toString());
            }
        });

    }

    @Override
    public void onResetPasswordSuccess(Response response) {
        finish();
    }

    @Override
    public void onResetPasswordFailed(Exception e) {
        System.out.println("ResetPasswordActivity.onResetPasswordFailed");
    }

    private ActivityResetPasswordBinding binding;

}
