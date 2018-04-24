<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/4
  Time: 20:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<nav class="top">

    <div id="outOfTop" style="width:1180px; margin: auto">
    <a href="forehome">
        <span style="color: #C40000; margin-right: 0px" class="glyphicon glyphicon-home redColor"></span>
        天猫首页
    </a>
    <span>喵，欢迎来到天猫</span>
    <c:if test="${!empty user}">
        <a href="#nowhere">${user.name}</a>
        <a href="forelogout">退出</a>
    </c:if>
    <c:if test="${empty user}">
        <a href="loginPage">请登录</a>
        <a href="accessRegisterPage">免费注册</a>
    </c:if>

    <span class="pull-right"style="float: right">
        <a href="forebought">我的订单</a>
        <a href="forecart">
            <span style="color: #C40000; margin: 0px" class="glyphicon glyphicon-shopping-cart redColor"></span>
            <c:if test="${empty user}">购物车<strong>0</strong>件</c:if>
            <c:if test="${!empty user}">购物车<strong>${oiCount}</strong>件</c:if>
        </a>
    </span>
    </div>

</nav>
