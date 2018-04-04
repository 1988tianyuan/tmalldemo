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
    <title>属性管理-${category.name}</title>
    <script>
        $(function () {
            $("#addForm").submit(function () {
                if(!checkEmpty("name","属性名字")){
                    return false;
                }
                return true;
            })
        })

        $(function () {
            $("a").click(function () {
                var deleteLink = $(this).attr("deleteLink");
                if("true"==deleteLink){
                    if(confirm("确认删除该属性？")){
                     return true;
                    }
                    return false;
                }
            });
        })
    </script>
</head>
<body>
<div class="workingArea">
    <h1 class="label label-info">属性管理</h1><br><br>
    <%--信息标签--%>

    <%--bootstrap的面包屑导航控件--%>
    <ol class="breadcrumb">
        <li><a href="admin_category_list">所有分类</a></li>
        <li><a href="admin_property_list?cid=${category.id}">${category.name}</a> </li>
        <li class="active">属性管理</li>
    </ol>

    <div class="listDataTableDiv">
        <table class="table table-striped table-bordered table-hover table-condensed">
        <%--不同的表格风格，hover为表格添加鼠标悬停效果，condensed使表格更加紧凑--%>
            <thead>
                <tr class="success">
                <%--绿色风格（执行成功风格）的tr行    --%>
                    <th>ID</th>
                    <th>属性名称</th>
                    <th>编辑</th>
                    <th>删除</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach items="${properties}" var="p">
                <%--从后端获取category集合，并分别生成表格元素--%>
                    <tr>
                        <td>${p.id}</td>
                        <td>${p.name}</td>
                        <td><a href="admin_property_edit?id=${p.id}"><span class="glyphicon glyphicon-edit"></span></a></td>
                        <td><a deleteLink="true" href="admin_property_delete?id=${p.id}&cid=${category.id}"><span class="   glyphicon glyphicon-trash"></span></a></td>
                        <%--deleteLink是在超链接标签中自定义的属性，目的是对删除按钮进行标记，当点击时会进行弹窗确认--%>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="pageDiv">
        <%@include file="../include/admin/adminPage.jsp"%>
    </div>

    <div class="panel panel-warning addDiv">
    <%--bootstrap的panel面板容器，以及容器的风格；addDiv是对该容器的大小进行设置--%>
        <div class="panel-heading">新增属性</div>
        <%--面板标题--%>
        <div class="panel-body">
        <%--面板体--%>
            <form method="post" id="addForm" action="admin_property_add">
                <table class="addTable">
                    <tr>
                        <td>属性名称</td>
                        <td>
                            <input id="name" name="name" type="text" class="form-control" placeholder="请输入新增属性的名称">
                            <input id="cid" name="cid" value="${category.id}" type="hidden">
                        </td>
                        <%--设置了 class="form-control"的表单元素将默认为width="100%"--%>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <button type="submit" class="btn btn-success">提交</button>
                            <%--设置button的bootstrap样式--%>
                        </td>
                    </tr>
                </table>
            </form>

        </div>

    </div>


</div>

<%@include file="../include/admin/adminFooter.jsp"%>
</body>
</html>
