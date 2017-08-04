package io.wedeploy.supermarket.view;

import android.content.Context;
import android.support.annotation.AttrRes;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.util.AttributeSet;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.TextView;
import com.bumptech.glide.Glide;
import io.wedeploy.supermarket.R;
import jp.wasabeef.glide.transformations.CropCircleTransformation;

/**
 * @author Silvio Santos
 */
public class UserPhotoView extends FrameLayout {

	public UserPhotoView(@NonNull Context context) {
		super(context);

		init();
	}

	public UserPhotoView(@NonNull Context context, @Nullable AttributeSet attrs) {

		super(context, attrs);

		init();
	}

	public UserPhotoView(
		@NonNull Context context, @Nullable AttributeSet attrs, @AttrRes int defStyleAttr) {

		super(context, attrs, defStyleAttr);

		init();
	}

	public void setUserPhoto(String photoUrl, String name) {
		if ((photoUrl != null) && !photoUrl.isEmpty()) {
			userPhoto.setVisibility(VISIBLE);
			userPhotoDefault.setVisibility(GONE);

			Context context = getContext();

			Glide.with(context)
				.load(photoUrl)
				.placeholder(R.drawable.we_rounded_background)
				.bitmapTransform(new CropCircleTransformation(context))
				.into(userPhoto);
		}
		else {
			userPhoto.setVisibility(GONE);
			userPhotoDefault.setVisibility(VISIBLE);

			if (name != null && !name.isEmpty()) {
				userPhotoDefault.setText(String.valueOf(name.charAt(0)).toUpperCase());
			}
			else {
				userPhotoDefault.setText("A");
			}
		}
	}

	private void init() {
		inflate(getContext(), R.layout.user_photo, this);

		userPhoto = (ImageView)findViewById(R.id.photo);
		userPhotoDefault = (TextView)findViewById(R.id.photoDefault);
	}

	private ImageView userPhoto;
	private TextView userPhotoDefault;

}
