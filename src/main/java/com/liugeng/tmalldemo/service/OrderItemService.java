package com.liugeng.tmalldemo.service;

import com.liugeng.tmalldemo.pojo.Order;
import com.liugeng.tmalldemo.pojo.OrderItem;

import java.util.List;

public interface OrderItemService {
    void add(OrderItem orderItem);
    void delete(int oiid);
    void update(OrderItem orderItem);
    OrderItem get(int oiid);
    List<OrderItem> listWithOutOid(int uid);
    List<OrderItem> listByOid(int oid);
    OrderItem listByUidAndPidWithoutOid(int uid, int pid);
    void fill(List<Order> orders);
    void fill(Order order);
    int getSaleCount(int pid);
    boolean stockCheckAndUpdate(List<OrderItem> orderItems);
}
