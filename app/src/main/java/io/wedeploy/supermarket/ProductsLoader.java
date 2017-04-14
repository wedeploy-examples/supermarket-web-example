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
public class ProductsLoader extends AsyncTaskLoader<List<Product>> {

    public ProductsLoader(Context context, String filter) {
        super(context);

        this.filter = filter;
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
            String type = ("all".equalsIgnoreCase(filter)) ? null : filter;

            products = repository.getProducts(type);

            return products;
        }
        catch (WeDeployException | JSONException e) {
            Log.e(getClass().getSimpleName(), e.getMessage());
        }

        return null;
    }

    private final String filter;
    private List<Product> products;
    private SupermarketRepository repository = new SupermarketRepository();

}
