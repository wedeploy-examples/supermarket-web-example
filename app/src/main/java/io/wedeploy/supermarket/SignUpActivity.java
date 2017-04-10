package io.wedeploy.supermarket;

import android.databinding.DataBindingUtil;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import java.util.List;

import io.wedeploy.supermarket.databinding.ActivitySignUpBinding;

public class SignUpActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = DataBindingUtil.setContentView(this, R.layout.activity_sign_up);

        setupStepButtons();
    }

    private void setupStepButtons() {
        binding.steps.setOnDoneClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //TODO fire sign up request
            }
        });
    }

    private ActivitySignUpBinding binding;

}
