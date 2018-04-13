<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/8
  Time: 11:19
  To change this template use File | Settings | File Templates.
--%>

<html>
<head>
    <title>注册账号</title>
    <script src="js/jquery/2.0.0/jquery.min.js"></script>
    <script>
        $(function () {
            var isPsdEqual = false;

            var psdPermit = function () {
                var password = $("#password").val();
                var psdConfirm = $("#psdConfirm").val();
                if(psdConfirm === password){
                    $("#confirm").attr("class", "glyphicon glyphicon-ok").show();
                    isPsdEqual = true;
                }else {
                    $("#confirm").attr("class", "glyphicon glyphicon-remove").show();
                    isPsdEqual = false;
                }
                if("" === psdConfirm){
                    $("#confirm").hide();
                    isPsdEqual = false;
                }
                if(isPsdEqual){
                    $("#submit").removeAttr("disabled").attr("class", "registerPermit");
                }else {
                    $("#submit").attr("disabled","disabled").attr("class", "registerReject");
                }
            }

            $("#psdConfirm").keyup(
                function () {
                    psdPermit();
                }
            )

            $("#password").keyup(
                function () {
                    psdPermit();
                }
            )

        })
    </script>
</head>
<body>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp"%>
<%@include file="../include/top.jsp"%>
<%@include file="../include/simpleSearch.jsp"%>

<div class="registerDiv">
    <form action="registerConfirm" method="post" class="registerForm">
        <table class="registerTable" align="center">
            <tr>
                <td class="registerTip">设置会员名</td>
            </tr>
            <tr>
                <td class="registerTableLeftTD"><span>登录名</span></td>
                <td class="registerTableRightTD"><input id="name" name="name" placeholder="会员名一旦设置成功，无法修改" value=""></td>
            </tr>
            <tr>
                <td class="registerTableLeftTD" style="font-weight: bold"><span>设置登录密码</span></td>
                <td class="registerTableRightTD"><span>登录时验证，保护账号信息</span></td>
            </tr>
            <tr>
                <td class="registerTableLeftTD"><span>登录密码</span></td>
                <td class="registerTableRightTD"><input id="password" name="password" placeholder="设置你的登录密码" type="password"></td>
            </tr>
            <tr>
                <td class="registerTableLeftTD"><span>密码确认</span></td>
                <td class="registerTableRightTD"><input id="psdConfirm" placeholder="请再次输入你的登录密码" type="password"><span id="confirm" class="glyphicon glyphicon-ok" style="display: none" ></span></td>
            </tr>
            <tr>
                <td colspan="2" class="registerButtonTD">
                    <button id="submit" class="registerReject" disabled="disabled">提交</button>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <c:if test="${!empty msg}">
                        <span style="background: #A4A4A4; color: #C40000">${msg}</span>
                    </c:if>
                </td>
            </tr>
        </table>
    </form>
</div>


<%@include file="../include/footer.jsp"%>
</body>
</html>
