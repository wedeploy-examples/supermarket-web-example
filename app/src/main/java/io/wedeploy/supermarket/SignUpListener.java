package io.wedeploy.supermarket;

import com.wedeploy.sdk.transport.Response;

/**
 * @author Silvio Santos
 */

interface SignUpListener {

	void onSignUpSuccess(Response response);

	void onSignUpFailed(Exception e);

}
