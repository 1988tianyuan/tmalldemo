package com.liugeng.tmalldemo.controller;

import com.liugeng.tmalldemo.comparator.*;
import com.liugeng.tmalldemo.pojo.*;
import com.liugeng.tmalldemo.service.*;
import org.apache.commons.lang.math.RandomUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
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
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    OrderService orderService;

    @RequestMapping("forehome")
    public String listCategory(Model model, HttpSession session){
        List<Category> categories = categoryService.list();
        productService.fill(categories);
        productService.fillByRow(categories);
        model.addAttribute("categories", categories);
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
        session.removeAttribute("oiCount");
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

    @RequestMapping("immeBuy")
    public String immeBuy(OrderItem orderItem, HttpSession session){
        int oiid;
        User user = (User) session.getAttribute("user");
        int uid = user.getId();
        orderItem.setUid(uid);
        OrderItem orderItemExist = orderItemService.listByUidAndPidWithoutOid(uid, orderItem.getPid());
        if(null != orderItemExist){
            int number = orderItemExist.getNumber();
            number += orderItem.getNumber();
            orderItemExist.setNumber(number);
            orderItemService.update(orderItemExist);
            oiid = orderItemExist.getId();
        }else {
            orderItemService.add(orderItem);
            oiid = orderItem.getId();
        }
        return "redirect:confirmBuy?oiid="+oiid;
    }

    /**
     * 通过购物车结算和确认购买，二合一，都是查看当前未绑定order的orderItem
     * 前台将oiid通过GET方式传过来
     * */
    @RequestMapping("confirmBuy")
    public String comfirmBuy(String[]oiid, Model model, HttpSession session){
        List<OrderItem> orderItems = new ArrayList<>();
        float total = 0;
        for(String strOiid : oiid){
            int intOiid = Integer.parseInt(strOiid);
            OrderItem orderItem = orderItemService.get(intOiid);
            orderItems.add(orderItem);
            total += orderItem.getProduct().getPromotePrice() * orderItem.getNumber();
        }
        session.setAttribute("ois", orderItems);
        model.addAttribute("total", total);
        return "fore/confirmBuy";
    }

    /**
     * 查看购物车，查找当前用户id下未绑定order的orderItem
     * */
    @RequestMapping("forecart")
    public String cart(Model model, HttpSession session){
        User user = (User) session.getAttribute("user");
        List<OrderItem> orderItems = orderItemService.listWithOutOid(user.getId());
        model.addAttribute("ois", orderItems);
        return "fore/cart";
    }

    @RequestMapping("deleteOi")
    public String deleteOrderItem(@RequestParam("oiid")int oiid){
        orderItemService.delete(oiid);
        return "redirect:cart";
    }

    @RequestMapping("changeoinumber")
    @ResponseBody
    public String changeOiNumber(@RequestParam("oiid")int oiid, @RequestParam("num")int number ){
        OrderItem orderItem = orderItemService.get(oiid);
        orderItem.setNumber(number);
        orderItemService.update(orderItem);
        return "success";
    }

    /**
    * 接受前台传过来的Order信息，新建Order，并将未绑定oid的orderItem绑定上oid
     * 完成后将总价和oid存入session，便于顾客付款
    * */
    @RequestMapping("forecreateOrder")
    @ResponseBody
    public String createOrder(HttpSession session, Order order){
        List<OrderItem> orderItems = (List<OrderItem>) session.getAttribute("ois");
        User user = (User) session.getAttribute("user");
        String orderCode = new SimpleDateFormat("yyyyMMddhhmmss").format(new Date()) + RandomUtils.nextInt(10000);
        Date createDate = new Date();

        order.setOrderCode(orderCode);
        order.setUid(user.getId());
        order.setStatus(OrderService.waitPay);
        order.setCreateDate(createDate);

        float totalCost = orderService.addWithOrderItems(order, orderItems);

        session.setAttribute("totalCost", totalCost);
        session.setAttribute("order", order);
        return "aliPay";
    }











}
