package com.liugeng.tmalldemo.service.CategoryServiceImpl;

import com.liugeng.tmalldemo.mapper.OrderItemMapper;
import com.liugeng.tmalldemo.pojo.Order;
import com.liugeng.tmalldemo.pojo.OrderItem;
import com.liugeng.tmalldemo.pojo.OrderItemExample;
import com.liugeng.tmalldemo.service.OrderItemService;
import com.liugeng.tmalldemo.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderItemServiceImpl implements OrderItemService{
    @Autowired
    OrderItemMapper orderItemMapper;
    @Autowired
    ProductService productService;

    @Override
    public void add(OrderItem orderItem) {
        orderItemMapper.insertSelective(orderItem);
    }

    @Override
    public void delete(int oiid) {
        orderItemMapper.deleteByPrimaryKey(oiid);
    }

    @Override
    public void update(OrderItem orderItem) {
        orderItemMapper.updateByPrimaryKeySelective(orderItem);
    }

    @Override
    public OrderItem get(int oiid) {
        OrderItem orderItem = orderItemMapper.selectByPrimaryKey(oiid);
        setProduct(orderItem);
        return orderItem;
    }

    @Override
    public List<OrderItem> listByOid(int oid) {
        OrderItemExample orderItemExample = new OrderItemExample();
        orderItemExample.createCriteria().andOidEqualTo(oid);
        orderItemExample.setOrderByClause("id ASC");
        List<OrderItem> orderItems = orderItemMapper.selectByExample(orderItemExample);
        setProduct(orderItems);
        return orderItems;
    }

    @Override
    public OrderItem listByUidAndPid(int uid, int pid){
        OrderItemExample orderItemExample = new OrderItemExample();
        orderItemExample.createCriteria().andUidEqualTo(uid).andPidEqualTo(pid);
        List<OrderItem> orderItems = orderItemMapper.selectByExample(orderItemExample);
        if(!orderItems.isEmpty()){
            OrderItem orderItem = orderItems.get(0);
            setProduct(orderItem);
            return orderItem;
        }
        return null;
    }

    @Override
    public void fill(List<Order> orders) {
        for(Order order:orders){
            fill(order);
        }
    }

    /**
    * 由于mybatis自动生成的mapper没有一对多查询，所以在这里手动实现一个order查询多个orderItem
    */
    @Override
    public void fill(Order order) {
        int totalNumber = 0;
        float totalCost = 0;
        List<OrderItem> orderItems = listByOid(order.getId());
        for(OrderItem orderItem:orderItems){
            totalNumber += orderItem.getNumber();
            totalCost += orderItem.getNumber() * orderItem.getProduct().getPromotePrice();
        }
        order.setOrderItems(orderItems);
        order.setTotalCost(totalCost);
        order.setTotalNumber(totalNumber);
    }

    @Override
    public int getSaleCount(int pid) {
        OrderItemExample orderItemExample = new OrderItemExample();
        orderItemExample.createCriteria().andPidEqualTo(pid);
        List<OrderItem> orderItems = orderItemMapper.selectByExample(orderItemExample);
        int saleCount = 0;
        for(OrderItem orderItem:orderItems){
            saleCount += orderItem.getNumber();
        }
        return saleCount;
    }

    void setProduct(OrderItem orderItem){
        orderItem.setProduct(productService.get(orderItem.getPid()));
    }

    void setProduct(List<OrderItem> orderItems){
        for(OrderItem orderItem:orderItems){
            setProduct(orderItem);
        }
    }

}
