package io.wedeploy.supermarket;

import android.app.Application;
import android.content.Context;

/**
 * @author Silvio Santos
 */

public class SupermarketApplication extends Application {

	public static Context getContext() {
		return context;
	}

	@Override
	public void onCreate() {
		super.onCreate();

		context = this;
	}

	private static Context context;

}
