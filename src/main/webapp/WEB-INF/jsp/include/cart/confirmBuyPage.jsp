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

        $("button.submitOrderButton").click(function () {
            var address = $("table.addressTable textarea").val();
            var post = $("table.addressTable input.postCode").val();
            var receiver = $("table.addressTable input.receiverName").val();
            var mobile = $("table.addressTable input.mobileNumber").val();
            var userMessage = $("textarea.leaveMessageTextarea").val();
            var page = "forecreateOrder";
            $.ajax({
                url:page, type:"post", data:{"address":address, "post":post, "receiver":receiver, "mobile":mobile, "userMessage":userMessage},
                success:function (resultPage) {
                    alert("提交成功，请及时付款！");
                    location.href = resultPage;
                }
            })
        })
    })
</script>

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
                <td><input placeholder="" class="postCode"></td>
            </tr>
            <tr>
                <td>收货人姓名<span class="redStar">*</span></td>
                <td><input placeholder="长度不超过25个字符" class="receiverName"></td>
            </tr>
            <tr>
                <td>手机号码<span class="redStar">*</span></td>
                <td><input placeholder="请输入11位手机号码" class="mobileNumber"></td>
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
        <button class="submitOrderButton">提交订单</button>
    </div>
    <div style="clear: both"></div>


</div>
