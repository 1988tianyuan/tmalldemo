<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/27
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<html>
<head>
    <!--导入jquery-->
    <script src="//upcdn.b0.upaiyun.com/libs/jquery/jquery-2.0.3.min.js"></script>
    <!--导入bootstrap-->
    <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet"/>
    <!--导入自定义css-->
    <link href="css/back/style.css" rel="stylesheet"/>

    <!--预定义一些通用函数-->
    <script>
        //判断某个表单对象的值是否为空
        function checkEmpty(id, name) {
            var value = $("#"+id).val();
            if(value.length == 0){
                alert(name+"不能为空");
                $("#"+id)[0].focus();
                return false;
            }
            return true;
        }

        //判断某个表单对象的值是否为数字
        function checkNumber(id, name) {
            var value = $("#"+id).val();
            if(!checkEmpty(id, name)){
               return false;
            }
            if(isNaN(value)){
                alert(name+"必须是数字");
                $("#"+id)[0].focus();
                return false
            }
            return true;
        }

        function checkInt(id, name) {
            var value = $("#"+id).val();
            if(!checkEmpty(id, name)){
                return false;
            }
            if(parseInt(value)!=value){
                alert(name+"必须是整数");
                $("#"+id)[0].focus();
                return false
            }
            return true;
        }

        $(function () {
            $("a").click(
                function () {
                    var deleteLink = $(this).attr("deleteLink");
                    if(true == deleteLink){
                        var confirmDelete = confirm("是否确认删除？");
                        if(confirmDelete)return true;
                        return false;
                    }
                }
            );
        })
    </script>
</head>

</html>
