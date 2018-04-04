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
    <title>订单管理</title>
    <script>
        $(function () {
            $("button.checkDetail").click(function () {
                var oid = $(this).attr("oid");
                $("tr.orderItemsDetail[oid=" +oid+ "]").toggle();
            })
        })

        $(function () {
            $("button.delivery").click(function () {
                var oid = $(this).attr("oid");
                var page = "admin_order_delivery";
                $.ajax(
                    {
                        type:"post", url: page, data: {"oid": oid},
                        success:function (result) {
                            if("success" === result){
                                alert("发货成功！");
                                location.href = "admin_order_list";
                            }
                        }
                    }
                )
            })
        })
    </script>
</head>
<body>
<div class="workingArea">
    <h1 class="label label-info">订单管理</h1><br><br>
    <%--信息标签--%>

    <div class="listDataTableDiv">
        <table class="table table-striped table-bordered table-hover table-condensed">
        <%--不同的表格风格，hover为表格添加鼠标悬停效果，condensed使表格更加紧凑--%>
            <thead>
                <tr class="success">
                <%--绿色风格（执行成功风格）的tr行    --%>
                    <th>ID</th>
                    <th>动态</th>
                    <th>金额</th>
                    <th>商品数量</th>
                    <th>买家名称</th>
                    <th>创建时间</th>
                    <th>支付时间</th>
                    <th>发货时间</th>
                    <th>确认收货时间</th>
                    <th>操作</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach items="${orders}" var="o">
                <%--从后端获取category集合，并分别生成表格元素--%>
                    <tr>
                        <td>${o.id}</td>
                        <td>${o.showStatus}</td>
                        <td>${o.totalCost}</td>
                        <td>${o.totalNumber}</td>
                        <td>${o.user.name}</td>
                        <td><fmt:formatDate value="${o.createDate}" pattern="yyyy-mm-dd hh:mm:ss"/></td>
                        <td><fmt:formatDate value="${o.payDate}" pattern="yyyy-mm-dd hh:mm:ss"/></td>
                        <td><fmt:formatDate value="${o.deliveryDate}" pattern="yyyy-mm-dd hh:mm:ss"/></td>
                        <td><fmt:formatDate value="${o.confirmDate}" pattern="yyyy-mm-dd hh:mm:ss"/></td>
                        <td>
                            <button class="checkDetail btn btn-primary btn-xs" oid="${o.id}">查看详情</button>
                            <c:if test="${o.status == 'waitDelivery'}">
                                <button class="delivery" oid="${o.id}">发货</button>
                            </c:if>
                        </td>
                    </tr>

                    <tr class="orderItemsDetail" oid="${o.id}">
                        <td colspan="10">
                            <table  align="center" width="800px"  class="orderPageOrderItemTable" style="padding: 50px">
                                <c:forEach items="${o.orderItems}" var="orderItem">
                                    <tr>
                                        <td><img height="40px" src="img/ps_original/${orderItem.product.productFirstImage.id}.jpg"></td>
                                        <td>${orderItem.product.name}</td>
                                        <td>${orderItem.number}个</td>
                                        <td>单价：${orderItem.product.promotePrice}</td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </td>
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
