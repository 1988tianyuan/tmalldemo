<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/15
  Time: 22:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<script>
    $(function () {
        //加载页面时将每个orderItem的初始小计金额加载出来
        $("span.cartProductItemPromotionPrice").each(function () {
            var vst = $(this).attr("itemNum");
            var promotePrice = $("span.cartProductItemPromotionPrice[itemNum="+vst+"]").html();
            var number = $("div.cartProductChangeNumberDiv[itemNum="+vst+"] input").val();
            $("span.cartProductItemSmallSumPrice[itemNum="+vst+"]").html(promotePrice*number);
        })

        //点击减号，将orderItem的数量减少一个；同时刷新该orderItem的小计金额
        $("a.numberMinus").click(function () {
            var vst = $(this).parent().attr("itemNum");
            var number = $("div.cartProductChangeNumberDiv[itemNum="+vst+"] input").val();
            var oiid = $("img.cartProductItemIfSelected[itemNum="+vst+"]").attr("oiid");
            number = parseInt(number);
            if(number>1){
                number--;
                $("div.cartProductChangeNumberDiv[itemNum="+vst+"] input").val(number);
            }else {
                $("div.cartProductChangeNumberDiv[itemNum="+vst+"] input").val(1);
            }
            var promotePrice = $("span.cartProductItemPromotionPrice[itemNum="+vst+"]").html();
            $("span.cartProductItemSmallSumPrice[itemNum="+vst+"]").html(promotePrice*(number));
            syncPrice();
            changeOiNum(oiid, number);
        })

        //点击加号，将orderItem的数量增加一个；同时刷新该orderItem的小计金额
        $("a.numberPlus").click(function () {
            var vst = $(this).parent().attr("itemNum");
            var number = $("div.cartProductChangeNumberDiv[itemNum="+vst+"] input").val();
            var oiid = $("img.cartProductItemIfSelected[itemNum="+vst+"]").attr("oiid");
            number = parseInt(number);
            number++;
            $("div.cartProductChangeNumberDiv[itemNum="+vst+"] input").val(number);
            var promotePrice = $("span.cartProductItemPromotionPrice[itemNum="+vst+"]").html();
            $("span.cartProductItemSmallSumPrice[itemNum="+vst+"]").html(promotePrice*(number));
            syncPrice();
            changeOiNum(oiid, number);
        })

        //当点击每个orderItem前面的选择框时，将总计金额加上（减去）当前小计金额
        $("img.cartProductItemIfSelected").click(function () {
            var whetherSelected = $(this).attr("whetherSelected");
            if("false" === whetherSelected){
                $(this).attr("src", "img/site/cartSelected.png");
                $(this).attr("whetherSelected", "true");
                $(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
            }else{
                $(this).attr("src", "img/site/cartNotSelected.png");
                $(this).attr("whetherSelected", "false");
                $(this).parents("tr.cartProductItemTR").css("background-color","#fff");
            }
            syncPrice();
        })

        //点击两个合计选择框，只有两种情况，全选时总价为每个item单个价格之和，取消全选时将总价设为0
        $("img.selectAllItem").click(function () {
            var whetherSelected = $(this).attr("whetherSelected");
            if("false" === whetherSelected){
                $("img.selectAllItem").attr("src", "img/site/cartSelected.png");
                $("img.selectAllItem").attr("whetherSelected", "true");
                syncSelectStatus(true);
                syncPrice();
            }else{
                $("img.selectAllItem").attr("src", "img/site/cartNotSelected.png");
                $("img.selectAllItem").attr("whetherSelected", "false");
                syncSelectStatus(false);
                syncPrice();
            }
        })

        $("a.deleteOi").click(function () {
            return confirm("你确定要删除吗？");
        })
        
        //将所选的订单项提交到“确认购买”页面
        $("button.createOrderButton").click(function () {
            var oiidSelected;
            var page = "confirmBuy?"
            $("img.cartProductItemIfSelected").each(function () {
                if("true" === $(this).attr("whetherSelected")){
                    oiidSelected = $(this).attr("oiid");
                    page = page + "oiid=" + oiidSelected + "&";
                }
            })
            page = page.substr(0, page.length-1);
            location.href = page;
        })
    })

    //全局函数，用于在点选全选框后实时将当前选择情况同步到每个分选框中，分为全选和全不选两个情况
    function syncSelectStatus(whetherToSelect){
        if(whetherToSelect){
            $("img.cartProductItemIfSelected").each(function () {
                $(this).attr("src", "img/site/cartSelected.png");
                $(this).attr("whetherSelected", "true");
                $(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");

            })
        }else{
            $("img.cartProductItemIfSelected").each(function () {
                $(this).attr("src", "img/site/cartNotSelected.png");
                $(this).attr("whetherSelected", "false");
                $(this).parents("tr.cartProductItemTR").css("background-color","#fff");
            })
        }
    }

    //将每个选中的orderItem的金额同步到总价中
    function syncPrice() {
        var sumPrice = 0;
        $("img.cartProductItemIfSelected").each(function () {
            var vst = $(this).attr("itemNum");
            var whetherSelected = $(this).attr("whetherSelected");
            var smallSum = $("span.cartProductItemSmallSumPrice[itemNum="+vst+"]").html();
            smallSum = parseFloat(smallSum);
            if("true" === whetherSelected){
                sumPrice += smallSum;
            }
        })
        if(0 != sumPrice){
            $("button.createOrderButton").css("background-color","#C40000");
            $("button.createOrderButton").removeAttr("disabled");
        }else {
            $("button.createOrderButton").css("background-color","#AAAAAA");
            $("button.createOrderButton").attr("disabled","disabled");
        }
        $("span#cartSumPrice").html(sumPrice);
    }

    function changeOiNum(oiid, num) {
        var page = "changeoinumber";
        $.ajax({
            url:page, data:{"oiid":oiid,"num":num},type:"post",
            success:function (result) {
                if("success" === result){
                    console.log(result);
                }
            }
        })
    }




</script>


    <div class="cartTitle pull-right">
        已选商品（不含运费）
        <span class="cartTitlePrice">￥0.00</span>
        <button class="createOrderButton" disabled="disabled">结算</button>
    </div>
    <div style="clear: both"></div>

    <div>
        <table class="cartProductTable">
            <thead>
                <tr>
                    <th>
                        <img src="img/site/cartNotSelected.png" class="selectAllItem" whetherSelected="false">全选
                    </th>
                    <th>商品信息</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>金额</th>
                    <th class="operation">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${ois}" var="oi" varStatus="vst">
                    <tr class="cartProductItemTR">
                        <td>
                            <img src="img/site/cartNotSelected.png" class="cartProductItemIfSelected" whetherSelected="false" itemNum="${vst.count}"  oiid="${oi.id}">
                            <img class="cartProductImg" src="img/ps_small/${oi.product.productFirstImage.id}.jpg">
                        </td>
                        <td>
                            <div class="cartProductLinkOutDiv">
                                <a class="cartProductLink" href="foreproduct?pid=${oi.product.id}">${oi.product.name}</a>
                                <div class="cartProductLinkInnerDiv">
                                    <img src="img/site/creditcard.png" title="支持信用卡支付">
                                    <img src="img/site/7day.png" title="消费者保障服务,承诺7天退货">
                                    <img src="img/site/promise.png" title="消费者保障服务,承诺如实描述">
                                </div>
                            </div>
                        </td>
                        <td>
                            <span class="cartProductItemOringalPrice">￥${oi.product.originalPrice}</span>
                            <span class="cartProductItemPromotionPrice">￥</span>
                            <span class="cartProductItemPromotionPrice" itemNum="${vst.count}">${oi.product.promotePrice}</span>
                        </td>
                        <td>
                            <div class="cartProductChangeNumberDiv" itemNum="${vst.count}" >
                                <a href="#nowhere" class="numberMinus">-</a>
                                <input type="text" value="${oi.number}" class="orderItemNumberSetting">
                                <a href="#nowhere" class="numberPlus">+</a>
                            </div>
                        </td>
                        <td>
                            <span class="cartProductItemPromotionPrice">￥</span>
                            <span class="cartProductItemSmallSumPrice" itemNum="${vst.count}"></span>
                        </td>
                        <td>
                            <a class="deleteOi" href="deleteOi?oiid=${oi.id}">删除</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="cartFoot">
        <img src="img/site/cartNotSelected.png" class="selectAllItem" whetherSelected="false">
        全选
        <div class="pull-right">
            已选商品
            <span class="cartSumNumber">0</span>
            件，合计（不含运费）：
            <span class="cartSumPrice">￥</span>
            <span class="cartSumPrice" id="cartSumPrice">
                0.00
            </span>
            <button class="createOrderButton" disabled="disabled">结算</button>
        </div>
    </div>


