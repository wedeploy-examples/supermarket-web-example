package io.wedeploy.supermarket.view;

import android.content.Context;
import android.support.annotation.AttrRes;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.util.AttributeSet;
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

    private void init() {
        inflate(getContext(), R.layout.filter_bar_view, this);

        if (isInEditMode()) {
            return;
        }

        FilterBarViewBinding.bind(getChildAt(0));
    }
}
