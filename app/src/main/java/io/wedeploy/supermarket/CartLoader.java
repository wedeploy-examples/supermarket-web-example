package io.wedeploy.supermarket;

import android.content.Context;
import android.support.v4.content.AsyncTaskLoader;
import android.util.Log;

import com.wedeploy.sdk.exception.WeDeployException;

import org.json.JSONException;

import java.util.List;

import io.wedeploy.supermarket.model.Product;
import io.wedeploy.supermarket.repository.SupermarketRepository;

/**
 * @author Silvio Santos
 */
public class CartLoader extends AsyncTaskLoader<List<Product>> {

    public CartLoader(Context context) {
        super(context);

        repository = new SupermarketRepository(Settings.getInstance(context));
    }

    @Override
    protected void onStartLoading() {
        if (products != null) {
            deliverResult(products);
        }
        else {
            forceLoad();
        }
    }

    @Override
    public List<Product> loadInBackground() {
        try {
            products = repository.getCart();

            return products;
        }
        catch (WeDeployException | JSONException e) {
            Log.e(getClass().getSimpleName(), e.getMessage());
        }

        return null;
    }

    private List<Product> products;
    private final SupermarketRepository repository;

}
