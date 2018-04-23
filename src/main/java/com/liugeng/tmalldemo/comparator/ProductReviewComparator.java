package com.liugeng.tmalldemo.comparator;

import com.liugeng.tmalldemo.pojo.Product;

import java.util.Comparator;

public class ProductReviewComparator implements Comparator<Product> {
    @Override
    public int compare(Product p1, Product p2) {
        int compareResult = p2.getReviewCount() - p1.getReviewCount();
        return compareResult;
    }
}
