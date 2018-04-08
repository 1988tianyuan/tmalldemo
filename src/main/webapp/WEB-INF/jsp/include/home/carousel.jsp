<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/5
  Time: 10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>

</head>

<div id="carousel-of-product"  class="carousel-of-product carousel slide" data-ride="carousel" >
    <!-- Indicators -->
    <ol class="carousel-indicators">
        <li data-target="#carousel-of-product" data-slide-to="0" class="active"></li>
        <li data-target="#carousel-of-product" data-slide-to="1"></li>
        <li data-target="#carousel-of-product" data-slide-to="2"></li>
        <li data-target="#carousel-of-product" data-slide-to="3"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
        <div class="item active">
            <img class="carousel carouselImage" src="img/lunbo/1.jpg" >
        </div>
        <div class="item">
            <img  class="carouselImage" src="img/lunbo/2.jpg" >
        </div>
        <div class="item">
            <img  class="carouselImage" src="img/lunbo/3.jpg" >
        </div>
        <div class="item">
            <img  class="carouselImage" src="img/lunbo/4.jpg" >
        </div>
    </div>

    <!-- 左右切换按钮 -->
    <a class="left carousel-control" href="#carousel-of-product" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left"></span>
    </a>
    <a class="right carousel-control" href="#carousel-of-product" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right"></span>
    </a>


</div>
</html>
