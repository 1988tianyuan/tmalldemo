package com.liugeng.tmalldemo.service.CategoryServiceImpl;

import com.liugeng.tmalldemo.mapper.PropertyMapper;
import com.liugeng.tmalldemo.pojo.Property;
import com.liugeng.tmalldemo.pojo.PropertyExample;
import com.liugeng.tmalldemo.service.PropertyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PropertyServiceImpl implements PropertyService{
    @Autowired
    PropertyMapper propertyMapper;

    @Override
    public void delete(int id) {
        propertyMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void add(Property property) {
        propertyMapper.insertSelective(property);
    }

    @Override
    public List<Property> list(int cid) {
        PropertyExample propertyExample = new PropertyExample();
        PropertyExample.Criteria criteria = propertyExample.createCriteria();
        criteria.andCidEqualTo(cid);
        propertyExample.setOrderByClause("id ASC");
        return propertyMapper.selectByExample(propertyExample);
    }

    @Override
    public Property get(int id) {
        return propertyMapper.selectByPrimaryKey(id);
    }

    @Override
    public void update(Property property) {
        propertyMapper.updateByPrimaryKeySelective(property);
    }
}
