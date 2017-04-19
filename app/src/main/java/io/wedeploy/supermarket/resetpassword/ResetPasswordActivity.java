package io.wedeploy.supermarket.resetpassword;

import android.databinding.DataBindingUtil;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import io.wedeploy.supermarket.R;
import io.wedeploy.supermarket.databinding.ActivityResetPasswordBinding;
import io.wedeploy.supermarket.view.AlertMessage;

/**
 * @author Silvio Santos
 */
public class ResetPasswordActivity extends AppCompatActivity implements ResetPasswordListener {

	@Override
	public void onResetPasswordSuccess() {
		setResult(RESULT_OK);
		finish();
	}

	@Override
	public void onResetPasswordFailed(Exception e) {
		enableFields(true);
		binding.resetPasswordButton.setText(R.string.send_reset_instructions);

		AlertMessage.showErrorMessage(this, getString(R.string.invalid_email));
	}

	@Override
	protected void onCreate(@Nullable Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		binding = DataBindingUtil.setContentView(this, R.layout.activity_reset_password);

		binding.resetPasswordButton.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				enableFields(false);
				binding.resetPasswordButton.setText(R.string.sending_reset_instructions);

				ResetPasswordRequest.resetPassword(
					ResetPasswordActivity.this, binding.editText.getText().toString());
			}
		});

	}

	private void enableFields(boolean enable) {
		binding.editText.setEnabled(enable);
		binding.resetPasswordButton.setEnabled(enable);
	}

	private ActivityResetPasswordBinding binding;

}
