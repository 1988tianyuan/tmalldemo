package com.liugeng.tmalldemo.service;

import com.liugeng.tmalldemo.pojo.Property;

import java.util.List;

public interface PropertyService {
    void delete(int id);
    void add(Property property);
    List<Property> list(int cid);
    Property get(int id);
    void update(Property property);
}
