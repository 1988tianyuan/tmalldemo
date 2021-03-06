package com.liugeng.tmalldemo.service;

import com.liugeng.tmalldemo.pojo.Order;
import com.liugeng.tmalldemo.pojo.OrderItem;

import java.util.List;

public interface OrderService {
    String waitPay = "waitPay";
    String waitDelivery = "waitDelivery";
    String waitConfirm = "waitConfirm";
    String waitReview = "waitReview";
    String finish = "finish";
    String delete = "delete";
    int add(Order order);
    void delete(int oid);
    void update(Order order);
    Order get(int oid);
    List<Order> list();
    List<Order> listWithUid(int uid, String neededStatus);
    float addWithOrderItems(Order order, List<OrderItem>orderItems);
    float calTotalCost(Order order);
    void calAllTotalCost(List<Order> orders);
}
