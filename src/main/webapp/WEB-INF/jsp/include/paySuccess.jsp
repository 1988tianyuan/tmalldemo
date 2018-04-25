<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/23
  Time: 22:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<div class="payedDiv">
    <div class="payedTextDiv">
        <img src="img/site/paySuccess.png">
        <span>
            您已成功付款
        </span>
    </div>
    <div class="payedAddressInfo">
        <li>
            地址：${address}
        </li>
        <li>
            实付款：
            <span class="payedInfoPrice">￥${totalCost}</span>
        </li>
        <li>
            预计${prDate}送达
        </li>
    </div>
    <div class="payedCheckLinkDiv">
        您可以
        <a class="payedCheckLink" href="forebought">查看已买到的宝贝</a>
        <a class="payedCheckLink">查看交易详情</a>
    </div>
    <div class="payedSeperateLine"></div>
    <div class="warningDiv">
        <img src="img/site/warning.png">
        <span class="boldWord">安全提醒：</span>
        下单后，
        <span class="boldWord redColor">
            用QQ给您发送链接办理退款的都是骗子！
        </span>
        天猫不存在系统升级，订单异常等问题，谨防假冒客服电话诈骗！
    </div>
</div>
