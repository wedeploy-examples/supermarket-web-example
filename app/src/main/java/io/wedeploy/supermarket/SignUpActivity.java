package io.wedeploy.supermarket;

import android.content.Intent;
import android.databinding.DataBindingUtil;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

import com.wedeploy.sdk.transport.Response;

import io.wedeploy.supermarket.databinding.ActivitySignUpBinding;
import io.wedeploy.supermarket.login.LoginActivity;
import io.wedeploy.supermarket.view.AlertMessage;

public class SignUpActivity extends AppCompatActivity implements SignUpListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = DataBindingUtil.setContentView(this, R.layout.activity_sign_up);

        binding.logInButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(SignUpActivity.this, LoginActivity.class));
                finish();
            }
        });

        setupStepButtons();
    }

    private void setupStepButtons() {
        binding.steps.setOnDoneClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                enableFields(false);
                binding.steps.getNextButton().setText(R.string.signing_up);

                String email = binding.email.getText().toString();
                String password = binding.password.getText().toString();
                String name = binding.name.getText().toString();

                SignUpRequest.signUp(SignUpActivity.this, email, password, name);
            }
        });
    }

    @Override
    public void onSignUpSuccess(Response response) {
        if (isFinishing()) return;

        finishAffinity();
        startActivity(new Intent(this, MainActivity.class));
    }

    @Override
    public void onSignUpFailed(Exception e) {
        if (isFinishing()) return;

        enableFields(true);
        binding.steps.getNextButton().setText(R.string.sign_up);
        AlertMessage.showErrorMessage(this, "Could not sign up");
    }


    public void enableFields(boolean enable) {
        binding.name.setEnabled(enable);
        binding.email.setEnabled(enable);
        binding.password.setEnabled(enable);
        binding.steps.getNextButton().setEnabled(enable);
        binding.steps.getPreviousButton().setEnabled(enable);
    }

    private ActivitySignUpBinding binding;

}
