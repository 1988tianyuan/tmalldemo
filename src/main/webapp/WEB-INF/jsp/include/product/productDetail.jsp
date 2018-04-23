<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/8
  Time: 22:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<div class="productDetailDiv">
    <div class="productDetailTopPart">
        <a class="productDetailTopPartSelectedLink selected" href="#nowhere">商品详情</a>
        <a class="productDetailTopReviewLink" href="#nowhere">累计评价  <span class="productDetailTopReviewLinkNumber">${product.reviewCount}</span></a>
    </div>

    <div class="productParamterPart">
        <div class="productParamter">产品参数</div>
        <div class="productParamterList">
            <c:forEach items="${pvs}" var="pv">
                <span>${pv.property.name}:   ${pv.value}</span>
            </c:forEach>
        </div>
        <div style="clear: both"></div>
    </div>

    <div class="productDetailImagesPart">
        <c:forEach items="${product.productDetailImages}" var="pdi">
            <img src="img/p_detail/${pdi.id}.jpg">
        </c:forEach>
    </div>


</div>
