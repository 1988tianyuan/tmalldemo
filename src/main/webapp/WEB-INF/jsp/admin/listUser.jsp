<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/27
  Time: 22:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
<html>
<head>
    <title>用户管理</title>
    <script>

    </script>
</head>
<body>
<div class="workingArea">
    <h1 class="label label-info">用户管理</h1><br><br>
    <%--信息标签--%>

    <div class="listDataTableDiv">
        <table class="table table-striped table-bordered table-hover table-condensed">
        <%--不同的表格风格，hover为表格添加鼠标悬停效果，condensed使表格更加紧凑--%>
            <thead>
                <tr class="success">
                <%--绿色风格（执行成功风格）的tr行    --%>
                    <th>ID</th>
                    <th>用户名称</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach items="${users}" var="u">
                    <tr>
                        <td>${u.id}</td>
                        <td>${u.name}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="pageDiv">
        <%@include file="../include/admin/adminPage.jsp"%>
    </div>



</div>

<%@include file="../include/admin/adminFooter.jsp"%>
</body>
</html>
