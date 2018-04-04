package com.liugeng.tmalldemo.service;

import com.liugeng.tmalldemo.pojo.Order;

import java.util.List;

public interface OrderService {
    String waitPay = "waitPay";
    String waitDelivery = "waitDelivery";
    String waitConfirm = "waitConfirm";
    String waitReview = "waitReview";
    String finish = "finish";
    String delete = "delete";
    void add(Order order);
    void delete(int oid);
    void update(Order order);
    Order get(int oid);
    List<Order> list();
}
