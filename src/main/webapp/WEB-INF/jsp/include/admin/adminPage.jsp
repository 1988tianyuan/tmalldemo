<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/27
  Time: 16:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    $(function () {
        $("ul.pagination li.disabled a").click(function () {
            return false;
        })
    })
</script>

<nav>
    <ul class="pagination">
    <%--bootstrap的分页控件，是个无序列表--%>
        <li <c:if test="${!page.hasPrevious}">class="disabled" </c:if>>
        <%--如果没有上一页（即page对象的hasPrevious为false）则无法点击该元素；后面同理--%>
            <a href="?start=0${page.param}" aria-label="Previous"><<</a>
        </li>
        <li <c:if test="${!page.hasPrevious}">class="disabled" </c:if>>
            <a href="?start=${page.start-page.count}${page.param}" aria-label="Previous"><</a>
        </li>
        <c:forEach begin="0" end="${page.totalPage-1}" varStatus="status">
            <li <c:if test="${page.start==status.index*page.count}">class="disabled" </c:if>>
                <a href="?start=${status.index*page.count}${page.param}" class="current">${status.count}</a>
                <%--status是每次遍历的对象，index是status的下标，start.count是每次遍历的计数--%>
            </li>
        </c:forEach>
        <li <c:if test="${!page.hasNext}">class="disabled" </c:if>>
            <a href="?start=${page.start+page.count}${page.param}" aria-label="Next">></a>
        </li>
        <li <c:if test="${!page.hasNext}">class="disabled" </c:if>>
            <a href="?start=${page.last}${page.param}" aria-label="Next">>></a>
        </li>
    </ul>
</nav>