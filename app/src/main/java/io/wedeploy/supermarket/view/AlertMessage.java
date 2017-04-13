package io.wedeploy.supermarket.view;

import android.app.Dialog;
import android.databinding.DataBindingUtil;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.DialogFragment;
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

    public static void showMessage(AppCompatActivity activity, String message) {
        AlertMessage alert = new AlertMessage();

        Bundle arguments = new Bundle();
        arguments.putString(MESSAGE, message);
        alert.setArguments(arguments);
        alert.show(activity.getSupportFragmentManager(), TAG);
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

        return dialog;
    }

    private static final String MESSAGE = "message";
    private static final String TAG = AlertMessage.class.getSimpleName();

    private AlertMessageBinding binding;
    private String message;

}
