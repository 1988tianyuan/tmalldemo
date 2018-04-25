<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/12
  Time: 16:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<script>
    $(function () {
        $("img.leaveMessageImg").click(function () {
            $("img.leaveMessageImg").hide();
            $("span.leaveMessageTextareaSpan").show();
            $("div.orderItemSumDiv").css("height", "100px");
        })

        $("form#createOrderSubmit").submit(function () {
            if(!checkEmpty("address", "地址")){
                return false;
            }
            if(!checkEmpty("receiver", "收货人姓名")){
                return false;
            }
            if(!checkEmpty("mobile", "手机号码")){
                return false;
            }
            alert("创建订单成功！");
            return true;
        })
    })
</script>

<div class="buyFlow">
    <img src="img/site/buyflow.png" class="pull-right">
    <div style="clear:both;"></div>
</div>

<form action="forecreateOrder" method="post" id="createOrderSubmit">
    <div class="address">
        <div class="addressTip">输入收货地址</div>
        <table class="addressTable">
            <tbody>
            <tr>
                <td>详细地址<span class="redStar">*</span></td>
                <td><textarea placeholder="建议您如实填写收货地址" name="address" id="address"></textarea></td>
            </tr>
            <tr>
                <td><span>邮政编码</span></td>
                <td><input placeholder="" class="postCode" name="post"></td>
            </tr>
            <tr>
                <td>收货人姓名<span class="redStar">*</span></td>
                <td><input placeholder="长度不超过25个字符" class="receiverName" name="receiver" id="receiver"></td>
            </tr>
            <tr>
                <td>手机号码<span class="redStar">*</span></td>
                <td><input placeholder="请输入11位手机号码" class="mobileNumber" name="mobile" id="mobile"></td>
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
            <tr class="rowborder">
                <td colspan="2"></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            </thead>
            <tbody class="productListTableTbody">
            <c:forEach items="${ois}" var="oi">
                <tr class="orderItemTR">
                    <td class="orderItemFirstTD">
                        <img class="orderItemImg" src="img/ps_small/${oi.product.productFirstImage.id}.jpg">
                    </td>
                    <td class="orderItemProductInfo">
                        <a class="orderItemProductLink" href="foreproduct?pid=${oi.product.id}">${oi.product.name}</a>
                        <img src="img/site/creditcard.png" title="支持信用卡支付">
                        <img src="img/site/7day.png" title="消费者保障服务,承诺7天退货">
                        <img src="img/site/promise.png" title="消费者保障服务,承诺如实描述">
                    </td>
                    <td>
                        <span class="orderItemProductPrice">￥${oi.product.promotePrice}</span>
                    </td>
                    <td>
                        <span class="orderItemProductNumber">${oi.number}</span>
                    </td>
                    <td>
                        <span class="orderItemUnitSum">￥${oi.number * oi.product.promotePrice}</span>
                    </td>
                    <td class="orderItemLastTD">
                        <input type="radio" checked="checked">
                        <label class="orderItemDeliveryLabel"> 普通配送 </label>
                        <select class="orderItemDeliverySelect">
                            <option>快递 免邮费</option>
                        </select>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <div class="orderItemSumDiv">
            <div class="pull-left">
                <span class="leaveMessageText">给卖家留言</span>
                <img src="img/site/leaveMessage.png" class="leaveMessageImg">
                <span class="leaveMessageTextareaSpan"style="display: none" >
                <textarea name="userMessage" class="leaveMessageTextarea"></textarea>
                <div>
                    <span>还可以输入200个字符</span>
                </div>
            </span>
            </div>
            <span class="pull-right">店铺合计（含运费）：￥${total}</span>
        </div>

        <div class="orderItemTotalSumDiv" style="text-align: right">
            <span>实付款：<span class="orderItemTotalSumSpan">￥${total}</span></span>
        </div>

        <div>
            <button class="submitOrderButton" type="submit">提交订单</button>
        </div>
        <div style="clear: both"></div>


    </div>
</form>

