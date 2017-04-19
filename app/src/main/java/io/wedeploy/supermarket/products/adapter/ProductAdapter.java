package io.wedeploy.supermarket.products.adapter;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import io.wedeploy.supermarket.databinding.ItemProductBinding;
import io.wedeploy.supermarket.products.AddToCartListener;
import io.wedeploy.supermarket.products.ProductsActivity;
import io.wedeploy.supermarket.products.model.Product;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Silvio Santos
 */
public class ProductAdapter extends RecyclerView.Adapter<ProductAdapter.ProductViewHolder> {

	public ProductAdapter(ProductsActivity activity) {
		this.activity = activity;
		this.listener = activity;
	}

	@Override
	public ProductViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
		LayoutInflater inflater = LayoutInflater.from(parent.getContext());
		ItemProductBinding binding = ItemProductBinding.inflate(inflater, parent, false);

		return new ProductViewHolder(binding);
	}

	@Override
	public void onBindViewHolder(final ProductViewHolder holder, int position) {
		final Product product = products.get(position);
		holder.binding.setProduct(product);

		holder.binding.addToCartButton.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				int position = holder.getAdapterPosition();
				listener.onItemAddedToCart(products.get(position));
			}
		});
	}

	@Override
	public int getItemCount() {
		return products.size();
	}

	public void setItems(List<Product> products) {
		this.products.clear();

		if (products != null) {
			this.products.addAll(products);
		}

		notifyDataSetChanged();
	}

	private final ProductsActivity activity;
	private final AddToCartListener listener;
	private final List<Product> products = new ArrayList<>();

	class ProductViewHolder extends RecyclerView.ViewHolder {

		public ProductViewHolder(ItemProductBinding binding) {
			super(binding.getRoot());

			this.binding = binding;
		}

		final ItemProductBinding binding;
	}

}
