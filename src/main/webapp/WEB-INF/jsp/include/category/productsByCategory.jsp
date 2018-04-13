<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/9
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<div class="categoryProducts">
    <c:forEach items="${products}" var="product">
        <div class="productUnit" price="${product.promotePrice}">
            <div class="productUnitFrame">
                <a href="foreproduct?pid=${product.id}"><img class="productImage" src="img/ps_middle/${product.productFirstImage.id}.jpg"></a>
                <span class="productPrice">￥${product.promotePrice}</span>
                <a href="foreproduct?pid=${product.id}" class="productLink">${product.name}</a>
                <a class="tmallLink" href="#nowhere">天猫专卖</a>
                <div class="productInfo">
                    <span class="monthDeal">
                        月成交<span class="productDealNumber">${product.saleCount}笔</span>
                    </span>
                    <span class="productReview">
                        评价<span class="productReviewNumber">${product.reviewCount}</span>
                    </span>
                    <span class="wangwang">
                        <a href="#nowhere"><img src="img/site/wangwang.png"></a>
                    </span>
                </div>
            </div>
        </div>
    </c:forEach>
    <div style="clear: both"></div>
</div>



