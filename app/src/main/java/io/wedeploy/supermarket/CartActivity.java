package io.wedeploy.supermarket;

import android.databinding.DataBindingUtil;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.transition.TransitionManager;
import android.support.v4.app.LoaderManager;
import android.support.v4.content.Loader;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Toast;
import io.wedeploy.supermarket.adapter.CartAdapter;
import io.wedeploy.supermarket.databinding.ActivityCartBinding;
import io.wedeploy.supermarket.model.CartProduct;

import java.util.List;

/**
 * @author Silvio Santos
 */
public class CartActivity extends AppCompatActivity
	implements LoaderManager.LoaderCallbacks<List<CartProduct>> {

	@Override
	public Loader<List<CartProduct>> onCreateLoader(int id, Bundle args) {
		return new CartLoader(this);
	}

	@Override
	public void onLoadFinished(Loader<List<CartProduct>> loader, List<CartProduct> products) {
		showCartProducts();

		if (products == null) {
			Toast.makeText(this, "Could not load products", Toast.LENGTH_LONG).show();

			return;
		}

		if (products.isEmpty()) {
			showEmptyCart();

			return;
		}

		adapter.setItems(products);
	}

	@Override
	public void onLoaderReset(Loader<List<CartProduct>> loader) {
		adapter.setItems(null);
	}

	@Override
	protected void onCreate(@Nullable Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		binding = DataBindingUtil.setContentView(this, R.layout.activity_cart);
		binding.cartList.setAdapter(adapter);

		setSupportActionBar(binding.toolbar);

		showLoading();
		getSupportLoaderManager().initLoader(0, null, this);
	}

	private void showCartProducts() {
		TransitionManager.beginDelayedTransition(binding.rootLayout);
		binding.emptyView.setVisibility(View.INVISIBLE);
		binding.loading.setVisibility(View.INVISIBLE);
		binding.cartList.setVisibility(View.VISIBLE);
		binding.button.setVisibility(View.VISIBLE);
		binding.button.setText(R.string.checkout);
		binding.button.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				//TODO SEND EMAIL
				finish();
			}
		});
	}

	private void showEmptyCart() {
		TransitionManager.beginDelayedTransition(binding.rootLayout);
		binding.emptyView.setVisibility(View.VISIBLE);
		binding.loading.setVisibility(View.INVISIBLE);
		binding.cartList.setVisibility(View.INVISIBLE);
		binding.button.setVisibility(View.VISIBLE);
		binding.button.setText(R.string.start_shopping);
		binding.button.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				finish();
			}
		});
	}

	private void showLoading() {
		TransitionManager.beginDelayedTransition(binding.rootLayout);
		binding.emptyView.setVisibility(View.INVISIBLE);
		binding.loading.setVisibility(View.VISIBLE);
		binding.cartList.setVisibility(View.INVISIBLE);
		binding.button.setVisibility(View.INVISIBLE);
	}

	private CartAdapter adapter = new CartAdapter();
	private ActivityCartBinding binding;
}
