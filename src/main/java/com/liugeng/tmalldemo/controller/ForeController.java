package com.liugeng.tmalldemo.controller;

import com.liugeng.tmalldemo.comparator.*;
import com.liugeng.tmalldemo.pojo.*;
import com.liugeng.tmalldemo.service.*;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.apache.commons.lang.math.RandomUtils;
import org.aspectj.weaver.ast.Or;
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

    /**
     * 访问主页，无需登陆，主要功能：
     * 1.查询所有的category
     * 2.将每个category对应的product对象填充到该category中
     * 3.将每个category对应的product对象以8个为一行的形式填充到category中，便于首页进行product的分行显示
     * */
    @RequestMapping("forehome")
    public String listCategory(Model model){
        List<Category> categories = categoryService.list();
        productService.fill(categories);
        productService.fillByRow(categories);
        model.addAttribute("categories", categories);
        return "fore/home";
    }

    /**
     * 进行注册：
     * 1.判断账号是否存在，若不存在则新增该用户，并客户端重定向到“注册成功”页面
     * 2.若账号存在则跳转回注册界面，返回报错信息
     * */
    @RequestMapping("registerConfirm")
    public String registerConfirm(User user, Model model){
        Boolean isNotExist = userService.nameCheck(user.getName());
        if(isNotExist){
            userService.add(user);
            return "redirect:registerSuccess";
        }else {
            model.addAttribute("msg", "账号已存在，请重新输入账号");
            model.addAttribute("user", null);
            //由于是服务器端转发，因此共享同一个request，request中的user参数也跟着一起转发，如果不设置为null的话，跳转后的页面能获取到这个错误的user参数
            return "fore/register";
        }
    }

    /**
     * 登录操作，登录成功（数据库存在该user）则跳转到首页，并将user信息存入session；
     * 登录不成功则返回报错信息，跳转回登录界面
     * */
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

    /**
     * 专门用于模态窗口登录，配合前台的ajax操作，返回文本信息
     * */
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

    /**
     * 配合前台product页面进行登录验证，前台若检查为未登录则弹出模态登录窗口
     * */
    @RequestMapping("foreLoginCheck")
    @ResponseBody
    public String loginCheck(HttpSession session){
        if(null == session.getAttribute("user")){
            return "no login";
        }else {
            return "success";
        }
    }

    /**
     * 退出登录状态，将user信息和购物车总数信息从session中删除
     * */
    @RequestMapping("forelogout")
    public String logout(HttpSession session){
        session.removeAttribute("user");
        session.removeAttribute("oiCount");
        return "redirect:loginPage";
    }

    /**
     * 前往product展示页面，将每个product对应的image、评价信息和销量填充到product对象中
     * 填充完成后将product对象、对应的属性值、评价等信息转发到product页面
     * */
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

    /**
     * 展示单个category所有的产品列表
     * 包含一个排序操作，前台传来排序需求，在这里将product进行排序，完成后再转发到category页面
     * */
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

    /**
     * 搜索操作，前台传来搜索指令，进行模糊查找，若没查到相关product则返回报错信息
     * */
    @RequestMapping("foresearch")
    public String search(@RequestParam("keyWord")String keyWord, Model model){
        List<Product> products = productService.searchByName(keyWord);
        model.addAttribute("keyWord", keyWord);
        if(products.isEmpty()){
            model.addAttribute("warning","没有搜索到相关商品！");
        }
        model.addAttribute("products", products);
        return "fore/foresearch";
    }

    /**
     * 这里涉及到两种情况：
     * 1.购物车中已经有对应orderItem：更新orderItem的number
     * 2.购物车中尚无对应orderItem：新增相关的orderItem
     * 最后获取更新（新增）的orderItem的id，并客户端重定向到“确认购买”页面（用ajax方式加入购物车时并不进行跳转）
     * */
    @RequestMapping("foreImmeBuy")
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
        return "redirect:foreConfirmBuy?oiid="+oiid;
    }

    /**
     * 前台有两个途径调用该方法，1.通过购物车确认购买 2.产品页面确认购买
     * 两个途径二合一，都是查看当前未绑定order的orderItem
     * 前台将oiid通过GET方式传过来，将这部分orderItem存入session便于后续生成及绑定order时使用
     * */
    @RequestMapping("foreConfirmBuy")
    public String confirmBuy(String[]oiid, Model model, HttpSession session){
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

    /**
     * 删除购物车中的orderItem
     * */
    @RequestMapping("deleteOi")
    public String deleteOrderItem(@RequestParam("oiid")int oiid){
        orderItemService.delete(oiid);
        return "redirect:forecart";
    }

    /**
     * 配合前台通过ajax方式改变orderItem的number，即时将改变后的数目更新到数据库中
     * */
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
    * 完成后将order信息传入付款页面
     *
     * 在建立订单前需要进行库存检查，若该商品无库存，则跳转到报错页面
     * 若有库存则在之前的product库存上减去所购买的数量
    * */
    @RequestMapping("forecreateOrder")
    public String createOrder(HttpSession session, Model model, Order order){
        List<OrderItem> orderItems = (List<OrderItem>) session.getAttribute("ois");

        //进行库存检查，同时更新库存
        try{
            if(!orderItemService.stockCheckAndUpdate(orderItems)){
                model.addAttribute("msg", "该商品库存已无库存，请选购其他商品！");
                return "fore/forenostock";
            }
            //更新完库存后开始创建订单，更新数据库order表，并跳转到付款页面
            User user = (User) session.getAttribute("user");
            String orderCode = new SimpleDateFormat("yyyyMMddhhmmss").format(new Date()) + RandomUtils.nextInt(10000);
            Date createDate = new Date();

            order.setOrderCode(orderCode);
            order.setUid(user.getId());
            order.setStatus(OrderService.waitPay);
            order.setCreateDate(createDate);
            float totalCost = orderService.addWithOrderItems(order, orderItems);
            order.setTotalCost(totalCost);

            model.addAttribute("orderWithoutPay", order);
            return "fore/forealipay";
        }catch (Exception e){
            e.printStackTrace();
            model.addAttribute("msg", "购买过程出现异常，请重新选购商品！");
            return "fore/forenostock";
        }
    }

    /**
     * 在订单查看页面中有一部分订单是已经创建完成但未付款的，点击“付款”获取oid，跳转到立即付款页面完成付款
     * */
    @RequestMapping("foreConfirmPay")
    public String confirmPay(int oid, Model model){
        Order order = orderService.get(oid);
        float totalCost = orderService.calTotalCost(order);
        order.setTotalCost(totalCost);
        model.addAttribute("orderWithoutPay", order);
        return "fore/forealipay";
    }

    /**
     * 用于进行付款操作及订单状态的变更，完成后跳转到付款成功页面
     * */
    @RequestMapping("forepay")
    public String payCompleted(Model model, int oid){
        Order order = orderService.get(oid);

        Date payDate = new Date();
        order.setPayDate(payDate);
        order.setStatus(OrderService.waitDelivery);
        orderService.update(order);
        orderService.calTotalCost(order);

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM月dd日");
        Date predictReceiveDate = new Date(payDate.getTime() + 7*24*3600*1000);

        model.addAttribute("prDate", simpleDateFormat.format(predictReceiveDate));
        model.addAttribute("address", order.getAddress());
        model.addAttribute("totalCost", order.getTotalCost());

        return "fore/forepaysuccess";
    }

    /**
     * 订单查看页
     * 筛选该用户下状态不为delete的order
     * 将每个order对象对应的orderItem填充到order中用于展示，其中每个orderItem已经完成product对象的填充
     * */
    @RequestMapping("forebought")
    public String orderCheck(HttpSession session, Model model){
        User user = (User)session.getAttribute("user");
        List<Order> orders = orderService.listWithUid(user.getId(),OrderService.delete);
        orderItemService.fill(orders);
        model.addAttribute("orders", orders);
        return "fore/foreorder";
    }

    /**
     * 接收需要删除的order的id，将status更新为delete，然后跳转至订单页面
     * */
    @RequestMapping("foreDeleteOrder")
    public String deleteOrder(int oid){
        Order order = orderService.get(oid);
        order.setStatus(OrderService.delete);
        orderService.update(order);
        return "redirect:forebought";
    }

    /**
     * 获取订单信息，跳转到确认收货页面
     * */
    @RequestMapping("foreConfirmReceivePage")
    public String confirmReceivePage(int oid, Model model){
        Order order = orderService.get(oid);
        orderItemService.fill(order);
        model.addAttribute("order", order);
        return "fore/foreconfirmreceive";
    }

    /**
     * 进行收货确认，将order状态切换到waitReview状态
     */
    @RequestMapping("foreConfirmReceive")
    public String confirmReceive(int oid){
        Order order = orderService.get(oid);
        order.setConfirmDate(new Date());
        order.setStatus(OrderService.waitReview);
        orderService.update(order);
        return "fore/foreconfirmfinish";
    }

    /**
     *获取订单、订单项和产品评价等信息，跳转到评价页面
     * */
    @RequestMapping("foreReview")
    public String toReview(int oid, Model model){
        Order order = orderService.get(oid);
        List<OrderItem> orderItems = orderItemService.listByOid(oid);
        Product product = orderItems.get(0).getProduct();//获取订单中第一个订单项对应的product
        productService.setSaleAndReviewNumber(product);//获取该product的评价数目和销量
        List<Review> reviews = reviewService.list(product.getId());//获取该product的评价目录
        model.addAttribute("order", order);
        model.addAttribute("reviews", reviews);
        model.addAttribute("product", product);
        return "fore/forereview";
    }

    /**
     * 评价页面完成评价后，将order更新为finish状态，数据库中新增评价，并跳转回评价页面并显示评价结果
     *
     * */
    @RequestMapping("foreCompleteReview")
    public String completeReview(HttpSession session, String content, int oid, int pid){
        Product product = productService.get(pid);
        User user = (User)session.getAttribute("user");
        Order order = orderService.get(oid);

        order.setStatus(OrderService.finish);
        orderService.update(order);

        //新建一个review
        Review review = new Review();
        review.setUser(user);
        review.setContent(content);
        review.setCreateDate(new Date());
        review.setUid(user.getId());
        review.setPid(product.getId());
        reviewService.add(review);

        return "redirect:foreReview?oid=" + oid;
    }







}
