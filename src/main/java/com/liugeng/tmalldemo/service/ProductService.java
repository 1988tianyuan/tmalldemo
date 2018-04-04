package com.liugeng.tmalldemo.service;

import com.liugeng.tmalldemo.pojo.Product;

import java.util.List;

public interface ProductService {
    void add(Product product);
    void delete(int pid);
    void update(Product product);
    Product get(int pid);
    List<Product> list(int cid);
    void setFirstProductImage(List<Product> products);
}
