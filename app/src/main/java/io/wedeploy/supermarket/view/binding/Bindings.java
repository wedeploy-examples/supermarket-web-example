package io.wedeploy.supermarket.view.binding;

import android.content.Context;
import android.databinding.BindingAdapter;
import android.graphics.drawable.Drawable;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import com.bumptech.glide.Glide;
import com.bumptech.glide.load.resource.bitmap.CenterCrop;
import io.wedeploy.supermarket.R;
import jp.wasabeef.glide.transformations.RoundedCornersTransformation;

/**
 * @author Silvio Santos
 */

public class Bindings {

	@BindingAdapter({"imageUrl", "placeholder"})
	public static void loadImage(ImageView view, String url, Drawable placeholder) {
		Context context = view.getContext();
		int corderRadius = context.getResources().getDimensionPixelSize(R.dimen
			.image_corner_radius);

		Glide.with(context)
			.load(url)
			.placeholder(placeholder)
			.bitmapTransform(
				new CenterCrop(context),
				new RoundedCornersTransformation(context, corderRadius, 0))
			.into(view);
	}

	@BindingAdapter({"font"})
	public static void font(Button button, String fontName) {
		Font.setFont(button, fontName);
	}

	@BindingAdapter({"font"})
	public static void font(TextView textView, String fontName) {
		Font.setFont(textView, fontName);
	}

}
