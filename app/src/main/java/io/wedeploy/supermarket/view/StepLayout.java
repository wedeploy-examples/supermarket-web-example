package io.wedeploy.supermarket.view;

import android.animation.ObjectAnimator;
import android.annotation.TargetApi;
import android.content.Context;
import android.os.Build;
import android.support.annotation.AttrRes;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.StyleRes;
import android.support.transition.TransitionManager;
import android.util.AttributeSet;
import android.view.View;
import android.view.animation.DecelerateInterpolator;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.ProgressBar;
import android.widget.ViewAnimator;

import java.util.ArrayList;
import java.util.List;

import io.wedeploy.supermarket.R;

/**
 * @author Silvio Santos
 */
public class StepLayout extends FrameLayout {

    public StepLayout(@NonNull Context context) {
        super(context);

        init();
    }

    public StepLayout(@NonNull Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);

        init();
    }

    public StepLayout(@NonNull Context context, @Nullable AttributeSet attrs, @AttrRes int defStyleAttr) {
        super(context, attrs, defStyleAttr);

        init();
    }

    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    public StepLayout(
        @NonNull Context context, @Nullable AttributeSet attrs, @AttrRes int defStyleAttr, @StyleRes int defStyleRes) {

        super(context, attrs, defStyleAttr, defStyleRes);

        init();
    }

    public List<View> getStepViews() {
        List<View> stepViews = new ArrayList<>();

        for (int i = 0; i < viewAnimator.getChildCount(); i++) {
            stepViews.add(viewAnimator.getChildAt(i));
        }

        return stepViews;
    }

    @Override
    protected void onFinishInflate() {
        super.onFinishInflate();

        nextButton = (Button)findViewById(R.id.nextButton);
        previousButton = (Button)findViewById(R.id.previousButton);
        progressBar = (ProgressBar)findViewById(R.id.progressBar);
        viewAnimator = (ViewAnimator)findViewById(R.id.viewSwitcher);

        initViewAnimator();
        initProgressBar();
        initButtons();
    }

    private void initButtons() {
        nextButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                viewAnimator.showNext();

                setProgress();
                setPreviousButtonVisiblity();
            }
        });

        previousButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                viewAnimator.showPrevious();

                setProgress();
                setPreviousButtonVisiblity();
            }
        });
    }

    private void initProgressBar() {
        int max = viewAnimator.getChildCount();

        progressBar.setMax(max);
        progressBar.setProgress(1);
    }

    private void initViewAnimator() {
        int childCount = getChildCount();

        for (int i = childCount - 1; i >= 0; i--) {
            View child = getChildAt(i);

            if (child.getId() != R.id.step_layout_root) {
                removeViewAt(i);
                viewAnimator.addView(child, 0);
            }
        }

        viewAnimator.setDisplayedChild(0);
    }

    private void setPreviousButtonVisiblity() {
        if (getCurrentIndex() == 0) {
            previousButton.setVisibility(GONE);
        }
        else {
            previousButton.setVisibility(VISIBLE);
        }
    }

    private void setProgress() {
        int currentProgress = progressBar.getProgress();
        int progress = getCurrentIndex() + 1;

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            progressBar.setProgress(progress, true);
        }
        else {
            ObjectAnimator animation = ObjectAnimator.ofInt(
                    progressBar, "progress", currentProgress, progress);

            animation.setInterpolator(new DecelerateInterpolator());
            animation.setDuration(1000);
            animation.start();
        }
    }

    private int getCurrentIndex() {
        return viewAnimator.indexOfChild(viewAnimator.getCurrentView());
    }

    private void init() {
        inflate(getContext(), R.layout.step_layout, this);
    }

    private Button nextButton;
    private Button previousButton;
    private ProgressBar progressBar;
    private ViewAnimator viewAnimator;

}
