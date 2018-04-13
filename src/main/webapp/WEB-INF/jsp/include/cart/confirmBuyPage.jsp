<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/12
  Time: 16:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<div class="buyFlow">
    <img src="img/site/buyflow.png" class="pull-right">
    <div style="clear:both;"></div>
</div>

<div class="address">
    <div class="addressTip">输入收货地址</div>
    <table class="addressTable">
        <tbody>
            <tr>
                <td>详细地址<span class="redStar">*</span></td>
                <td><textarea placeholder="建议您如实填写收货地址"></textarea></td>
            </tr>
            <tr>
                <td><span>邮政编码</span></td>
                <td><input placeholder=""></td>
            </tr>
            <tr>
                <td>收货人姓名<span class="redStar">*</span></td>
                <td><input placeholder="长度不超过25个字符"></td>
            </tr>
            <tr>
                <td>手机号码<span class="redStar">*</span></td>
                <td><input placeholder="请输入11位手机号码"></td>
            </tr>
        </tbody>
    </table>
</div>

<div class="productList">
    <div class="productListTip">确认订单信息</div>
    <table class="productListTable">
        <thead>
            <tr style="border-bottom: skyblue;">
                <th class="productListTableFirstColumn" colspan="2">
                    <img class="tmallbuy" src="img/site/tmallbuy.png">
                    <a class="marketLink" href="#nowhere"><span>店铺：天猫店铺</span></a>
                    <span class="wangwangGif"></span>
                </th>
                <th>单价</th>
                <th>数量</th>
                <th>小计</th>
                <th>配送方式</th>
            </tr>
        </thead>
        <tbody class="productListTableTbody">
        <c:forEach items="${ois}" var="oi">
            <tr class="orderItemTR">
                <td class="orderItemFirstTD">
                    <img class="orderItemImg" src="img/ps_small/${oi.product.productFirstImage.id}.jpg">
                </td>
                <td class="orderItemProductInfo">
                    <span><a class="orderItemProductLink" href="foreproduct?pid=${oi.product.id}">${oi.product.name}</a></span>
                </td>
                <td>
                    <span class="orderItemProductPrice">￥${oi.product.promotePrice}</span>
                </td>
                <td>
                    <span class="orderItemProductNumber">${oi.number}</span>
                </td>
                <td>
                    <span class="orderItemUnitSum">${oi.number * oi.product.promotePrice}</span>
                </td>
                <td class="orderItemLastTD">

                </td>
            </tr>
        </c:forEach>
        </tbody>

    </table>

</div>
