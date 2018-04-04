package com.liugeng.tmalldemo.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.liugeng.tmalldemo.pojo.Category;
import com.liugeng.tmalldemo.pojo.Property;
import com.liugeng.tmalldemo.service.CategoryService;
import com.liugeng.tmalldemo.service.PropertyService;
import com.liugeng.tmalldemo.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("")
public class PropertyController {
    @Autowired
    PropertyService propertyService;
    @Autowired
    CategoryService categoryService;

    @RequestMapping("admin_property_list")
    public String listProperty(Page page, Model model, @RequestParam("cid")int cid){
        Category category = categoryService.get(cid);
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Property> properties = propertyService.list(cid);
        int total = (int)new PageInfo<>(properties).getTotal();
        page.setTotal(total);
        page.setParam("&cid="+String.valueOf(cid));
        model.addAttribute("page", page);
        model.addAttribute("properties", properties);
        model.addAttribute("category",category);
        return "admin/listProperty";
    }

    @RequestMapping("admin_property_add")
    public String addProperty(Property property){
        propertyService.add(property);
        return "redirect:admin_property_list?cid="+property.getCid();
    }

    @RequestMapping("admin_property_delete")
    public String deleteProperty(@RequestParam("id")int id, @RequestParam("cid")int cid){
        propertyService.delete(id);
        return "redirect:admin_property_list?cid="+cid;
    }

    @RequestMapping("admin_property_edit")
    public String editProperty(@RequestParam("id")int id, Model model){
        Property property = propertyService.get(id);
        model.addAttribute("property", property);
        return "admin/editProperty";
    }

    @RequestMapping("admin_property_update")
    public String updateProperty(Property property){
        propertyService.update(property);
        return "redirect:admin_property_list?cid="+property.getCid();
    }

}
