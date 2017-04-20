package io.wedeploy.supermarket.view;

import android.app.Activity;
import android.content.Context;
import android.content.res.TypedArray;
import android.support.annotation.AttrRes;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.util.AttributeSet;
import android.view.View;
import android.widget.FrameLayout;
import io.wedeploy.supermarket.R;
import io.wedeploy.supermarket.databinding.SocialLoginButtonsBinding;
import io.wedeploy.supermarket.repository.SupermarketAuth;

import static com.wedeploy.sdk.auth.ProviderAuthorization.Provider.FACEBOOK;
import static com.wedeploy.sdk.auth.ProviderAuthorization.Provider.GOOGLE;

/**
 * @author Silvio Santos
 */
public class SocialLoginInButtons extends FrameLayout {
	public SocialLoginInButtons(@NonNull Context context) {
		super(context);

		init(null);
	}

	public SocialLoginInButtons(@NonNull Context context, @Nullable AttributeSet attrs) {
		super(context, attrs);

		init(attrs);
	}

	public SocialLoginInButtons(
		@NonNull Context context, @Nullable AttributeSet attrs, @AttrRes int defStyleAttr) {

		super(context, attrs, defStyleAttr);

		init(attrs);
	}

	private void init(AttributeSet attributes) {
		final Context context = getContext();

		inflate(context, R.layout.social_login_buttons, this);

		if (isInEditMode()) {
			return;
		}

		SocialLoginButtonsBinding binding = SocialLoginButtonsBinding.bind(getChildAt(0));

		if (attributes != null) {
			TypedArray typedArray = context.getTheme().obtainStyledAttributes(
				attributes, R.styleable.SocialLoginInButtons, 0, 0);

			String title = typedArray.getString(R.styleable.SocialLoginInButtons_title);
			binding.title.setText(title);
		}

		binding.facebookSignIn.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View view) {
				SupermarketAuth.getInstance().signIn((Activity)context, FACEBOOK);
			}
		});

		binding.googleSignIn.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View view) {
				SupermarketAuth.getInstance().signIn((Activity)context, GOOGLE);
			}
		});
	}

}
