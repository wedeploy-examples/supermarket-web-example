package io.wedeploy.supermarket.repository;

import com.wedeploy.sdk.WeDeploy;
import com.wedeploy.sdk.auth.TokenAuth;
import com.wedeploy.sdk.exception.WeDeployException;
import com.wedeploy.sdk.query.filter.Filter;
import com.wedeploy.sdk.transport.Response;

import org.json.JSONArray;
import org.json.JSONException;

import java.util.ArrayList;
import java.util.List;

import io.wedeploy.supermarket.Settings;
import io.wedeploy.supermarket.model.Product;

import static com.wedeploy.sdk.query.filter.Filter.*;
import static com.wedeploy.sdk.query.filter.Filter.equal;
import static com.wedeploy.sdk.query.filter.Filter.match;

/**
 * @author Silvio Santos
 */
public class SupermarketRepository {

    public SupermarketRepository(Settings settings) {
        this.settings = settings;
        this.weDeploy = new WeDeploy.Builder()
                .build();
    }

    public List<Product> getCart() throws WeDeployException, JSONException {
        Response response = weDeploy
                .data(DATA_URL)
                .auth(settings.getToken())
                .where(exists("filename"))
                .orderBy("title")
                .get("cart")
                .execute();

        JSONArray jsonArray = new JSONArray(response.getBody());
        List<Product> products = new ArrayList<>(50);

        for (int i = 0; i < jsonArray.length(); i++) {
            products.add(new Product(jsonArray.getJSONObject(i)));
        }

        return products;
    }

    public List<Product> getProducts(String type) throws WeDeployException, JSONException {
        Filter typeFilter = (type != null) ? match("type", type) : not("type", "");

        Response response = weDeploy
                .data(DATA_URL)
                .auth(settings.getToken())
                .where(typeFilter.and(exists("filename")))
                .orderBy("title")
                .get("products")
                .execute();

        JSONArray jsonArray = new JSONArray(response.getBody());
        List<Product> products = new ArrayList<>(50);

        for (int i = 0; i < jsonArray.length(); i++) {
            products.add(new Product(jsonArray.getJSONObject(i)));
        }

        return products;
    }

    private static final String DATA_URL = "http://data.supermarket.wedeploy.io";
    private final Settings settings;
    private final WeDeploy weDeploy;

}
