package com.liugeng.tmalldemo.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.liugeng.tmalldemo.pojo.Order;
import com.liugeng.tmalldemo.service.OrderItemService;
import com.liugeng.tmalldemo.service.OrderService;
import com.liugeng.tmalldemo.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("")
public class OrderController {
    @Autowired
    OrderService orderService;
    @Autowired
    OrderItemService orderItemService;

    @RequestMapping("admin_order_list")
    public String listOrder(Page page, Model model){
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Order> orders = orderService.list();
        int total = (int) new PageInfo<>(orders).getTotal();
        page.setTotal(total);

        orderItemService.fill(orders);

        model.addAttribute("orders", orders);
        model.addAttribute("page", page);

        return "admin/listOrder";
    }

    @RequestMapping("admin_order_delivery")
    @ResponseBody
    public String delivery(@RequestParam("oid")int oid){
        Order order = orderService.get(oid);
        order.setStatus(OrderService.waitConfirm);
        order.setDeliveryDate(new Date( ));
        orderService.update(order);
        return "success";
    }

}
