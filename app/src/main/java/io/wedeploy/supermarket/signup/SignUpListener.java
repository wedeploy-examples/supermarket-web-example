package io.wedeploy.supermarket.signup;

/**
 * @author Silvio Santos
 */

interface SignUpListener {

	void onSignUpSuccess();

	void onSignUpFailed(Exception e);

}
