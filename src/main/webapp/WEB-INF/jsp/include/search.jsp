<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/4
  Time: 20:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<div id="outOfSearchZone" style="margin: auto; position: relative">
<a href="${contextPath}">
    <img id="logo" class="logo" src="img/site/logo.gif">
</a>

<form action="foresearch" method="post">
    <div class="searchDiv">
        <input name="keyword" placeholder="时尚男鞋 太阳镜" type="text">
        <button type="submit" class="searchButton">搜索</button>
        <div class="searchBelow">
            <c:forEach items="${categories}" var="c" varStatus="vs">
                <c:if test="${vs.count>=5 and vs.count<=8}">
                    <a href="forecategory?cid=${c.id}">
                        ${c.name}
                    </a>
                    <c:if test="${vs.count != 8}">
                        <span>|</span>
                    </c:if>
                </c:if>
            </c:forEach>
        </div>
    </div>



</form>
</div>