package io.wedeploy.supermarket.resetpassword;

/**
 * @author Silvio Santos
 */

interface ResetPasswordListener {

	void onResetPasswordSuccess();

	void onResetPasswordFailed(Exception e);

}
