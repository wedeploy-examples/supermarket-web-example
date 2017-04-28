package io.wedeploy.supermarket.login;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;
import com.wedeploy.android.auth.TokenAuthorization;
import com.wedeploy.android.transport.Response;
import io.reactivex.SingleSource;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.annotations.NonNull;
import io.reactivex.functions.Consumer;
import io.reactivex.functions.Function;
import io.reactivex.observers.DisposableSingleObserver;
import io.reactivex.schedulers.Schedulers;
import io.wedeploy.supermarket.repository.SupermarketAuth;

/**
 * @author Silvio Santos
 */
public class LoginRequest extends Fragment {

	public LoginRequest() {
		setRetainInstance(true);
	}

	public static void login(AppCompatActivity activity, String email, String password) {
		LoginRequest request = new LoginRequest();
		request.email = email;
		request.password = password;

		FragmentTransaction transaction = activity.getSupportFragmentManager().beginTransaction();
		transaction.add(request, TAG);
		transaction.commit();
	}

	@Override
	public void onAttach(Context context) {
		super.onAttach(context);

		if (context instanceof LoginListener) {
			this.listener = (LoginListener)context;
		}
	}

	@Override
	public void onCreate(@Nullable Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		final SupermarketAuth auth = SupermarketAuth.getInstance();
		auth.signIn(email, password)
			.asSingle()
			.subscribeOn(Schedulers.io())
			.flatMap(new Function<Response, SingleSource<? extends Response>>() {
				@Override
				public SingleSource<? extends Response> apply(@NonNull Response response)
					throws Exception {
					String token = auth.saveToken(response);

					return auth.getUser(new TokenAuthorization(token))
						.asSingle()
						.subscribeOn(Schedulers.io());
				}
			})
			.doOnSuccess(new Consumer<Response>() {
				@Override
				public void accept(@NonNull Response response) throws Exception {
					auth.saveUser(response);
				}
			})
			.observeOn(AndroidSchedulers.mainThread())
			.subscribe(new DisposableSingleObserver<Response>() {
				@Override
				public void onSuccess(Response response) {
					listener.onLoginSuccess();
				}

				@Override
				public void onError(Throwable e) {
					listener.onLoginFailed(new Exception(e));
				}
			});
	}

	private String email;
	private LoginListener listener;
	private String password;

	private static final String TAG = LoginRequest.class.getSimpleName();

}
