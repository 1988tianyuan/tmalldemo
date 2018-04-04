package com.liugeng.tmalldemo.service.CategoryServiceImpl;

import com.liugeng.tmalldemo.mapper.OrderMapper;
import com.liugeng.tmalldemo.mapper.UserMapper;
import com.liugeng.tmalldemo.pojo.Order;
import com.liugeng.tmalldemo.pojo.OrderExample;
import com.liugeng.tmalldemo.service.OrderService;
import com.liugeng.tmalldemo.service.UserService;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService{
    @Autowired
    OrderMapper orderMapper;
    @Autowired
    UserService userService;

    @Override
    public void add(Order order) {
        orderMapper.insertSelective(order);
    }

    @Override
    public void delete(int oid) {
        orderMapper.deleteByPrimaryKey(oid);
    }

    @Override
    public void update(Order order) {
        orderMapper.updateByPrimaryKeySelective(order);
    }

    @Override
    public Order get(int oid) {
        Order order = orderMapper.selectByPrimaryKey(oid);
        setUser(order);
        return order;
    }

    @Override
    public List<Order> list() {
        OrderExample orderExample = new OrderExample();
        orderExample.setOrderByClause("id ASC");
        List<Order> orders = orderMapper.selectByExample(orderExample);
        setUser(orders);
        return orders;
    }

    void setUser (List<Order> orders){
        for(Order order:orders){
            setUser(order);
        }
    }

    void setUser(Order order){
        order.setUser(userService.get(order.getUid()));
    }
}
