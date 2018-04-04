<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/27
  Time: 22:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
<html>
<head>
    <title>产品图片管理-${product.name}</title>
    <script>
        $(function () {
            $("#uploadSingleForm").submit(function () {
                if(!checkEmpty("productSinglePic","产品图片")){
                    return false;
                }
                return true;
            })
        })

        $(function () {
            $("#uploadDetailForm").submit(function () {
                if(!checkEmpty("productDetailPic","产品详细图片")){
                    return false;
                }
                return true;
            })
        })

        $(function () {
            $("a").click(function () {
                var deleteLink = $(this).attr("deleteLink");
                if("true"==deleteLink){
                    if(confirm("确认删除该图片？")){
                     return true;
                    }
                    return false;
                }
            });
        })
    </script>
</head>
<body>
<div class="workingArea">
    <h1 class="label label-info">产品管理</h1><br><br>
    <%--信息标签--%>

    <%--bootstrap的面包屑导航控件--%>
    <ol class="breadcrumb">
        <li><a href="admin_category_list">所有分类</a></li>
        <li><a href="admin_product_list?cid=${product.cid}">${product.category.name}</a> </li>
        <li><a href="admin_productImage_list?pid=${product.id}">${product.name}</a></li>
        <li class="active">产品图片管理</li>
    </ol>

    <table class="addPictureTable" align="center">
        <tr>
            <td class="addPictureTableTD">
                <div class="panel panel-warning addPictureDiv">
                    <%--bootstrap的panel面板容器，以及容器的风格；addDiv是对该容器的大小进行设置--%>
                    <div class="panel-heading">新增产品 <b class="text-primary">单个的</b> 图片</div>
                    <%--面板标题--%>
                    <div class="panel-body">
                        <%--面板体--%>
                        <form method="post" id="uploadSingleForm" action="admin_productImage_add" enctype="multipart/form-data">
                            <table class="addTable">
                                <tr>
                                    <td colspan="2" align="center">请选择本地的图片，尺寸400X400最佳</td>
                                </tr>
                                <td>
                                    <input id="productSinglePic" accept="image/*" type="file" name="image">
                                </td>
                                <tr>
                                    <td>
                                        <input name="pid" value="${product.id}" type="hidden">
                                        <input name="type" value="type_single" type="hidden">
                                    </td>
                                </tr>
                                <%--设置了 class="form-control"的表单元素将默认为width="100%"--%>
                                <tr class="submitTR">
                                    <td colspan="2" align="center">
                                        <button id="singleUpload" type="submit" class="btn btn-success">提交</button>
                                        <%--设置button的bootstrap样式--%>
                                    </td>
                                </tr>
                            </table>
                        </form>

                    </div>

                </div>

                <div class="listDataTableDiv">
                    <table class="table table-striped table-bordered table-hover table-condensed">
                        <%--不同的表格风格，hover为表格添加鼠标悬停效果，condensed使表格更加紧凑--%>
                        <thead>
                        <tr class="success">
                            <%--绿色风格（执行成功风格）的tr行    --%>
                            <th>ID</th>
                            <th>产品缩略图</th>
                            <th>删除</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach items="${productImageSingleList}" var="pis">
                            <%--从后端获取category集合，并分别生成表格元素--%>
                            <tr>
                                <td>${pis.id}</td>
                                <td><a title="点击查看原图" href="img/ps_original/${pis.id}.jpg"><img height="40px" src="img/ps_original/${pis.id}.jpg"></a></td>
                                <td><a deleteLink="true" href="admin_productImage_delete?id=${pis.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
                                    <%--deleteLink是在超链接标签中自定义的属性，目的是对删除按钮进行标记，当点击时会进行弹窗确认--%>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </td>

            <td class="addPictureTableTD">
                <div class="panel panel-warning addPictureDiv">
                    <%--bootstrap的panel面板容器，以及容器的风格；addDiv是对该容器的大小进行设置--%>
                    <div class="panel-heading">新增产品 <b class="text-primary">详细</b> 图片</div>
                    <%--面板标题--%>
                    <div class="panel-body">
                        <%--面板体--%>
                        <form method="post" id="uploadDetailForm" action="admin_productImage_add" enctype="multipart/form-data">
                            <table class="addTable">
                                <tr>
                                    <td colspan="2" align="center">请选择本地图片 宽度790为佳</td>
                                </tr>
                                <td>
                                    <input id="productDetailPic" accept="image/*" type="file" name="image">
                                </td>
                                <tr>
                                    <td>
                                        <input name="pid" value="${product.id}" type="hidden">
                                        <input name="type" value="type_detail" type="hidden">
                                    </td>
                                </tr>
                                <%--设置了 class="form-control"的表单元素将默认为width="100%"--%>
                                <tr class="submitTR">
                                    <td colspan="2" align="center">
                                        <button id="detailUpload" type="submit" class="btn btn-success">提交</button>
                                        <%--设置button的bootstrap样式--%>
                                    </td>
                                </tr>
                            </table>
                        </form>

                    </div>

                </div>

                <div class="listDataTableDiv">
                    <table class="table table-striped table-bordered table-hover table-condensed">
                        <%--不同的表格风格，hover为表格添加鼠标悬停效果，condensed使表格更加紧凑--%>
                        <thead>
                        <tr class="success">
                            <%--绿色风格（执行成功风格）的tr行    --%>
                            <th>ID</th>
                            <th>产品缩略图</th>
                            <th>删除</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach items="${productImageDetailList}" var="pid">
                            <%--从后端获取productImage集合，并分别生成表格元素--%>
                            <tr>
                                <td>${pid.id}</td>
                                <td><a title="点击查看原图" href="img/p_detail/${pid.id}.jpg"><img height="40px" src="img/p_detail/${pid.id}.jpg"></a></td>
                                <td><a deleteLink="true" href="admin_productImage_delete?id=${pid.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
                                    <%--deleteLink是在超链接标签中自定义的属性，目的是对删除按钮进行标记，当点击时会进行弹窗确认--%>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </td>
        </tr>
    </table>











</div>

<%@include file="../include/admin/adminFooter.jsp"%>
</body>
</html>
