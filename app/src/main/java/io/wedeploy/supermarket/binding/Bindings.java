package io.wedeploy.supermarket.binding;

import android.content.Context;
import android.databinding.BindingAdapter;
import android.graphics.drawable.Drawable;
import android.support.annotation.AttrRes;
import android.support.annotation.BoolRes;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

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

	@BindingAdapter({"font"})
	public static void font(Button button, String fontName) {
		Font.setFont(button, fontName);
	}

}
