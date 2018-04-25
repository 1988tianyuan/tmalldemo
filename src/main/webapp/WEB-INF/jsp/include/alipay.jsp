<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/22
  Time: 17:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<div class="aliPayPageDiv">
    <div class="aliPayPageLogo">
        <img src="img/site/simpleLogo.png" class="pull-left"/>
    </div>
    <div style="clear: both"></div>
    <div>订单号：${orderWithoutPay.orderCode}</div>
    <div>
        <span class="confirmMoneyText">扫一扫付款（元）</span>
        <span class="confirmMoney">￥${orderWithoutPay.totalCost}</span>
    </div>
    <div>
        <img src="img/site/alipay2wei.png" class="aliPayImg">
    </div>
    <div>
        <a href="forepay?oid=${orderWithoutPay.id}">确定付款</a>
    </div>

</div>
