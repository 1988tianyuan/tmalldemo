<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/8
  Time: 22:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<div class="productReviewDiv">
    <div class="productReviewTopPart">
        <a  href="#nowhere" class="productReviewTopPartSelectedLink">商品详情</a>
        <a  href="#nowhere" class=" selected">累计评价 <span class="productReviewTopReviewLinkNumber">${product.reviewCount}</span> </a>
    </div>

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
</div>


