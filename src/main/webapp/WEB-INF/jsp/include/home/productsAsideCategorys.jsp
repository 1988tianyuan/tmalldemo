<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/5
  Time: 10:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>

</head>
<body>
<c:forEach items="${categories}" var="c">
    <div cid="${c.id}" class="productsAsideCategorys">
        <c:forEach items="${c.productsByRow}" var="pr">
            <div class="row show1">
                <c:forEach items="${pr}" var="p">
                    <c:if test="${!empty p.subTitle}">
                        <a href="foreproduct?pid=${p.id}">
                            <c:forEach items="${fn:split(p.subTitle, ' ')}" var="title" varStatus="st">
                                <c:if test="${st.index==0}">
                                    ${title}
                                </c:if>
                            </c:forEach>
                        </a>
                    </c:if>
                </c:forEach>
                <div class="seperator"></div>
            </div>


        </c:forEach>
    </div>

</c:forEach>
</body>
</html>
