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

import io.wedeploy.supermarket.model.Product;

import static com.wedeploy.sdk.query.filter.Filter.*;
import static com.wedeploy.sdk.query.filter.Filter.equal;
import static com.wedeploy.sdk.query.filter.Filter.match;

/**
 * @author Silvio Santos
 */
public class SupermarketRepository {

    public SupermarketRepository() {
        weDeploy = new WeDeploy.Builder()
                .build();
    }

    public List<Product> getCart() throws WeDeployException, JSONException {
        Response response = weDeploy
                .data(DATA_URL)
                .auth(new TokenAuth("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOlsic3VwZXJtYXJrZXQiXSwic3ViIjoiMTg3OTAyMDY2MzY1NzY0MDczIiwic2NvcGUiOltdLCJpc3MiOiJzdXBlcm1hcmtldC53ZWRlcGxveS5pbyIsIm5hbWUiOiJGYWtlIE5hbWUiLCJpYXQiOjE0OTA4MTAxMDIsImVtYWlsIjoidGVzdEB0ZXN0LmNvbSIsInBpY3R1cmUiOm51bGwsInByb3ZpZGVycyI6e319.0wHxuvjhEs37D3cW4MdyUkQQvXMcd2iYVQwky8ClMrw="))
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
                .auth(new TokenAuth("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOlsic3VwZXJtYXJrZXQiXSwic3ViIjoiMTg3OTAyMDY2MzY1NzY0MDczIiwic2NvcGUiOltdLCJpc3MiOiJzdXBlcm1hcmtldC53ZWRlcGxveS5pbyIsIm5hbWUiOiJGYWtlIE5hbWUiLCJpYXQiOjE0OTA4MTAxMDIsImVtYWlsIjoidGVzdEB0ZXN0LmNvbSIsInBpY3R1cmUiOm51bGwsInByb3ZpZGVycyI6e319.0wHxuvjhEs37D3cW4MdyUkQQvXMcd2iYVQwky8ClMrw="))
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

    private WeDeploy weDeploy;

}
