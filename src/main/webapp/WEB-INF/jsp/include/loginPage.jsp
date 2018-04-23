<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/8
  Time: 17:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<script>
    $(function () {

        <c:if test="${!empty msg}">
        $("span.errorMessage").html("${msg}");
        $("div.loginErrorMessageDiv").show();
        </c:if>

        $("form.loginForm").submit(function () {
            var name = $("#name").val();
            var password = $("#password").val();
            if(0 === name.length && 0 === password.length){
                $("div.loginErrorMessageDiv").show();
                $("span.errorMessage").html("请输入账号密码！");
                return false;
            }
            return true;
        })

        $("form.loginForm input").keyup(function () {
            $("div.loginErrorMessageDiv").hide();
        });

    })


</script>

<div id="loginDiv" class="loginDiv">
    <div class="simpleLogo">
        <a href="forehome"><img src="img/site/simpleLogo.png"></a>
    </div>

    <img id="loginBackgroundImg" class="loginBackgroundImg" src="img/site/loginBackground.png">

    <form class="loginForm" method="post" action="login">
        <div class="loginSmallDiv" id="loginSmallDiv">

            <div class="loginErrorMessageDiv">
                <div class="alert alert-danger" >
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
                    <span class="errorMessage"></span>
                </div>
            </div>

            <div class="login_acount_text">账户登录</div>

            <div class="loginInput">
                <span class="loginInputIcon">
                    <span class="glyphicon glyphicon-user"></span>
                </span>
                <input id="name" name="name" placeholder="手机/会员名/邮箱" type="text">
            </div>

            <div class="loginInput">
                <span class="loginInputIcon">
                <span class="glyphicon glyphicon-lock"></span>
            </span>
                <input id="password" name="password" placeholder="密码" type="password">
            </div>

            <span class="text-danger">不要输入真实的天猫账号密码</span><br><br>

            <div>
                <a href="#nowhere" class="notImplementLink">忘记登录密码</a>
                <a href="register.jsp" class="pull-right">免费注册</a>
            </div>

            <div style="margin-top: 20px">
                <button class="btn btn-block redButton loginSubmitButton" type="submit">登录</button>
            </div>

        </div>
    </form>




</div>
