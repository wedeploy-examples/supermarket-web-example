package io.wedeploy.supermarket.cart.adapter;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import io.wedeploy.supermarket.cart.DeleteFromCartListener;
import io.wedeploy.supermarket.cart.model.CartProduct;
import io.wedeploy.supermarket.databinding.ItemCartBinding;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Silvio Santos
 */
public class CartAdapter extends RecyclerView.Adapter<CartAdapter.CartProductViewHolder> {

	public CartAdapter(DeleteFromCartListener listener) {
		this.listener = listener;
	}

	public List<CartProduct> getCartProducts() {
		return cartProducts;
	}

	@Override
	public CartProductViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
		LayoutInflater inflater = LayoutInflater.from(parent.getContext());
		ItemCartBinding binding = ItemCartBinding.inflate(inflater, parent, false);

		return new CartProductViewHolder(binding);
	}

	@Override
	public void onBindViewHolder(final CartProductViewHolder holder, int position) {
		CartProduct cartProduct = cartProducts.get(position);
		holder.binding.setCartProduct(cartProduct);
		holder.binding.deleteFromCartButton.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				int position = holder.getAdapterPosition();
				CartProduct deletedItem = cartProducts.get(position);
				cartProducts.remove(position);
				notifyItemRemoved(position);

				listener.onDeleteFromCart(deletedItem);
			}
		});
	}

	@Override
	public int getItemCount() {
		return cartProducts.size();
	}

	public void setItems(List<CartProduct> cartProducts) {
		this.cartProducts.clear();

		if (cartProducts != null) {
			this.cartProducts.addAll(cartProducts);
		}

		notifyDataSetChanged();
	}

	private final List<CartProduct> cartProducts = new ArrayList<>();
	private final DeleteFromCartListener listener;

	class CartProductViewHolder extends RecyclerView.ViewHolder {

		public CartProductViewHolder(ItemCartBinding binding) {
			super(binding.getRoot());

			this.binding = binding;
		}

		final ItemCartBinding binding;
	}

}
