<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/9
  Time: 16:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<div class="categorySortBar">
    <table class="categorySortBarTable categorySortTable">
        <tbody>
            <tr>
                <td class="grayColumn"><a href="foreCategory?cid=${category.id}&sort=all">综合<span class="glyphicon glyphicon-arrow-down"></span></a></td>
                <td><a href="foreCategory?cid=${category.id}&sort=review">人气<span class="glyphicon glyphicon-arrow-down"></span></a></td>
                <td><a href="foreCategory?cid=${category.id}&sort=date">新品<span class="glyphicon glyphicon-arrow-down"></span></a></td>
                <td><a href="foreCategory?cid=${category.id}&sort=sale">销量<span class="glyphicon glyphicon-arrow-down"></span></a></td>
                <td><a href="foreCategory?cid=${category.id}&sort=price">价格<span class="glyphicon glyphicon-resize-vertical"></span></a></td>
            </tr>
        </tbody>
    </table>

    <table class="categorySortBarTable">
        <tbody>
            <tr>
                <td><input class="sortBarPrice beginPrice" type="text" placeholder="请输入"></td>
                <td class="priceMiddleColumn">-</td>
                <td><input class="sortBarPrice endPrice" type="text" placeholder="请输入"></td>
            </tr>
        </tbody>
    </table>




</div>
