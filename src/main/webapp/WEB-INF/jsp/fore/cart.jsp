<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/13
  Time: 18:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>查看购物车</title>
</head>
<body>
<%@include file="../include/header.jsp"%>
<%@include file="../include/top.jsp"%>
<%@include file="../include/simpleSearch.jsp"%>

<div class="cartDiv">
    <%@include file="../include/cart/cartPage.jsp"%>
</div>

<%@include file="../include/footer.jsp"%>
</body>
</html>
