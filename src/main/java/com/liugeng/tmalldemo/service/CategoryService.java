package com.liugeng.tmalldemo.service;

import com.liugeng.tmalldemo.pojo.Category;
import com.liugeng.tmalldemo.utils.Page;

import java.util.List;

public interface CategoryService {
//    public List<Category> list(Page page);
//    public int total();
    public List<Category> listByCategoryExample();
    public List<Category> list();
    public void add(Category category);
    public void delete(int id);
    public Category get(int id);
    public void update(Category category);
}
