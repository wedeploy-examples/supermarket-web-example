package io.wedeploy.supermarket.products;

import android.content.Intent;
import android.databinding.DataBindingUtil;
import android.os.Bundle;
import android.support.transition.TransitionManager;
import android.support.v4.app.LoaderManager;
import android.support.v4.content.Loader;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Toast;
import io.wedeploy.supermarket.cart.CartActivity;
import io.wedeploy.supermarket.cart.CartItemListener;
import io.wedeploy.supermarket.R;
import io.wedeploy.supermarket.products.adapter.ProductAdapter;
import io.wedeploy.supermarket.databinding.ActivityMainBinding;
import io.wedeploy.supermarket.products.model.Product;
import io.wedeploy.supermarket.view.OnFilterSelectedListener;

import java.util.List;

/**
 * @author Silvio Santos
 */
public class ProductsActivity extends AppCompatActivity
	implements LoaderManager.LoaderCallbacks<List<Product>>, OnFilterSelectedListener,
	CartItemListener {

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
		showProducts();

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
	public void onGetCartItemCountSuccess(int count) {
		if (count > 0) {
			binding.cartItemCount.setText(String.valueOf(count));
			binding.cartItemCount.setVisibility(View.VISIBLE);
		}
		else {
			binding.cartItemCount.setVisibility(View.GONE);
		}
	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		binding = DataBindingUtil.setContentView(this, R.layout.activity_main);
		binding.productsList.setAdapter(adapter);
		binding.cartButton.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				startActivity(new Intent(ProductsActivity.this, CartActivity.class));
			}
		});

		if (savedInstanceState != null) {
			binding.filterBarView.setFilter(savedInstanceState.getString(STATE_FILTER));
		}
		else {
			binding.filterBarView.setFilter(getString(R.string.all));
		}

		showLoading();
		setSupportActionBar(binding.toolbar);
		getSupportLoaderManager().initLoader(0, null, this);
	}

	@Override
	protected void onResume() {
		super.onResume();

		CartItemCountRequest.getCartItemCount(this);
	}

	@Override
	protected void onSaveInstanceState(Bundle outState) {
		super.onSaveInstanceState(outState);

		outState.putString(STATE_FILTER, binding.filterBarView.getFilter());
	}

	private void showLoading() {
		TransitionManager.beginDelayedTransition(binding.rootLayout);
		binding.loading.setVisibility(View.VISIBLE);
		binding.productsList.setVisibility(View.INVISIBLE);
	}

	private void showProducts() {
		TransitionManager.beginDelayedTransition(binding.rootLayout);
		binding.loading.setVisibility(View.INVISIBLE);
		binding.productsList.setVisibility(View.VISIBLE);
	}

	private ProductAdapter adapter = new ProductAdapter();
	private ActivityMainBinding binding;

	private static final String STATE_FILTER = "filter";

}
