<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/24
  Time: 16:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<div class="reviewDiv">
    <div class="reviewProductInfoImg">
        <img class="reviewProductImg" src="img/ps_original/${product.productFirstImage.id}.jpg">
    </div>
    <div class="reviewProductInfoRightDiv">
        <div class="reviewProductInfoRightText">
            ${product.name}
        </div>
        <table class="reviewProductInfoTable">
            <tr>
                <td>价格：</td>
                <td><span class="reviewProductInfoTablePrice">￥${product.promotePrice}</span></td>
            </tr>
            <tr>
                <td>配送：</td>
                <td>快递：0.00</td>
            </tr>
            <tr>
                <td>月销量：</td>
                <td><span class="reviewProductInfoTableSellNumber"></span>${product.saleCount}件</td>
            </tr>
        </table>
        <div class="reviewProductInfoRightBelowDiv">
            <span class="reviewProductInfoRightBelowImg">
            <span class="reviewProductInfoRightBelowText">
                现在查看的是 您所购买商品的信息 于${order.createDate}下单购买了此商品
            </span>
        </div>
    </div>
    <div style="clear: both"></div>
    <div class="reviewStasticsDiv">
        <div class="reviewStasticsLeft">
            <div class="reviewStasticsLeftTop"></div>
            <div class="reviewStasticsLeftContent">累计评价 <span class="reviewStasticsNumber"> ${product.reviewCount}</span></div>
            <div class="reviewStasticsLeftFoot"></div>
        </div>
        <div class="reviewStasticsRight">
            <div class="reviewStasticsRightEmpty"></div>
            <div class="reviewStasticsFoot"></div>
        </div>
    </div>
    <c:if test="${order.status == 'waitReview'}">
        <div class="makeReviewDiv">
            <form  method="post" action="foreCompleteReview">
                <div class="makeReviewText">其他买家，需要你的建议哦！</div>
                <table class="makeReviewTable">
                    <tbody>
                    <tr>
                        <td class="makeReviewTableFirstTD">评价商品</td>
                        <td><textarea name="content"></textarea></td>
                    </tr>
                    </tbody>
                </table>
                <div class="makeReviewButtonDiv">
                    <input type="hidden" value="${order.id}" name="oid">
                    <input type="hidden" value="${product.id}" name="pid">
                    <button type="submit">提交评价</button>
                </div>
            </form>
        </div>
    </c:if>
    <c:if test="${order.status == 'finish'}">
        <div class="productReviewContentPart">
            <c:forEach items="${reviews}" var="review">
                <div class="productReviewItem">
                    <div class="productReviewItemDesc">
                        <div class="productReviewItemContent">${review.content}</div>
                        <div class="productReviewItemDate">
                            <fmt:formatDate value="${review.createDate}" pattern="yyyy-MM-dd"/>
                        </div>
                    </div>
                    <div class="productReviewItemUserInfo">${review.user.anonymousName}</div>
                    <div style="clear: both"></div>
                </div>
            </c:forEach>
        </div>
    </c:if>


</div>
