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
    <title>产品属性修改</title>
    <script>
        $(function () {
            $("input.pvValue").keyup(function () {

                var page = "admin_propertyValue_update";
                var pvid = $(this).attr("pvid");
                var value = $(this).val();
                var parentSpan = $(this).parent("span");
                parentSpan.css("border", "1px solid yellow");
                $.ajax(
                    {
                        type:"post", url: page, data: {"id": pvid, "value": value},
                        //这里用GET提交的话会乱码，必须用POST
                        success:function (result) {
                            if("success" === result){
                                parentSpan.css("border", "1px solid green");
                            }else{
                                parentSpan.css("border", "1px solid red");
                            }
                        }
                    }
                )
            })
        })
    </script>
</head>
<body>
<%--bootstrap的面包屑导航控件--%>
<div class="workingArea">
<ol class="breadcrumb">
    <li><a href="admin_category_list">所有分类</a></li>
    <li><a href="admin_product_list?cid=${product.cid}">${product.category.name}</a> </li>
    <li>${product.name}</li>
    <li class="active">产品属性修改</li>
</ol>

<c:forEach items="${propertyValueList}" var="pv">
    <div class="eachPV">
        <span class="pvName">${pv.property.name}:</span>
        <%--class="pvName"和"pvValue"中，设置了display:inline-block，将该span设置为内联-块级形式，便于并排布局--%>
        <span class="pvValue"><input class="pvValue" type="text" pvid="${pv.id}" value="${pv.value}"></span>
    </div>

</c:forEach>
<div style="clear: both"></div>

</div>



<%@include file="../include/admin/adminFooter.jsp"%>
</body>
</html>
