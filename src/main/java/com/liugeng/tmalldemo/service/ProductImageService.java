package com.liugeng.tmalldemo.service;

import com.liugeng.tmalldemo.pojo.ProductImage;
import com.liugeng.tmalldemo.pojo.ProductImageExample;

import java.util.List;

public interface ProductImageService {
    String type_single = "type_single";
    String type_detail = "type_detail";

    void add(ProductImage productImage);
    void delete(int id);
    void update(ProductImage productImage);
    ProductImage get(int id);
    List<ProductImage> list(int pid, String type);
}
