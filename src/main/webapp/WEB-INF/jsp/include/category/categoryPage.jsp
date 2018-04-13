<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/9
  Time: 16:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>${category.name}</title>
    <script>
        $(function () {
            //对产品价格进行删选显示
            $("input.sortBarPrice").keyup(function () {
                //如果输入信息不为数字则自动清空
                var num = $(this).val();
                if (isNaN(num)) {
                    num = "";
                    $(this).val(num);
                    return;
                }

                //获取两端输入的信息
                var begin = $("input.beginPrice").val();
                var end = $("input.endPrice").val();

                //如果任意一端输入的信息为空，则将产品全部展示出来
                if (0 === begin.length || 0 === end.length) {
                    $("div.productUnit").each(function () {
                        $(this).show();
                    });
                    return;
                }

                //确保输入的信息为浮点数
                begin = parseFloat(begin);
                end = parseFloat(end);

                //筛选位于两端条件中间的产品
                $("div.productUnit").each(function () {
                    var price = $(this).attr("price");
                    if (begin <= price && end >= price) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                })
            })



        })


    </script>


</head>
<body>
<div id="category">
    <div class="categoryPageDiv">
        <img src="img/category/${category.id}.jpg" style="width: 1180px; height: 100px">
        <%@include file="sortBar.jsp"%>
        <%@include file="productsByCategory.jsp"%>
    </div>
</div>




</body>
</html>
