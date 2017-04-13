package io.wedeploy.supermarket;

import android.databinding.DataBindingUtil;
import android.support.v4.app.LoaderManager;
import android.support.v4.content.Loader;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.Toast;

import java.util.List;

import io.wedeploy.supermarket.adapter.ProductAdapter;
import io.wedeploy.supermarket.databinding.ActivityMainBinding;
import io.wedeploy.supermarket.model.Product;

/**
 * @author Silvio Santos
 */
public class MainActivity extends AppCompatActivity
    implements LoaderManager.LoaderCallbacks<List<Product>> {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        ActivityMainBinding binding = DataBindingUtil.setContentView(this, R.layout.activity_main);
        binding.productsList.setAdapter(adapter);

        getSupportLoaderManager().initLoader(0, null, this);
    }

    @Override
    public Loader<List<Product>> onCreateLoader(int id, Bundle args) {
        return new ProductsLoader(this);
    }

    @Override
    public void onLoadFinished(Loader<List<Product>> loader, List<Product> products) {
        if (products == null) {
            Toast.makeText(this, "Could not load products", Toast.LENGTH_LONG).show();

            return;
        }

        adapter.setItems(products);
    }

    @Override
    public void onLoaderReset(Loader<List<Product>> loader) {
        adapter.setItems(null);
    }

    private ProductAdapter adapter = new ProductAdapter();

}
