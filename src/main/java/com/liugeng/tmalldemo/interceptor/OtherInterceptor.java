package com.liugeng.tmalldemo.interceptor;

import com.liugeng.tmalldemo.pojo.Category;
import com.liugeng.tmalldemo.pojo.OrderItem;
import com.liugeng.tmalldemo.pojo.User;
import com.liugeng.tmalldemo.service.CategoryService;
import com.liugeng.tmalldemo.service.OrderItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class OtherInterceptor extends HandlerInterceptorAdapter {
    @Autowired
    CategoryService categoryService;
    @Autowired
    OrderItemService orderItemService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HttpSession session = request.getSession();

        //对每个页面传入categories，让搜索栏下的分类能够显示出来
        List<Category> categories = categoryService.list();
        session.setAttribute("cs", categories);

        //若已登录，将每个user对应的购物车总商品数量传入session
        int oiNumber = 0;
        User user = (User) session.getAttribute("user");
        if(null != user){
            List<OrderItem> orderItems = orderItemService.listWithOutOid(user.getId());
            for(OrderItem orderItem:orderItems){
                oiNumber += orderItem.getNumber();
            }
        }
        session.setAttribute("oiCount", oiNumber);
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
