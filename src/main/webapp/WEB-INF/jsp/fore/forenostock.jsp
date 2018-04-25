<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/24
  Time: 22:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>已无库存</title>
</head>
<body>
<%@include file="../include/header.jsp"%>
<%@include file="../include/top.jsp"%>
<div class="noStockDiv">
    ${msg}
</div>
<%@include file="../include/footer.jsp"%>
</body>
</html>
