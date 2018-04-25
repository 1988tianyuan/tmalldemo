package com.liugeng.tmalldemo.service.CategoryServiceImpl;

import com.liugeng.tmalldemo.mapper.OrderMapper;
import com.liugeng.tmalldemo.mapper.UserMapper;
import com.liugeng.tmalldemo.pojo.Order;
import com.liugeng.tmalldemo.pojo.OrderExample;
import com.liugeng.tmalldemo.pojo.OrderItem;
import com.liugeng.tmalldemo.service.OrderItemService;
import com.liugeng.tmalldemo.service.OrderService;
import com.liugeng.tmalldemo.service.UserService;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService{
    @Autowired
    OrderMapper orderMapper;
    @Autowired
    UserService userService;
    @Autowired
    OrderItemService orderItemService;

    @Override
    public int add(Order order) {
        return orderMapper.insertSelective(order);
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

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackForClassName = "Exception")
    public float addWithOrderItems(Order order, List<OrderItem> orderItems) {
        float total = 0;
        add(order);
        int oid = order.getId();
        for(OrderItem orderItem:orderItems){
            orderItem.setOid(oid);
            orderItemService.update(orderItem);
            total += orderItem.getNumber()*orderItem.getProduct().getPromotePrice();
        }
        return total;
    }

    @Override
    public List<Order> listWithUid(int uid, String neededStatus) {
        OrderExample orderExample = new OrderExample();
        orderExample.createCriteria().andUidEqualTo(uid).andStatusNotEqualTo(neededStatus);
        List<Order> ordersWithUid = orderMapper.selectByExample(orderExample);
        return ordersWithUid;
    }

    @Override
    public float calTotalCost(Order order) {
        float total = 0;
        List<OrderItem> orderItems = orderItemService.listByOid(order.getId());
        for(OrderItem orderItem:orderItems){
            total += orderItem.getNumber()*orderItem.getProduct().getPromotePrice();
        }
        order.setTotalCost(total);
        return total;
    }

    @Override
    public void calAllTotalCost(List<Order> orders) {
        for(Order order:orders){
            calTotalCost(order);
        }
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
