package com.liugeng.tmalldemo.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.liugeng.tmalldemo.pojo.Category;
import com.liugeng.tmalldemo.pojo.Product;
import com.liugeng.tmalldemo.service.CategoryService;
import com.liugeng.tmalldemo.service.ProductImageService;
import com.liugeng.tmalldemo.service.ProductService;
import com.liugeng.tmalldemo.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("")
public class ProductController {
    @Autowired
    ProductService productService;
    @Autowired
    CategoryService categoryService;

    @RequestMapping("admin_product_list")
    public String listProduct(@RequestParam("cid")int cid, Model model, Page page){

        Category category = categoryService.get(cid);

        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Product> products = productService.list(cid);
        int total = (int)new PageInfo<>(products).getTotal();
        page.setParam("?cid=" + cid);
        page.setTotal(total);

        productService.setFirstProductImage(products);//将每个product都添加上缩略图

        model.addAttribute("products", products);
        model.addAttribute("category", category);
        model.addAttribute("page", page);

        return "admin/listProduct";
    }

    @RequestMapping("admin_product_add")
    public String addProduct(Product product){
        product.setCreateDate(new Date());
        productService.add(product);
        return "redirect:admin_product_list?cid=" + product.getCid();
    }

    @RequestMapping("admin_product_delete")
    public String deleteProduct(@RequestParam("id")int id, @RequestParam("cid")int cid){
        productService.delete(id);
        return "redirect:admin_product_list?cid=" + cid;
    }

    @RequestMapping("admin_product_edit")
    public String editProduct(@RequestParam("id")int id, Model model){
        Product product = productService.get(id);
        model.addAttribute("product", product);
        return "admin/editProduct";
    }

    @RequestMapping("admin_product_update")
    public String updateProduct(Product product){
        productService.update(product);
        return "redirect:admin_product_list?cid=" + product.getCid();
    }

}
