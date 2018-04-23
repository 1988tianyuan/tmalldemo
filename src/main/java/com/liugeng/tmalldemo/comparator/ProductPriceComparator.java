package com.liugeng.tmalldemo.comparator;

import com.liugeng.tmalldemo.pojo.Product;

import java.util.Comparator;

public class ProductPriceComparator implements Comparator<Product> {
    @Override
    public int compare(Product p1, Product p2) {
        return (int)(p2.getPromotePrice() - p1.getPromotePrice());
    }
}
