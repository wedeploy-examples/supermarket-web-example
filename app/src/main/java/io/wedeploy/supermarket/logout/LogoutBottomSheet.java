package io.wedeploy.supermarket.logout;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.BottomSheetDialogFragment;
import android.support.v4.content.res.ResourcesCompat;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import com.wedeploy.android.Callback;
import com.wedeploy.android.transport.Response;
import io.wedeploy.supermarket.R;
import io.wedeploy.supermarket.repository.Settings;
import io.wedeploy.supermarket.repository.SupermarketAuth;
import io.wedeploy.supermarket.repository.SupermarketData;
import io.wedeploy.supermarket.welcome.WelcomeActivity;

/**
 * @author Silvio Santos
 */
public class LogoutBottomSheet extends BottomSheetDialogFragment {

	public static void show(AppCompatActivity activity) {
		LogoutBottomSheet bottomSheet = new LogoutBottomSheet();
		bottomSheet.show(activity.getSupportFragmentManager(), TAG);
	}

	@Nullable
	@Override
	public View onCreateView(
		LayoutInflater inflater, @Nullable ViewGroup container,
		@Nullable Bundle savedInstanceState) {

		ViewGroup viewGroup = (ViewGroup)inflater.inflate(
			R.layout.bottom_sheet, container, false);

		TextView logout = (TextView)inflater.inflate(
			R.layout.bottom_sheet_item, viewGroup, false);

		TextView cancel = (TextView)inflater.inflate(
			R.layout.bottom_sheet_item, viewGroup, false);

		logout.setText(R.string.log_out);
		logout.setTextColor(ResourcesCompat.getColor(getResources(), R.color.red, null));
		logout.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				logout();
			}
		});

		cancel.setText(R.string.cancel);
		cancel.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				dismiss();
			}
		});

		viewGroup.addView(logout);
		viewGroup.addView(cancel);

		return viewGroup;
	}

	private void logout() {
		removeToken();

		SupermarketData.getInstance().destroy();
		Settings.clear();

		Activity activity = getActivity();
		activity.finish();
		startActivity(new Intent(activity, WelcomeActivity.class));
	}

	private static void removeToken() {
		SupermarketAuth.getInstance().signOut(Settings.getAuthorization())
			.execute(new Callback() {
				@Override
				public void onSuccess(Response response) {
					Log.i(TAG, "Token revoked");
				}

				@Override
				public void onFailure(Exception e) {
					Log.i(TAG, "Could not revoke token", e);
				}
			});
	}

	private static final String TAG = LogoutBottomSheet.class.getSimpleName();

}
