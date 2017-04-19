package io.wedeploy.supermarket.signup;

import com.wedeploy.sdk.transport.Response;

/**
 * @author Silvio Santos
 */

interface SignUpListener {

	void onSignUpSuccess(Response response);

	void onSignUpFailed(Exception e);

}
