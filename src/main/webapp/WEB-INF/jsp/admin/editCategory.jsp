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
    <title>分类管理</title>
    <script>
        $(function () {
            $("#editForm").submit(function () {
                if(!checkEmpty("name","分类名字")){
                    return false;
                }
                if(!checkEmpty("categoryPic", "分类图片")){
                    return false;
                }
                return true;
            })
        })
    </script>
</head>
<body>

<div class="panel panel-warning addDiv">
    <%--bootstrap的panel面板容器，以及容器的风格；addDiv是对该容器的大小进行设置--%>
    <div class="panel-heading">修改分类</div>
    <%--面板标题--%>
    <div class="panel-body">
        <%--面板体--%>
        <form method="post" id="editForm" action="admin_category_update" enctype="multipart/form-data">
            <table class="addTable">
                <tr>
                    <td>分类名称</td>
                    <td>
                        <input id="name" name="name" type="text" class="form-control" value="${category.name}">
                        <input id="id" name="id" value="${category.id}" type="hidden">
                    </td>
                    <%--设置了 class="form-control"的表单元素将默认为width="100%"--%>
                </tr>
                <tr>
                    <td>分类图片</td>
                    <td>
                        <input id="categoryPic" accept="image/*" type="file" name="image">
                    </td>
                </tr>
                <tr class="submitTR">
                    <td colspan="2" align="center">
                        <a class="btn btn-info" href="admin_category_list">返回</a>
                        <button type="submit" class="btn btn-success">提交修改</button>
                        <%--设置button的bootstrap样式--%>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>



<%@include file="../include/admin/adminFooter.jsp"%>
</body>
</html>
