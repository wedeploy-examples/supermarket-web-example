package io.wedeploy.supermarket.resetpassword;

import com.wedeploy.sdk.transport.Response;

/**
 * @author Silvio Santos
 */

interface ResetPasswordListener {

	void onResetPasswordSuccess(Response response);

	void onResetPasswordFailed(Exception e);

}
