<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/4
  Time: 22:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <script>
        function showProductsAsideCategorys(cid){
            // $("div.eachCategory[cid="+cid+"]").css("background-color","white");
            // $("div.eachCategory[cid="+cid+"] a").css("color","#87CEFA");
            $("div.productsAsideCategorys[cid="+cid+"]").show();
        }


        function hideProductsAsideCategorys(cid){
            // $("div.eachCategory[cid="+cid+"]").css("background-color","#e2e2e3");
            // $("div.eachCategory[cid="+cid+"] a").css("color","#000");
            $("div.productsAsideCategorys[cid="+cid+"]").hide();
        }
        $(function(){

            //鼠标移到左侧分类目录上某一分类条目时，在右侧展现该分类条目的详细产品信息
            $("div.eachCategory").mouseenter(function(){
                var cid = $(this).attr("cid");
                showProductsAsideCategorys(cid);
            });

            //鼠标移到左侧分类目录上某一分类条目时，在右侧展现该分类条目的详细产品信息
            $("div.productsAsideCategorys").mouseenter(function(){
                var cid = $(this).attr("cid");
                showProductsAsideCategorys(cid);
            });

            //鼠标移到左侧分类目录上某一分类条目时，在右侧展现该分类条目的详细产品信息
            $("div.eachCategory").mouseleave(function(){
                var cid = $(this).attr("cid");
                hideProductsAsideCategorys(cid);
            });

            //鼠标从左侧分类目录上某一分类条目下的产品列表移走时，隐藏右侧该分类条目的详细产品列表
            $("div.productsAsideCategorys").mouseleave(function(){
                var cid = $(this).attr("cid");
                hideProductsAsideCategorys(cid);
            });

            //鼠标移到导航栏上的某个标签时，展现猫耳朵，渐变时间为500ms
            $("div.rightMenu span").mouseenter(function(){
                var left = $(this).position().left;
                var top = $(this).position().top;
                var width = $(this).css("width");
                var destLeft = parseInt(left) + parseInt(width)/2;
                $("img#catear").css("left",destLeft);
                $("img#catear").css("top",top-20);
                $("img#catear").fadeIn(500);
            });

            //鼠标移开导航栏上方时，隐藏猫耳朵
            $("div.rightMenu span").mouseleave(function(){
                $("img#catear").hide();
            });

            //保证导航栏、搜索栏、和分类目录与轮播窗口同宽
            var maxWidth = $("div#carousel-of-product").width();
            $("#outOfHeadbar").width(maxWidth);
            $("#outOfCategoryMenu").width(maxWidth);
            $("#outOfPAC").width(maxWidth);
            $("#outOfSearchZone").width(maxWidth);
            $("#outOfTop").width(maxWidth);

        });
    </script>
</head>

<img src="img/site/catear.png" class="catear" id="catear">

<%--轮播区域父元素，相对定位--%>
<div class="categoryWithCarousel">

    <%--导航栏，相对定位--%>
    <div class="headbar">

        <div id="outOfHeadbar" style="margin: auto">

        <div class="head ">
            <span style="margin-left:10px" class="glyphicon glyphicon-th-list"></span>
            <span style="margin-left:10px" >商品分类</span>
        </div>

        <div class="rightMenu">
            <span style="margin-left: 10px"><a href=""><img src="img/site/chaoshi.png"></a></span>
            <span style="margin-left: 10px"><a href=""><img src="img/site/guoji.png"></a></span>
            <c:forEach items="${categories}" var="c" varStatus="vs">
                <c:if test="${vs.count<=6}">
                    <span><a href="foreCategory?cid=${c.id}">${c.name}</a></span>
                </c:if>
            </c:forEach>
        </div>

        </div>
    </div>

    <%--分类目录栏，相对定位;内部子元素目录栏绝对定位,z-index向上一位   --%>
    <div id= "outOfCategoryMenu" style="position:relative; margin: auto">
        <%@include file="categoryMenu.jsp" %>
    </div>

    <%--推荐商品栏，相对定位；内部子元素绝对定位,z-index向上一位    --%>
    <div id="outOfPAC" style="position: relative; left: 0; top:0; margin: auto">
        <%@include file="productsAsideCategorys.jsp" %>
    </div>

    <%--商品轮播，相对定位    --%>
    <%@include file="carousel.jsp"%>

    <%--轮播背景图，绝对定位，z-index向下一位--%>
    <div class="carouselBackgroundDiv"></div>
</div>

</html>
