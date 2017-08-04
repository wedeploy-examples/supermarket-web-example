package io.wedeploy.supermarket.view;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.BottomSheetDialogFragment;
import android.support.v7.app.AppCompatActivity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import io.wedeploy.supermarket.R;

/**
 * @author Silvio Santos
 */
public class FilterBottomSheet extends BottomSheetDialogFragment implements View.OnClickListener {

	public static void show(AppCompatActivity activity) {
		FilterBottomSheet bottomSheet = new FilterBottomSheet();
		bottomSheet.show(activity.getSupportFragmentManager(), TAG);
	}

	@Override
	public void onAttach(Context context) {
		super.onAttach(context);

		if (context instanceof OnFilterSelectedListener) {
			this.listener = (OnFilterSelectedListener)context;
		}
	}

	@Nullable
	@Override
	public View onCreateView(
		LayoutInflater inflater, @Nullable ViewGroup container,
		@Nullable Bundle savedInstanceState) {

		String[] types = getResources().getStringArray(R.array.filter);

		ViewGroup viewGroup = (ViewGroup)inflater.inflate(
			R.layout.bottom_sheet, container, false);

		for (String type : types) {
			TextView textView = (TextView)inflater.inflate(
				R.layout.bottom_sheet_item, viewGroup, false);

			textView.setText(type);
			textView.setOnClickListener(this);
			viewGroup.addView(textView);
		}

		return viewGroup;
	}

	@Override
	public void onClick(View view) {
		TextView textView = (TextView)view;
		listener.onFilterSelected(textView.getText().toString());
		dismiss();
	}

	private OnFilterSelectedListener listener;
	private static final String TAG = FilterBottomSheet.class.getSimpleName();

}
