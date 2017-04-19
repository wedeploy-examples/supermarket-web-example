package io.wedeploy.supermarket.view;

import android.animation.ObjectAnimator;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.res.TypedArray;
import android.os.Build;
import android.support.annotation.AttrRes;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.StringRes;
import android.support.annotation.StyleRes;
import android.util.AttributeSet;
import android.view.View;
import android.view.animation.DecelerateInterpolator;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.ProgressBar;
import android.widget.ViewAnimator;
import io.wedeploy.supermarket.R;

/**
 * @author Silvio Santos
 */
public class StepLayout extends FrameLayout {

	public StepLayout(@NonNull Context context) {
		super(context);

		init(null);
	}

	public StepLayout(@NonNull Context context, @Nullable AttributeSet attrs) {
		super(context, attrs);

		init(attrs);
	}

	public StepLayout(
		@NonNull Context context, @Nullable AttributeSet attrs, @AttrRes int defStyleAttr) {
		super(context, attrs, defStyleAttr);

		init(attrs);
	}

	@TargetApi(Build.VERSION_CODES.LOLLIPOP)
	public StepLayout(
		@NonNull Context context, @Nullable AttributeSet attrs, @AttrRes int defStyleAttr,
		@StyleRes int defStyleRes) {

		super(context, attrs, defStyleAttr, defStyleRes);

		init(attrs);
	}

	public void setOnDoneClickListener(OnClickListener doneAction) {
		this.doneAction = doneAction;
	}

	public Button getNextButton() {
		return nextButton;
	}

	public Button getPreviousButton() {
		return previousButton;
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

	private int getCurrentIndex() {
		return viewAnimator.indexOfChild(viewAnimator.getCurrentView());
	}

	private void init(AttributeSet attributes) {
		Context context = getContext();

		inflate(context, R.layout.step_layout, this);

		TypedArray typedArray = context.getTheme().obtainStyledAttributes(
			attributes, R.styleable.StepLayout, 0, 0);

		doneButtonText = typedArray.getResourceId(R.styleable.StepLayout_doneButtonText, 0);
	}

	private void initButtons() {
		nextButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View view) {
				if (isLastView()) {
					if (doneAction != null) {
						doneAction.onClick(nextButton);
					}
				}
				else {
					viewAnimator.showNext();
					setProgress();
					setNextButtonLabel();
					setPreviousButtonVisibility();
				}
			}
		});

		previousButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View view) {
				viewAnimator.showPrevious();

				setProgress();
				setNextButtonLabel();
				setPreviousButtonVisibility();
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

	private boolean isLastView() {
		return getCurrentIndex() == viewAnimator.getChildCount() - 1;
	}

	private void setNextButtonLabel() {
		if (isLastView()) {
			nextButton.setText(doneButtonText);
		}
		else {
			nextButton.setText(R.string.next);
		}
	}

	private void setPreviousButtonVisibility() {
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

	private OnClickListener doneAction;

	@StringRes
	private int doneButtonText;
	private Button nextButton;
	private Button previousButton;
	private ProgressBar progressBar;
	private ViewAnimator viewAnimator;

}
