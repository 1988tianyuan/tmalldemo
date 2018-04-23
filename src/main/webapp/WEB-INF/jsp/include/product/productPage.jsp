<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/8
  Time: 21:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>${product.name}</title>
    <script>
        $(function () {
            $("a.productReviewTopPartSelectedLink").click(function () {
                $("div.productDetailDiv").show();
                $("div.productReviewDiv").hide();
            })

            $("a.productDetailTopReviewLink").click(function () {
                $("div.productReviewDiv").show();
                $("div.productDetailDiv").hide();
            })
        })





    </script>
</head>
<body>
<div class="productPageDiv">
    <%@include file="imgAndInfo.jsp"%>
    <%@include file="productDetail.jsp"%>
    <%@include file="productReview.jsp"%>
</div>
</body>
</html>
