package com.liugeng.tmalldemo.controller;

import com.liugeng.tmalldemo.comparator.*;
import com.liugeng.tmalldemo.pojo.*;
import com.liugeng.tmalldemo.service.*;
import com.sun.org.apache.xpath.internal.operations.Bool;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Collections;
import java.util.List;

@Controller
public class ForeController {
    @Autowired
    ProductService productService;
    @Autowired
    CategoryService categoryService;
    @Autowired
    UserService userService;
    @Autowired
    ProductImageService productImageService;
    @Autowired
    PropertyValueService propertyValueService;
    @Autowired
    ReviewService reviewService;

    @RequestMapping("forehome")
    public String listCategory(Model model){
        List<Category> categories = categoryService.list();
        productService.fill(categories);
        model.addAttribute("categories", categories);
        productService.fillByRow(categories);
        return "fore/home";
    }

    @RequestMapping("registerConfirm")
    public String registerConfirm(User user, Model model){
        Boolean isNotExist = userService.nameCheck(user.getName());
        if(isNotExist){
            userService.add(user);
            return "redirect:registerSuccess";
        }else {
            model.addAttribute("msg", "账号已存在，请重新输入账号");
            model.addAttribute("user", null);
            //由于是服务器端转发，因此共享同一个request，request中的user参数也跟着一起转发，如果不设置为null的话，跳转后的页面也能获取到同一个user参数
            return "fore/register";
        }
    }

    @RequestMapping("login")
    public String login(@RequestParam("name")String name, @RequestParam("password")String password, Model model, HttpSession session){
        User user = userService.get(name, password);
        if(null == user){
            model.addAttribute("msg", "用户名或密码错误！");
            return "fore/login";
        }
        session.setAttribute("user", user);
        return "redirect:forehome";
    }

    @RequestMapping("modalLogin")
    @ResponseBody
    public String modalLogin(@RequestParam("name")String name, @RequestParam("password")String password, Model model, HttpSession session){
        User user = userService.get(name, password);
        if(null == user){
            model.addAttribute("msg", "用户名或密码错误！");
            return "not success";
        }
        session.setAttribute("user", user);
        return "success";
    }

    @RequestMapping("foreLoginCheck")
    @ResponseBody
    public String loginCheck(HttpSession session){
        if(null == session.getAttribute("user")){
            return "no login";
        }else {
            return "success";
        }
    }

    @RequestMapping("forelogout")
    public String logout(HttpSession session){
        session.removeAttribute("user");
        return "redirect:loginPage";
    }

    @RequestMapping("foreproduct")
    public String product(@RequestParam("pid")int pid, Model model){
        Product product = productService.get(pid);

        List<ProductImage> productSingleImages = productImageService.list(pid, ProductImageService.type_single);
        List<ProductImage> productDetailImages = productImageService.list(pid, ProductImageService.type_detail);
        product.setProductSingleImages(productSingleImages);
        product.setProductDetailImages(productDetailImages);

        List<PropertyValue> propertyValues = propertyValueService.list(pid);

        List<Review> reviews = reviewService.list(pid);

        productService.setSaleAndReviewNumber(product);

        model.addAttribute("product", product);
        model.addAttribute("pvs", propertyValues);
        model.addAttribute("reviews", reviews);

        return "fore/product";
    }

    @RequestMapping("foreCategory")
    public String category(@RequestParam("cid")int cid, Model model, String sort){
        Category category = categoryService.get(cid);
        List<Product> products = productService.list(cid);
        productService.setFirstProductImage(products);
        productService.setSaleAndReviewNumber(products);
        if(null != sort){
            switch (sort){
                case "all":
                    Collections.sort(products, new ProductAllComparator());
                    break;
                case "date":
                    Collections.sort(products, new ProductDateComparator());
                    break;
                case "price":
                    Collections.sort(products, new ProductPriceComparator());
                    System.out.println(products.get(0).getPromotePrice());
                    break;
                case "review":
                    Collections.sort(products, new ProductReviewComparator());
                    break;
                case "sale":
                    Collections.sort(products, new ProductSaleCountComparator());
                    break;
            }
        }
        model.addAttribute("category", category);
        model.addAttribute("products", products);
        return "fore/category";
    }

    @RequestMapping("foresearch")
    public String search(@RequestParam("keyWord")String keyWord, Model model){
        List<Product> products = productService.searchByName(keyWord);
        model.addAttribute("keyWord", keyWord);
        if(products.isEmpty()){
            model.addAttribute("warning","没有搜索到相关商品！");
            return "fore/foresearch";
        }
        model.addAttribute("products", products);
        return "fore/foresearch";
    }

















}
