<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/4
  Time: 22:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
<script>

</script>
</head>
<body>
<div class="homepageCategoryProducts">
    <c:forEach items="${categories}" var="c" varStatus="stc">
        <div class="eachHomepageCategoryProducts">
            <div class="left-mark"></div>
            <span class="categoryTitle">${c.name}</span>
            <br>
            <c:forEach items="${c.products}" var="p" varStatus="st">
                <c:if test="${st.count<=5}">
                    <div class="productItem">
                        <a href="foreproduct?pid=${p.id}"><img width="100px" src="img/ps_middle/${p.productFirstImage.id}.jpg"></a>
                        <a class="productItemDescLink" href="foreproduct?pid=${p.id}">
                            <span class="productItemDesc">
                                    ${fn:substring(p.name,0 ,20)}
                            </span>
                        </a>
                        <span class="productPrice">
                            <fmt:formatNumber type="number" value="${p.promotePrice}" minFractionDigits="2"/>
                        </span>
                    </div>
                </c:if>
            </c:forEach>

            <div style="clear: both"></div>
        </div>
    </c:forEach>

    <img id="endpng" class="endpng" src="img/site/end.png">

</div>
</body>
</html>
