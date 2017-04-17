package io.wedeploy.supermarket.login;

import android.content.Intent;
import android.databinding.DataBindingUtil;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

import com.wedeploy.sdk.auth.Auth;
import com.wedeploy.sdk.auth.TokenAuth;
import com.wedeploy.sdk.transport.Response;

import io.wedeploy.supermarket.MainActivity;
import io.wedeploy.supermarket.R;
import io.wedeploy.supermarket.SignUpActivity;
import io.wedeploy.supermarket.databinding.ActivityLoginBinding;
import io.wedeploy.supermarket.resetpassword.ResetPasswordActivity;
import io.wedeploy.supermarket.view.AlertMessage;

/**
 * @author Silvio Santos
 */
public class LoginActivity extends AppCompatActivity implements LoginListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = DataBindingUtil.setContentView(this, R.layout.activity_login);

        binding.signUpButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(LoginActivity.this, SignUpActivity.class));
                finish();
            }
        });

        binding.signInButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                enableFields(false);
                binding.signInButton.setText(R.string.logging_in);

                String email = binding.email.getText().toString();
                String password = binding.password.getText().toString();

                LoginRequest.login(LoginActivity.this, email, password);
            }
        });

        binding.forgotPasswordButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivityForResult(
                    new Intent(LoginActivity.this, ResetPasswordActivity.class),
                    REQUEST_RESET_PASSWORD);
            }
        });
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);

        Auth auth = TokenAuth.getAuthFromIntent(intent);

        if (auth != null) {
            startActivity(new Intent(this, MainActivity.class));
            finishAffinity();
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if ((requestCode == REQUEST_RESET_PASSWORD) &&  (resultCode == RESULT_OK)) {
            AlertMessage.showSuccessMessage(
                this, getString(R.string.the_email_should_arrive_within_a_few_minuts));
        }
    }

    @Override
    public void onLoginSuccess(Response response) {
        if (isFinishing()) return;

        startActivity(new Intent(this, MainActivity.class));
        finishAffinity();
    }

    @Override
    public void onLoginFailed(Exception exception) {
        if (isFinishing()) return;

        enableFields(true);
        binding.signInButton.setText(R.string.log_in);

        AlertMessage.showErrorMessage(this, getString(R.string.invalid_email_or_password));
    }

    private void enableFields(boolean enable) {
        binding.password.setEnabled(enable);
        binding.email.setEnabled(enable);
        binding.signInButton.setEnabled(enable);
    }

    private static final int REQUEST_RESET_PASSWORD = 1;

    private ActivityLoginBinding binding;

}
