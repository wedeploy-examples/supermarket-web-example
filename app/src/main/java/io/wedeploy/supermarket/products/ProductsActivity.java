package io.wedeploy.supermarket.products;

import android.content.Intent;
import android.databinding.DataBindingUtil;
import android.os.Bundle;
import android.support.transition.Fade;
import android.support.transition.TransitionManager;
import android.support.v4.app.LoaderManager;
import android.support.v4.content.Loader;
import android.support.v7.app.AppCompatActivity;
import android.text.TextUtils;
import android.view.View;
import android.widget.Toast;
import io.wedeploy.supermarket.R;
import io.wedeploy.supermarket.cart.CartActivity;
import io.wedeploy.supermarket.cart.CartItemListener;
import io.wedeploy.supermarket.databinding.ActivityMainBinding;
import io.wedeploy.supermarket.logout.LogoutBottomSheet;
import io.wedeploy.supermarket.products.adapter.ProductAdapter;
import io.wedeploy.supermarket.products.model.Product;
import io.wedeploy.supermarket.repository.Settings;
import io.wedeploy.supermarket.view.OnFilterSelectedListener;

import java.util.List;

/**
 * @author Silvio Santos
 */
public class ProductsActivity extends AppCompatActivity
	implements LoaderManager.LoaderCallbacks<List<Product>>, OnFilterSelectedListener,
	CartItemListener, AddToCartListener {

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
		updateCartItemCount(count);
	}

	@Override
	public void onItemAddedToCart(Product product) {
		String countText = binding.cartItemCount.getText().toString();
		int count = 0;

		if (TextUtils.isDigitsOnly(countText)) {
			count = Integer.valueOf(countText);
		}

		updateCartItemCount(count + 1);

		AddToCartRequest.addToCart(this, product);
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

		binding.userPhoto.setUserPhoto(Settings.getUserPhoto(), Settings.getUserName());
		binding.userPhoto.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				LogoutBottomSheet.show(ProductsActivity.this);
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
		TransitionManager.beginDelayedTransition(binding.rootLayout, new Fade());
		binding.loading.setVisibility(View.VISIBLE);
		binding.productsList.setVisibility(View.INVISIBLE);
	}

	private void showProducts() {
		TransitionManager.beginDelayedTransition(binding.rootLayout, new Fade());
		binding.loading.setVisibility(View.INVISIBLE);
		binding.productsList.setVisibility(View.VISIBLE);
	}

	private void updateCartItemCount(int count) {
		binding.cartItemCount.setText(String.valueOf(count));
		binding.cartItemCount.setVisibility((count > 0) ? View.VISIBLE : View.GONE);
	}

	private final ProductAdapter adapter = new ProductAdapter(this);
	private ActivityMainBinding binding;

	private static final String STATE_FILTER = "filter";

}
