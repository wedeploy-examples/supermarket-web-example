package io.wedeploy.supermarket.oauth;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.widget.Toast;
import com.wedeploy.sdk.auth.Authorization;
import com.wedeploy.sdk.auth.TokenAuthorization;
import com.wedeploy.sdk.transport.Response;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.annotations.NonNull;
import io.reactivex.functions.Consumer;
import io.reactivex.observers.DisposableSingleObserver;
import io.reactivex.schedulers.Schedulers;
import io.wedeploy.supermarket.R;
import io.wedeploy.supermarket.products.ProductsActivity;
import io.wedeploy.supermarket.repository.Settings;
import io.wedeploy.supermarket.repository.SupermarketAuth;

/**
 * @author Silvio Santos
 */
public class OAuthActivity extends AppCompatActivity {

	@Override
	protected void onCreate(@Nullable Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		Authorization authorization = TokenAuthorization.getAuthorizationFromIntent(getIntent());

		if (authorization == null) {
			finish();
		}
		else {
			Settings.saveToken(authorization.getToken());

			final SupermarketAuth auth = SupermarketAuth.getInstance();
			auth.getUser(authorization)
				.asSingle()
				.subscribeOn(Schedulers.io())
				.observeOn(AndroidSchedulers.mainThread())
				.doOnSuccess(new Consumer<Response>() {
					@Override
					public void accept(@NonNull Response response) throws Exception {
						auth.saveUser(response);
					}
				})
				.subscribe(new DisposableSingleObserver<Response>() {
					@Override
					public void onSuccess(Response response) {
						Intent intent = new Intent(OAuthActivity.this, ProductsActivity.class);
						startActivity(intent);
						finishAffinity();
					}

					@Override
					public void onError(Throwable e) {
						Toast.makeText(
							OAuthActivity.this,
							getString(R.string.could_not_sign_in_please_try_again),
							Toast.LENGTH_SHORT).show();
					}
				});
		}
	}

}
