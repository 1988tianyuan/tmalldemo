package com.liugeng.tmalldemo.controller;

import com.liugeng.tmalldemo.pojo.Category;
import com.liugeng.tmalldemo.service.CategoryService;
import com.liugeng.tmalldemo.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class ForeController {
    @Autowired
    ProductService productService;
    @Autowired
    CategoryService categoryService;


    @RequestMapping("forehome")
    public String listCategory(Model model){
        List<Category> categories = categoryService.list();
        productService.fill(categories);
        model.addAttribute("categories", categories);
        productService.fillByRow(categories);
        return "fore/home";
    }
}
