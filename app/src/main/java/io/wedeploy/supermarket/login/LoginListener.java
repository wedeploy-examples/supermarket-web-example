package io.wedeploy.supermarket.login;

import com.wedeploy.sdk.transport.Response;

/**
 * @author Silvio Santos
 */
interface LoginListener {

    void onLoginSuccess(Response response);

    void onLoginFailed(Exception exception);

}
