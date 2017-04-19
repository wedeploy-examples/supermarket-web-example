package io.wedeploy.supermarket.adapter;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import io.wedeploy.supermarket.databinding.ItemCartBinding;
import io.wedeploy.supermarket.model.CartProduct;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Silvio Santos
 */
public class CartAdapter extends RecyclerView.Adapter<CartAdapter.CartProductViewHolder> {

	@Override
	public CartProductViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
		LayoutInflater inflater = LayoutInflater.from(parent.getContext());
		ItemCartBinding binding = ItemCartBinding.inflate(inflater, parent, false);

		return new CartProductViewHolder(binding);
	}

	@Override
	public void onBindViewHolder(CartProductViewHolder holder, int position) {
		CartProduct cartProduct = products.get(position);
		holder.binding.setCartProduct(cartProduct);
	}

	@Override
	public int getItemCount() {
		return products.size();
	}

	public void setItems(List<CartProduct> products) {
		this.products.clear();

		if (products != null) {
			this.products.addAll(products);
		}

		notifyDataSetChanged();
	}

	private List<CartProduct> products = new ArrayList<>();

	class CartProductViewHolder extends RecyclerView.ViewHolder {

		ItemCartBinding binding;

		public CartProductViewHolder(ItemCartBinding binding) {
			super(binding.getRoot());

			this.binding = binding;
		}
	}

}
