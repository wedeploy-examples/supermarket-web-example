package io.wedeploy.supermarket.binding;

import android.content.Context;
import android.databinding.BindingAdapter;
import android.graphics.drawable.Drawable;
import android.widget.ImageView;

import com.bumptech.glide.Glide;

/**
 * @author Silvio Santos
 */

public class Bindings {

	@BindingAdapter({"imageUrl", "placeholder"})
	public static void loadImage(ImageView view, String url, Drawable placeholder) {
		Context context = view.getContext();

		Glide.with(context)
			.load(url)
			.placeholder(placeholder)
			.centerCrop()
			.into(view);
	}

}
