package io.wedeploy.supermarket;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;

import com.wedeploy.sdk.auth.Auth;
import com.wedeploy.sdk.auth.TokenAuth;

/**
 * @author Silvio Santos
 */
public class OAuthActivity extends AppCompatActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Auth auth = TokenAuth.getAuthFromIntent(getIntent());

        if (auth == null) {
            finish();
        }
        else {
            Settings.getInstance(this).saveToken(auth.getToken());
            startActivity(new Intent(this, MainActivity.class));
            finishAffinity();
        }
    }

}
