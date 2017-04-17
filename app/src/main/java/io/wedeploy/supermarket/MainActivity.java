package io.wedeploy.supermarket;

import android.databinding.DataBindingUtil;
import android.databinding.ViewDataBinding;
import android.support.v4.app.LoaderManager;
import android.support.v4.content.Loader;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.Toast;

import java.util.List;

import io.wedeploy.supermarket.adapter.ProductAdapter;
import io.wedeploy.supermarket.databinding.ActivityMainBinding;
import io.wedeploy.supermarket.model.Product;
import io.wedeploy.supermarket.view.OnFilterSelectedListener;

/**
 * @author Silvio Santos
 */
public class MainActivity extends AppCompatActivity
    implements LoaderManager.LoaderCallbacks<List<Product>>, OnFilterSelectedListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = DataBindingUtil.setContentView(this, R.layout.activity_main);
        binding.productsList.setAdapter(adapter);

        if (savedInstanceState != null) {
            binding.filterBarView.setFilter(savedInstanceState.getString(STATE_FILTER));
        }
        else {
            binding.filterBarView.setFilter(getString(R.string.all));
        }

        setSupportActionBar(binding.toolbar);

        getSupportLoaderManager().initLoader(0, null, this);
    }

    @Override
    public void onFilterSelected(String filter) {
        binding.filterBarView.setFilter(filter);

        getSupportLoaderManager().restartLoader(0, null, this);
    }

    @Override
    public Loader<List<Product>> onCreateLoader(int id, Bundle args) {
        return new ProductsLoader(this, binding.filterBarView.getFilter());
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

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);

        outState.putString(STATE_FILTER, binding.filterBarView.getFilter());
    }

    private static final String STATE_FILTER = "filter";

    private ProductAdapter adapter = new ProductAdapter();
    private ActivityMainBinding binding;

}
