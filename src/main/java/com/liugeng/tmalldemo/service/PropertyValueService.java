package com.liugeng.tmalldemo.service;

import com.liugeng.tmalldemo.pojo.Product;
import com.liugeng.tmalldemo.pojo.PropertyValue;

import java.util.List;

public interface PropertyValueService {
    void init(Product product);
    void update(PropertyValue propertyValue);
    PropertyValue get(int pid, int ptid);
    List<PropertyValue> list(int pid);
}
