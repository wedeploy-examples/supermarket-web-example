package io.wedeploy.supermarket;

import android.databinding.DataBindingUtil;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.LoaderManager;
import android.support.v4.content.Loader;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

import java.util.List;

import io.wedeploy.supermarket.adapter.CartAdapter;
import io.wedeploy.supermarket.databinding.ActivityCartBinding;
import io.wedeploy.supermarket.model.CartProduct;
import io.wedeploy.supermarket.model.Product;

/**
 * @author Silvio Santos
 */
public class CartActivity extends AppCompatActivity
    implements LoaderManager.LoaderCallbacks<List<CartProduct>> {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = DataBindingUtil.setContentView(this, R.layout.activity_cart);
        binding.cartList.setAdapter(adapter);

        setSupportActionBar(binding.toolbar);

        getSupportLoaderManager().initLoader(0, null, this);
    }

    @Override
    public Loader<List<CartProduct>> onCreateLoader(int id, Bundle args) {
        return new CartLoader(this);
    }

    @Override
    public void onLoadFinished(Loader<List<CartProduct>> loader, List<CartProduct> products) {
        if (products == null) {
            return;
        }

        adapter.setItems(products);

        if (products.isEmpty()) {
            showEmptyCart();

            return;
        }

        showCartProducts();
    }

    private void showCartProducts() {
        binding.emptyView.setVisibility(View.GONE);
        binding.cartList.setVisibility(View.VISIBLE);
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
        binding.emptyView.setVisibility(View.VISIBLE);
        binding.cartList.setVisibility(View.GONE);
        binding.button.setText(R.string.start_shopping);
        binding.button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
    }

    @Override
    public void onLoaderReset(Loader<List<CartProduct>> loader) {
        adapter.setItems(null);
    }

    private CartAdapter adapter = new CartAdapter();
    private ActivityCartBinding binding;
}
