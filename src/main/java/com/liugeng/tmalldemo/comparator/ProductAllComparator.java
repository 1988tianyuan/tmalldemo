package com.liugeng.tmalldemo.comparator;

import com.liugeng.tmalldemo.pojo.Product;

import java.util.Comparator;

public class ProductAllComparator implements Comparator<Product>{
    @Override
    public int compare(Product product1, Product product2) {
        int compareResult = product1.getSaleCount()*product1.getReviewCount() - product2.getSaleCount()*product2.getReviewCount();
        return compareResult;
    }
}
