package io.wedeploy.supermarket.view;

import android.content.Context;
import android.support.annotation.AttrRes;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.util.AttributeSet;
import android.view.View;
import android.widget.FrameLayout;

import io.wedeploy.supermarket.R;
import io.wedeploy.supermarket.databinding.FilterBarViewBinding;

/**
 * @author Silvio Santos
 */
public class FilterBarView extends FrameLayout {

    public FilterBarView(@NonNull Context context) {
        super(context);

        init();
    }

    public FilterBarView(@NonNull Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);

        init();
    }

    public FilterBarView(
        @NonNull Context context, @Nullable AttributeSet attrs, @AttrRes int defStyleAttr) {

        super(context, attrs, defStyleAttr);

        init();
    }

    public String getFilter() {
        return binding.filter.getText().toString();
    }

    public void setFilter(String filter) {
        binding.filter.setText(filter);
    }

    private void init() {
        inflate(getContext(), R.layout.filter_bar_view, this);

        if (isInEditMode()) {
            return;
        }

        binding = FilterBarViewBinding.bind(getChildAt(0));
        binding.container.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                FilterBottomSheet.show((AppCompatActivity)getContext());

            }
        });

    }

    private FilterBarViewBinding binding;

}
