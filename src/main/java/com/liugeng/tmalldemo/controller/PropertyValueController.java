package com.liugeng.tmalldemo.controller;

import com.liugeng.tmalldemo.pojo.Product;
import com.liugeng.tmalldemo.pojo.PropertyValue;
import com.liugeng.tmalldemo.service.ProductService;
import com.liugeng.tmalldemo.service.PropertyValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("")
public class PropertyValueController {
    @Autowired
    PropertyValueService propertyValueService;
    @Autowired
    ProductService productService;

    @RequestMapping("admin_propertyValue_list")
    public String editPropertyValue(@RequestParam("id")int pid, Model model){
        Product product = productService.get(pid);
        propertyValueService.init(product);//在数据库中初始化创建
        List<PropertyValue> propertyValueList = propertyValueService.list(pid);
        model.addAttribute("propertyValueList", propertyValueList);
        model.addAttribute("product", product);
        return "admin/editPropertyValue";
    }

    @RequestMapping("admin_propertyValue_update")
    @ResponseBody
    public String updatePropertyValue(PropertyValue propertyValue){
        propertyValueService.update(propertyValue);
        return "success";
    }

}
