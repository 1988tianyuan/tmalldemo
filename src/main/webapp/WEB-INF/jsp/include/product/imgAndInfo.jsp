<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/8
  Time: 22:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<script>
    $(function () {
        //鼠标移到每个小图上后，获取小图元素中保存的对应大图的url然后将大图的src进行切换
        $("img.smallImage").mouseenter(function () {
            var bigImgURL = $(this).attr("bigImgURL");

            $("img.bigImg").attr("src", bigImgURL);
        })

        //大图可能比较大，所以需要预加载
        $("img.bigImg").load(function () {
            //取出每个小图元素,预先将大图资源加载出来放到隐藏的img4load中
            $("img.smallImage").each(function () {
                var bigImgURL = $(this).attr("bigImgURL");
                img = new Image();
                img.src = bigImgURL;
                img.onload = function () {
                    console.log(bigImgURL);
                    $("div.img4load").append($(img));
                }
            })
        })

        //对购买数量输入框中的值进行处理和过滤，数量只能为整数，且有最大最小值
        var stock = ${product.stock};
        $("a.increaseNumber").click(function () {
            var number = $("input.productNumberSetting").val();
            number++;
            if(number > stock){
                number = stock;
            }
            $("input.productNumberSetting").val(number);
        })
        $("a.decreaseNumber").click(function () {
            var number = $("input.productNumberSetting").val();
            number--;
            if(number < 1){
                number = 1;
            }
            $("input.productNumberSetting").val(number);
        })
        $("input.productNumberSetting").keyup(function () {
            var number = $("input.productNumberSetting").val();
            number = parseInt(number);
            if(isNaN(number)){
                number = 1;
            }
            if(number > stock){
                number = stock;
            }
            if(number < 1){
                number = 1;
            }
            $("input.productNumberSetting").val(number);
        })

        //点击购买按钮，进行ajax登录验证，若后端判断未登录则弹出模态登录窗口
        $("button.buyButton").click(function () {
            var page = "foreLoginCheck";
            $.get(
                page, function (result) {
                    if("success" === result){
                        var pid = ${product.id};
                        var num = $("input.productNumberSetting").val();
                        location.href = "immeBuy?pid="+pid+"&number="+num;
                    }else {
                        $("#loginModal").modal("show");
                    }
                }
            )
        })

        //点击加入购物车按钮，进行ajax登录验证，若后端判断未登录则弹出模态登录窗口
        $("button.addCartButton").click(function () {
            var page = "foreLoginCheck";
            $.get(
                page, function (result) {
                    if("success" === result){
                        alert("哈哈哈 傻逼 骗你的！");
                    }else {
                        $("#loginModal").modal("show");
                    }
                }
            )
        })

        //在模态登录窗口进行点击登录验证，验证失败则打开错误提示栏，提示相关错误信息
        $("button.loginSubmitButton").click(function () {
            var name = $("input#name").val();
            var password = $("input#password").val();
            var page = "modalLogin";
            if("" === name || "" === password){
                $("span.errorMessage").html("账号密码不能为空！");
                $("div.loginErrorMessageDiv").show();
                return;
            }
            $.ajax({
                url:page, data:{"name":name,"password":password},type:"post",
                success:function (result) {
                    if("success" === result){
                        window.location.reload();
                    }else {
                        $("span.errorMessage").html("用户名或密码错误！");
                        $("div.loginErrorMessageDiv").show();
                    }
                }
            })
        })

        //重新输入信息时，马上隐藏错误提示栏
        $("div.loginDivInProductPage input").keyup(function () {
            $("div.loginErrorMessageDiv").hide();
        });


    })
</script>



<div class="imgAndInfo">
    <div class="imgInimgAndInfo">
        <img src="img/ps_middle/${product.productFirstImage.id}.jpg" class="bigImg">
        <div class="smallImageDiv">
            <c:forEach items="${product.productSingleImages}"   var="singleImage" >
                <img src="img/ps_small/${singleImage.id}.jpg" class="smallImage" bigImgURL = "img/ps_middle/${singleImage.id}.jpg">
            </c:forEach>
        </div>
        <div class="img4load hidden"></div>
    </div>

    <div class="infoInimgAndInfo">
        <div class="productTitle">${product.name}</div>
        <div class="productSubTitle">${product.subTitle}</div>
        <div class="juhuasuan">
            <span class="juhuasuanBig">聚划算</span>
            <span>此商品即将参加聚划算，<span class="juhuasuanTime">1天19小时</span>后开始，</span>
        </div>
        <div class="productPriceDiv">
            <div class="gouwujuanDiv"><img height="16px" src="http://how2j.cn/tmall/img/site/gouwujuan.png">
                <span> 全天猫实物商品通用</span>
            </div>
            <div class="originalDiv">
                <span class="originalPriceDesc">价格</span>
                <span class="originalPriceYuan">￥</span>
                <span class="originalPrice">${product.originalPrice}</span>
            </div>
            <div>
                <span class="promotionPriceDesc">促销价</span>
                <span class="promotionPriceYuan">￥</span>
                <span class="promotionPrice">${product.promotePrice}</span>
            </div>
        </div>

        <div class="productSaleAndReviewNumber">
            <div><span>销量 </span><span class="redColor boldWord">${product.saleCount}</span></div>
            <div>累计评价 <span class="redColor boldWord">${product.reviewCount}</span></div>
        </div>

        <div class="productNumber">
            <span>数量</span>
            <span>
                <span class="productNumberSettingSpan">
                    <input class="productNumberSetting" type="text" value="1">
                </span>
                <span class="arrow">
                    <a class="increaseNumber" href="#nowhere">
                        <span class="updown">
                            <img src="img/site/increase.png">
                        </span>
                    </a>
                    <span class="updownMiddle"></span>
                    <a class="decreaseNumber" href="#nowhere">
                        <span class="updown">
                            <img src="img/site/decrease.png">
                        </span>
                    </a>
                </span>
                件
            </span>
            <span>库存${product.stock}件</span>
        </div>

        <div class="serviceCommitment">
            <span class="serviceCommitmentDesc">服务承诺</span>
            <span class="serviceCommitmentLink">
                <a href="#nowhere">正品保证</a>
                <a href="#nowhere">极速退款</a>
                <a href="#nowhere">赠运费险</a>
                <a href="#nowhere">七天无理由退换</a>
            </span>
        </div>

        <div class="buyDiv">
            <button class="buyButton">立即购买</button>
            <button class="addCartButton"><span class="glyphicon glyphicon-shopping-cart"></span>加入购物车</button>
        </div>

    </div>

    <div style="clear: both"></div>
</div>








