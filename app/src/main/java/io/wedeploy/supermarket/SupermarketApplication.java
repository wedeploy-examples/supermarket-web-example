package io.wedeploy.supermarket;

import android.app.Application;
import android.content.Context;

/**
 * @author Silvio Santos
 */

public class SupermarketApplication extends Application {

	@Override
	public void onCreate() {
		super.onCreate();

		context = this;
	}

	public static Context getContext() {
		return context;
	}

	private static Context context;

}
