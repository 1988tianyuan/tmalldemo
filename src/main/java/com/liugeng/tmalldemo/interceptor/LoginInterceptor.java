package com.liugeng.tmalldemo.interceptor;

import com.liugeng.tmalldemo.pojo.User;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;

public class LoginInterceptor extends HandlerInterceptorAdapter{
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        String contextPath = request.getServletContext().getContextPath();
        String[] noNeedToAuthPage = new String[]{
            "forehome", "registerConfirm", "login", "modalLogin", "foreLoginCheck", "forelogout", "foreproduct", "foreCategory", "foresearch", "accessRegisterPage", "registerSuccess", "loginPage"
        };
        String uri = request.getRequestURI();
        uri = StringUtils.remove(uri, contextPath+"/");
        if(!Arrays.asList(noNeedToAuthPage).contains(uri)){
            User user = (User) session.getAttribute("user");
            if(null == user){
                response.sendRedirect("loginPage");
                return false;
            }
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
