<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/23
  Time: 23:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<script>
    $(function () {
        //点击对应的标签，展现对应状态的订单
        $("a.statusExchange").click(function () {
            $("div.orderType div").removeClass("selectedOrderType");
            $(this).parent("div").addClass("selectedOrderType");
            $("table.orderListItemTable").hide();
            if($(this).attr("orderStatus")==="waitPay"){
                $("table.orderListItemTable[orderStatus=waitPay]").show();
            }
            if($(this).attr("orderStatus")==="waitDelivery"){
                $("table.orderListItemTable[orderStatus=waitDelivery]").show();
            }
            if($(this).attr("orderStatus")==="waitConfirm"){
                $("table.orderListItemTable[orderStatus=waitConfirm]").show();
            }
            if($(this).attr("orderStatus")==="waitReview"){
                $("table.orderListItemTable[orderStatus=waitReview]").show();
            }
            if($(this).attr("orderStatus")==="all"){
                $("table.orderListItemTable").show();
            }
        })

        $("a.deleteOrderLink").click(function () {
            if($(this).parents("table").attr("orderStatus")==="finish"){
                return confirm("确认删除该订单？？？");
            }
            return false;
        })
    })
    
    
</script>

<div class="boughtDiv">
    <div class="orderType">
        <div class="selectedOrderType">
            <a class="statusExchange" href="#nowhere" orderStatus="all">所有订单</a>
        </div>
        <div>
            <a class="statusExchange" href="#nowhere" orderStatus="waitPay">待付款</a>
        </div>
        <div>
            <a class="statusExchange" href="#nowhere" orderStatus="waitDelivery">待发货</a>
        </div>
        <div>
            <a class="statusExchange" href="#nowhere" orderStatus="waitConfirm">待收货</a>
        </div>
        <div>
            <a class="noRightborder statusExchange" href="#nowhere" orderStatus="waitReview">待评价</a>
        </div>
        <div class="orderTypeLastOne"></div>
    </div>
    <div style="clear: both"></div>
    <table class="orderListTitleTable">
        <thead>
        <tr>
            <th width="718px">宝贝</th>
            <th width="160px">单价</th>
            <th width="160px">数量</th>
            <th width="160px">实付款</th>
            <th width="160px">交易操作</th>
        </tr>
        </thead>
    </table>
    <c:forEach items="${orders}" var="order">
        <table class="orderListItemTable" orderStatus="${order.status}">
            <thead>
                <tr class="orderListItemFirstTR">
                    <th colspan="2">
                        <span>
                            <fmt:formatDate value="${order.createDate}" pattern="yyyy-MM-dd"/>
                        </span>
                        <span>  订单号${order.orderCode}</span>
                    </th>
                    <th>
                        <img src="img/site/tmallbuy.png" style="height: 10px"><span>天猫商场</span>
                    </th>
                    <th></th>
                    <th>
                        <div class="orderItemWangWangGif"></div>
                    </th>
                    <th class="orderItemDeleteTD">
                        <a href="foreDeleteOrder?oid=${order.id}" class="deleteOrderLink">
                            <span class="orderListItemDelete glyphicon glyphicon-trash"></span>
                        </a>
                    </th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${order.orderItems}" var="orderItem" varStatus="st">
                    <tr class="orderItemProductInfoPartTR">
                        <td class="orderItemProductInfoPartTD" width="80px">
                            <img src="img/ps_original/${orderItem.product.productFirstImage.id}.jpg" height="80px">
                        </td>
                        <td class="orderItemProductInfoPartTD">
                            <div class="orderListItemProductLinkOutDiv">
                                <a href="foreproduct?pid=${orderItem.product.id}">${orderItem.product.name}</a>
                                <div class="orderListItemProductLinkInnerDiv">
                                    <img title="支持信用卡支付" src="img/site/creditcard.png">
                                    <img title="消费者保障服务,承诺7天退货" src="img/site/7day.png">
                                    <img title="消费者保障服务,承诺如实描述" src="img/site/promise.png">
                                </div>
                            </div>
                        </td>
                        <td class="orderItemProductInfoPartTD" width="100px">
                            <div class="orderListItemProductOriginalPrice">￥${orderItem.product.originalPrice}</div>
                            <div class="orderListItemProductPrice">￥${orderItem.product.promotePrice}</div>
                        </td>
                        <c:if test="${st.count == 1}">
                            <td rowspan="${fn:length(order.orderItems)}" class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
                                <span class="orderListItemNumber">${order.totalNumber}</span>
                            </td>
                            <td rowspan="${fn:length(order.orderItems)}" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD" width="100px">
                                <div class="orderListItemProductRealPrice">${order.totalCost}</div>
                                <div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>
                            </td>
                            <td rowspan="${fn:length(order.orderItems)}" class="orderListItemButtonTD orderItemOrderInfoPartTD" width="100px">
                                <c:if test="${order.status == 'waitPay'}">
                                    <a href="foreConfirmPay?oid=${order.id}">
                                        <button class="orderListItemPay">确定付款</button>
                                    </a>
                                </c:if>
                                <c:if test="${order.status == 'waitDelivery'}">
                                    等待发货
                                </c:if>
                                <c:if test="${order.status == 'waitConfirm'}">
                                    <a href="foreConfirmReceivePage?oid=${order.id}">
                                        <button class="orderListItemConfirm">确认收货</button>
                                    </a>
                                </c:if>
                                <c:if test="${order.status == 'waitReview'}">
                                    <a href="foreReview?oid=${order.id}">
                                        <button class="orderListItemReview">进行评价</button>
                                    </a>
                                </c:if>
                                <c:if test="${order.status == 'finish'}">
                                    订单完成
                                </c:if>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
            </tbody>
        </table>


    </c:forEach>


</div>

