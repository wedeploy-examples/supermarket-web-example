package io.wedeploy.supermarket.view;

import android.app.Dialog;
import android.content.res.ColorStateList;
import android.databinding.DataBindingUtil;
import android.os.Bundle;
import android.os.Handler;
import android.support.annotation.ColorRes;
import android.support.annotation.NonNull;
import android.support.annotation.StringRes;
import android.support.v4.app.DialogFragment;
import android.support.v4.content.res.ResourcesCompat;
import android.support.v4.view.ViewCompat;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.app.AppCompatDialog;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.Window;
import io.wedeploy.supermarket.R;
import io.wedeploy.supermarket.databinding.AlertMessageBinding;

import static android.view.ViewGroup.LayoutParams.MATCH_PARENT;
import static android.view.ViewGroup.LayoutParams.WRAP_CONTENT;

/**
 * @author Silvio Santos
 */
public class AlertMessage extends DialogFragment {

	public static void showErrorMessage(AppCompatActivity activity, String message) {
		showMessage(activity, message, R.string.icon_error, R.color.alert_error_icon_background);
	}

	public static void showSuccessMessage(AppCompatActivity activity, String message) {
		showMessage(
			activity,
			message,
			R.string.icon_success,
			R.color.alert_success_icon_background);
	}

	@NonNull
	@Override
	public Dialog onCreateDialog(Bundle savedInstanceState) {
		AppCompatDialog dialog = new AppCompatDialog(getActivity(), R.style.WeAlertMessage);

		dialog.setContentView(R.layout.alert_message);

		AlertMessageBinding binding = DataBindingUtil.inflate(
			LayoutInflater.from(getActivity()), R.layout.alert_message, null, false);

		Window window = dialog.getWindow();
		window.setContentView(binding.getRoot());
		window.setLayout(MATCH_PARENT, WRAP_CONTENT);
		window.setGravity(Gravity.TOP);

		Bundle bundle = getArguments();
		binding.message.setText(bundle.getString(MESSAGE));
		binding.icon.setText(bundle.getInt(ICON));

		ColorStateList iconBackgroundColor = ResourcesCompat.getColorStateList(
			getResources(), bundle.getInt(ICON_BACKGROUND), null);

		ViewCompat.setBackgroundTintList(binding.icon, iconBackgroundColor);

		return dialog;
	}

	@Override
	public void onResume() {
		super.onResume();

		new Handler().postDelayed(new Runnable() {
			@Override
			public void run() {
				if (!isAdded()) return;

				dismissAllowingStateLoss();
			}
		}, 5000);
	}

	private static void showMessage(
		AppCompatActivity activity, String message, @StringRes int icon,
		@ColorRes int iconBackgroundColor) {

		AlertMessage alert = new AlertMessage();

		Bundle arguments = new Bundle();
		arguments.putString(MESSAGE, message);
		arguments.putInt(ICON, icon);
		arguments.putInt(ICON_BACKGROUND, iconBackgroundColor);
		alert.setArguments(arguments);
		alert.show(activity.getSupportFragmentManager(), TAG);
	}

	private static final String ICON = "icon";
	private static final String ICON_BACKGROUND = "iconBackground";
	private static final String MESSAGE = "message";
	private static final String TAG = AlertMessage.class.getSimpleName();

}
