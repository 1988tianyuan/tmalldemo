package com.liugeng.tmalldemo.service.CategoryServiceImpl;

import com.liugeng.tmalldemo.mapper.CategoryMapper;
import com.liugeng.tmalldemo.pojo.Category;
import com.liugeng.tmalldemo.pojo.CategoryExample;
import com.liugeng.tmalldemo.service.CategoryService;
import com.liugeng.tmalldemo.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService{
    @Autowired
    CategoryMapper categoryMapper;

//    @Override
//    public List<Category> list(Page page) {
//        return categoryMapper.list(page);
//    }
//
//    @Override
//    public int total() {
//        return categoryMapper.total();
//    }

    @Override
    public List<Category> listByCategoryExample() {
        CategoryExample categoryExample = new CategoryExample();

        //设置第一个和第二个条件：name的模糊查询，即包含“测试”又包含“1”；这两个条件是and关系
        CategoryExample.Criteria criteria1 = categoryExample.createCriteria();
        criteria1.andNameLike("%测试%");
        criteria1.andNameLike("%1%");
        categoryExample.or(criteria1);

        //设置第三个条件：id大于10；该条件与上个条件是or关系
        CategoryExample.Criteria criteria2 = categoryExample.or();
        criteria2.andIdLessThan(5);
        categoryExample.or(criteria2);

        return categoryMapper.selectByExample(categoryExample);
    }

    @Override
    public List<Category> list() {
        CategoryExample categoryExample = new CategoryExample();
        categoryExample.setOrderByClause("id ASC");
        return categoryMapper.selectByExample(categoryExample);
    }

    @Override
    public void add(Category category) {
        categoryMapper.insertSelective(category);
    }

    @Override
    public void delete(int id) {
        categoryMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Category get(int id){
        return categoryMapper.selectByPrimaryKey(id);
    }

    @Override
    public void update(Category category) {
        categoryMapper.updateByPrimaryKeySelective(category);
    }
}
