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
            public void onClick(View v) {
                startActivity(new Intent(SignUpActivity.this, LoginActivity.class));
                finish();
            }
        });

        setupStepButtons();
    }

    private void setupStepButtons() {
        binding.steps.setOnDoneClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
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

        startActivity(new Intent(this, MainActivity.class));
    }

    @Override
    public void onSignUpFailed(Exception e) {
        if (isFinishing()) return;

        AlertMessage.showMessage(this, "Could not sign up");
    }



    private ActivitySignUpBinding binding;

}
