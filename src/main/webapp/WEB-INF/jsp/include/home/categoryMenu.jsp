<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/5
  Time: 10:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>


    <div class="categoryMenu">
        <c:forEach items="${categories}" var="c" varStatus="vs">
            <c:if test="${vs.count<=17}">
                <div cid="${c.id}" class="eachCategory">
                    <span class="glyphicon glyphicon-link"></span>
                    <a href="foreCategory?cid=${c.id}">
                            ${c.name}
                    </a>
                </div>
            </c:if>
        </c:forEach>
    </div>


