package io.wedeploy.supermarket;

import android.databinding.DataBindingUtil;
import android.databinding.ViewDataBinding;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import java.util.List;

import io.wedeploy.supermarket.databinding.ActivityMainBinding;
import io.wedeploy.supermarket.databinding.ActivitySignUpBinding;

public class SignUpActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = DataBindingUtil.setContentView(this, R.layout.activity_sign_up);

        setupSteps();
    }

    private void setupSteps() {
        List<View> stepViews = binding.steps.getStepViews();

        for (int i = 0; i < stepViews.size(); i++) {
            TextView title = (TextView)stepViews.get(i).findViewById(R.id.title);
            title.setText(stepTitles[i]);
        }
    }

    private ActivitySignUpBinding binding;
    private int[] stepTitles = {
            R.string.whats_your_name, R.string.and_your_email, R.string.now_create_a_password };

}
