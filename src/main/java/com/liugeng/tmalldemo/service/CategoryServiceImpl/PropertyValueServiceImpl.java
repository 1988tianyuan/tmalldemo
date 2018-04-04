package com.liugeng.tmalldemo.service.CategoryServiceImpl;

import com.liugeng.tmalldemo.mapper.PropertyValueMapper;
import com.liugeng.tmalldemo.pojo.Product;
import com.liugeng.tmalldemo.pojo.Property;
import com.liugeng.tmalldemo.pojo.PropertyValue;
import com.liugeng.tmalldemo.pojo.PropertyValueExample;
import com.liugeng.tmalldemo.service.PropertyService;
import com.liugeng.tmalldemo.service.PropertyValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PropertyValueServiceImpl implements PropertyValueService{
    @Autowired
    PropertyValueMapper propertyValueMapper;
    @Autowired
    PropertyService propertyService;


    /**
    * 属性值的初始化，如果该产品的属性值还不存在，则添加；
     * 每个property都要相应的添加一个propertyValue
     * 如果每个category对应的property有改动，也可以第一时间更新往数据库更新propertyValue
    * */
    @Override
    public void init(Product product) {
        List<Property> properties = propertyService.list(product.getCid());
        for(Property property:properties){
            PropertyValue propertyValue = get(product.getId(), property.getId());
            if(null == propertyValue){
                propertyValue = new PropertyValue();
                propertyValue.setPid(product.getId());
                propertyValue.setPtid(property.getId());
                propertyValueMapper.insertSelective(propertyValue);
            }
        }
    }

    @Override
    public void update(PropertyValue propertyValue) {
        propertyValueMapper.updateByPrimaryKeySelective(propertyValue);
    }

    @Override
    public PropertyValue get(int pid, int ptid) {
        PropertyValueExample propertyValueExample = new PropertyValueExample();
        propertyValueExample.createCriteria().andPidEqualTo(pid).andPtidEqualTo(ptid);
        List<PropertyValue> propertyValues = propertyValueMapper.selectByExample(propertyValueExample);
        setProperty(propertyValues);
        if(propertyValues.isEmpty()) return null;
        return propertyValues.get(0);
    }

    @Override
    public List<PropertyValue> list(int pid) {
        PropertyValueExample propertyValueExample = new PropertyValueExample();
        propertyValueExample.createCriteria().andPidEqualTo(pid);
        List<PropertyValue> propertyValues = propertyValueMapper.selectByExample(propertyValueExample);
        setProperty(propertyValues);
        return propertyValues;
    }

    public void setProperty(List<PropertyValue> propertyValues){
        for(PropertyValue propertyValue:propertyValues){
            Property property = propertyService.get(propertyValue.getPtid());
            propertyValue.setProperty(property);
        }
    }

}
