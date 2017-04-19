package io.wedeploy.supermarket.signup;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;
import com.wedeploy.sdk.transport.Response;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.observers.DisposableSingleObserver;
import io.reactivex.schedulers.Schedulers;
import io.wedeploy.supermarket.repository.Settings;
import io.wedeploy.supermarket.repository.SupermarketAuth;

/**
 * @author Silvio Santos
 */
public class SignUpRequest extends Fragment {

	public static void signUp(
		AppCompatActivity activity, String email, String password, String name) {

		SignUpRequest request = new SignUpRequest();
		request.setRetainInstance(true);
		request.email = email;
		request.password = password;
		request.name = name;

		FragmentTransaction transaction = activity.getSupportFragmentManager().beginTransaction();
		transaction.add(request, TAG);
		transaction.commit();
	}

	@Override
	public void onAttach(Context context) {
		super.onAttach(context);

		if (context instanceof SignUpListener) {
			this.listener = (SignUpListener)context;
		}
	}

	@Override
	public void onCreate(@Nullable Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		SupermarketAuth auth = SupermarketAuth.getInstance();
		auth.signUp(email, password, name)
			.subscribeOn(Schedulers.io())
			.observeOn(AndroidSchedulers.mainThread())
			.subscribe(new DisposableSingleObserver<Response>() {
				@Override
				public void onSuccess(Response response) {
					listener.onSignUpSuccess(response);
				}

				@Override
				public void onError(Throwable e) {
					listener.onSignUpFailed(new Exception(e));
				}
			});
	}

	private String email;
	private SignUpListener listener;
	private String name;
	private String password;
	private static final String TAG = SignUpRequest.class.getSimpleName();

}
