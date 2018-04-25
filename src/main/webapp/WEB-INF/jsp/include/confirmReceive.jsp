<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/24
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<script>
    $(function () {
        $("a.confirmPay").click(function () {
            return confirm("确认已收货？");
        })
    })
</script>

<div class="confirmPayPageDiv">
    <div class="confirmPayImageDiv">
        <img src="img/site/comformPayFlow.png">
        <div class="confirmPayTime1">${order.createDate}</div>
        <div class="confirmPayTime2">${order.payDate}</div>
        <div class="confirmPayTime3">${order.deliveryDate}</div>
    </div>
    <div class="confirmPayOrderInfoText">
        我已收到货，同意支付宝付款
    </div>
    <div class="confirmPayOrderItemDiv">
        <div class="confirmPayOrderItemText">订单信息</div>
        <table class="confirmPayOrderItemTable">
            <thead>
                <tr>
                    <th colspan="2">宝贝</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>商品总价</th>
                    <th>运费</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${order.orderItems}" var="orderItem">
                <tr>
                    <td>
                        <img src="img/ps_small/${orderItem.product.productFirstImage.id}.jpg">
                    </td>
                    <td class="confirmPayOrderItemProductLink">
                        <a href="foreproduct?pid=${orderItem.product.id}">${orderItem.product.name}</a>
                    </td>
                    <td>
                        <span>￥${orderItem.product.promotePrice}</span>
                    </td>
                    <td>
                        <span class="confirmPayOrderItemSumPrice">${orderItem.number}</span>
                    </td>
                    <td>
                        <span class="conformPayProductPrice">￥${orderItem.product.promotePrice * orderItem.number}</span>
                    </td>
                    <td>快递：0.00</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="confirmPayOrderDetailDiv">
        <table class="confirmPayOrderDetailTable">
            <tr>
                <td>订单编号：</td>
                <td>${order.orderCode}  <img src="img/site/confirmOrderTmall.png"></td>
            </tr>
            <tr>
                <td>卖家昵称：</td>
                <td>天猫商铺<span class="confirmPayOrderDetailWangWangGif"></span></td>
            </tr>
            <tr>
                <td>收货信息：</td>
                <td>${order.address}</td>
            </tr>
            <tr>
                <td>成交时间：</td>
                <td>${order.payDate}</td>
            </tr>
        </table>
    </div>
    <div class="confirmPayButtonDiv">
        <div class="confirmPayWarning">请收到货后，再确认收货！否则您可能钱货两空！</div>
        <a href="foreConfirmReceive?oid=${order.id}" class="confirmPay">
            <button class="confirmPayButton">确认收货</button>
        </a>
    </div>
</div>