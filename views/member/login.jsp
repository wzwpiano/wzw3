
<%@page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>韩顺平教育-家居网购</title>
     <!--为了确定页面资源使用一个固定的参考路径 这里设置base 后面再优化...-->
    <%--http://localhost:8080/jiaju_mall/--%>
    <base href="<%=request.getContextPath()+"/"%>>">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="stylesheet" href="assets/css/vendor/vendor.min.css"/>
    <link rel="stylesheet" href="assets/css/plugins/plugins.min.css"/>
    <link rel="stylesheet" href="assets/css/style.min.css"/>
    <script type="text/javascript" src="script/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(function (){//页面加载完毕后执行function
            $("#registerUsername").blur(function (){
                var username = this.value;
                // 发出ajax请求
                // $.getJSON(url,data,success)
                $.getJSON("registerServlet",
                    "action=isExistUserName&username="+username,
                    function (data){
                    console.log("data= ",data.isExist)
                        if (data.isExist){
                            $("span.errorMsg").text("用户名重复..")
                        }else {
                            $("span.errorMsg").text("")
                        }
                })
                // $.getJSON("registerServlet",
                //     {"action":"isExistUserName",
                //     "username=":username},
                //     function (data){
                //         console.log("data= ",data)
                //     })
            })

            //验证码提示信息
            $("#code").blur(function (){
                var codeVal = this.value;
                $.getJSON("registerServlet","action=isCorrectCode&code="+codeVal,
                function (data){
                    console.log("data="+data.isCorrectCode)
                    if (data.isCorrectCode==false){
                    $("#codePoint").val("验证码错误")
                    }else {
                        $("#codePoint").val("")
                    }
                })
            })

            if ("${requestScope.active}"=="register"){
                $("#register_tab")[0].click();//模拟点击
            }
            //绑定点击事件
            $("#sub-btn").click(function (){
                // alert($("#username").val()
                var usernameVal = $("#username").val();
                // 编写正则表达式来进行验证
                var usernamePattern=/^\w{6,10}$/;
                if (!usernamePattern.test(usernameVal)){
                    $("span[class='errorMsg']").text("用户名格式不正确，需要6~10字符");
                    return false;//不提交，返回false
                }
                //完成对密码的校验
                var passwordVal = $("#password").val();
                var passwordPattern=/\w{6,10}/;
                if (!passwordPattern.test(passwordVal)){
                    $("span.errorMsg").text("密码格式不正确，需要在6-10个数字或英文");
                    return false;
                }
                var repwdVal = $("#repwd").val();
              if (repwdVal!==passwordVal) {
                  $("span.errorMsg").text("两次密码不相同");
                  return false;
              }
              //验证邮箱
                var emailVal = $("#email").val();
              var emailPattern=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
                if (!emailPattern.test(emailVal)){
                    $("span.errorMsg").text("邮箱格式不正确");
                    return false;
                }

                var codeVal = $("#code").val();
                var codeText = $.trim(codeVal);
                var codePattern=/[0-9a-zA-Z]{5}/;
                if (codeText==null||codeText==""){
                    $("span.errorMsg").text("验证码不能为空...")
                    return false;
                }
                if (!codePattern.test(codeText)){
                    $("span.errorMsg").text("验证码格式不正确...")
                    return false;
                }


                return true;//写了后台 设置为true 提交
            })

            $("#Login").click(function (){
                var user_nameVal = $("#user-name").val();
                var valPattern=/^\w{6,10}$/;
                var user_passwordVal = $("#user-password").val();

                if (!valPattern.test(user_nameVal)){
                    $("span.errorMsg1").text("用户名需要在6-10个数字或英文字母")
                    return false;
                }
                if (!valPattern.test(user_passwordVal)){
                    $("span.errorMsg1").text("密码需要在6-10个数字或英文字母")
                    return false;
                }

                return true;//验证通过

            })

            //对验证码绑定一个点击刷新事件
            $("#codImg").click(function (){
                // alert("xxx")
                //在url没有变化的时候图片不会发出新的请求
                //为了防止不请求可以时携带一个变化的参数
               $(this).attr("src","<%=request.getContextPath()%>/kaptchaServlet?date="+new Date());
            })

        })
    </script>
</head>

<body>
<!-- Header Area start  -->
<div class="header section">
    <!-- Header Top Message Start -->
    <!-- Header Top  End -->
    <!-- Header Bottom  Start -->
    <div class="header-bottom d-none d-lg-block">
        <div class="container position-relative">
            <div class="row align-self-center">
                <!-- Header Logo Start -->
                <div class="col-auto align-self-center">
                    <div class="header-logo">
                        <a href="index.html"><img src="assets/images/logo/logo.png" alt="Site Logo"/></a>
                    </div>
                </div>
                <!-- Header Logo End -->
            </div>
        </div>
    </div>
    <!-- Header Bottom  Start 手机端的header -->
    <div class="header-bottom d-lg-none sticky-nav bg-white">
        <div class="container position-relative">
            <div class="row align-self-center">
                <!-- Header Logo Start -->
                <div class="col-auto align-self-center">
                    <div class="header-logo">
                        <a href="index.html"><img width="280px" src="assets/images/logo/logo.png" alt="Site Logo" /></a>
                    </div>
                </div>
                <!-- Header Logo End -->
            </div>
        </div>
    </div>
    <!-- Main Menu Start -->
    <div style="width: 100%;height: 50px;background-color: black"></div>
    <!-- Main Menu End -->
</div>
<!-- Header Area End  -->
<!-- login area start -->
<div class="login-register-area pt-70px pb-100px">
    <div class="container">
        <div class="row">
            <div class="col-lg-7 col-md-12 ml-auto mr-auto">
                <div class="login-register-wrapper">
                    <div class="login-register-tab-list nav">
                        <a class="active" data-bs-toggle="tab" href="#lg1">
                            <h4>会员登录</h4>
                        </a>
                        <a id="register_tab" data-bs-toggle="tab" href="#lg2">
                            <h4>会员注册</h4>
                        </a>
                    </div>
                    <div class="tab-content">
                        <div id="lg1" class="tab-pane active">
                            <div class="login-form-container">
                                <div class="login-register-form">
                                    <span class="errorMsg1"
                                          style="float: right; font-weight: bold; font-size: 20pt; margin-left: 10px;color:gainsboro">${requestScope.error}</span>
                                    <!--因为前面有base标签 所以这里可用loginServlet-->
                                    <form action="registerServlet" method="post">
                                        <%--增加隐藏域表示登陆请求--%>
                                        <input type="hidden"name="action" value="login">
                                        <input type="text" name="user-name" placeholder="Username" id="user-name" value="${requestScope.username}"/>
                                        <input type="password" name="user-password" placeholder="Password" id="user-password" />
                                        <div class="button-box">
                                            <div class="login-toggle-btn">
                                                <input type="checkbox"/>
                                                <a class="flote-none" href="javascript:void(0)">Remember me</a>
                                                <a href="#">Forgot Password?</a>
                                            </div>
                                            <button type="submit" id="Login"><span>Login</span></button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div id="lg2" class="tab-pane">
                            <div class="login-form-container">
                                <div class="login-register-form">
                                    <span class="errorMsg"
                                          style="float: right; font-weight: bold; font-size: 20pt; margin-left: 10px; color: darkgray">${requestScope.errorMsg}</span>
                                    <form action="registerServlet" method="post">
                                        <%--增加隐藏域表示注册请求--%>
                                        <input type="hidden"name="action" value="register">
                                        <input id="registerUsername" type="text" id="username" name="username" placeholder="Username" value="${requestScope.username}"/>
                                        <input type="password" id="password" name="password" placeholder="输入密码"/>
                                        <input type="password" id="repwd" name="repassword" placeholder="确认密码"/>
                                        <input name="email" id="email" placeholder="电子邮件" type="email" value="${requestScope.password}"/>
                                        <input type="text" id="code" name="code" style="width: 50%"
                                               placeholder="验证码"/>　　<img id="codImg" title="点击刷新验证码" style="height: 50px; width: 100px" alt="" src="kaptchaServlet">
                                       <input type="text" style="width: 20%; border-width: 0 " id="codePoint" disabled >
                                        <div class="button-box">
                                            <button type="submit" id="sub-btn"><span>会员注册</span></button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- login area end -->

<!-- Footer Area Start -->
<div class="footer-area">
    <div class="footer-container">
        <div class="footer-top">
            <div class="container">
                <div class="row">
                    <!-- Start single blog -->
                    <!-- End single blog -->
                    <!-- Start single blog -->
                    <div class="col-md-6 col-sm-6 col-lg-3 mb-md-30px mb-lm-30px" data-aos="fade-up"
                         data-aos-delay="400">
                        <div class="single-wedge">
                            <h4 class="footer-herading">信息</h4>
                            <div class="footer-links">
                                <div class="footer-row">
                                    <ul class="align-items-center">
                                        <li class="li"><a class="single-link" href="about.html">关于我们</a></li>
                                        <li class="li"><a class="single-link" href="#">交货信息</a></li>
                                        <li class="li"><a class="single-link" href="privacy-policy.html">隐私与政策</a></li>
                                        <li class="li"><a class="single-link" href="#">条款和条件</a></li>
                                        <li class="li"><a class="single-link" href="#">制造</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End single blog -->
                    <!-- Start single blog -->
                    <div class="col-md-6 col-lg-2 col-sm-6 mb-lm-30px" data-aos="fade-up" data-aos-delay="600">
                        <div class="single-wedge">
                            <h4 class="footer-herading">我的账号</h4>
                            <div class="footer-links">
                                <div class="footer-row">
                                    <ul class="align-items-center">
                                        <li class="li"><a class="single-link" href="my-account.html">我的账号</a>
                                        </li>
                                        <li class="li"><a class="single-link" href="cart.html">我的购物车</a></li>
                                        <li class="li"><a class="single-link" href="login.jsp">登录</a></li>
                                        <li class="li"><a class="single-link" href="wishlist.html">感兴趣的</a></li>
                                        <li class="li"><a class="single-link" href="checkout.html">结账</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End single blog -->
                    <!-- Start single blog -->
                    <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="800">

                    </div>
                    <!-- End single blog -->
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <div class="container">
                <div class="row flex-sm-row-reverse">
                    <div class="col-md-6 text-right">
                        <div class="payment-link">
                            <img src="#" alt="">
                        </div>
                    </div>
                    <div class="col-md-6 text-left">
                        <p class="copy-text">Copyright &copy; 2021 韩顺平教育~</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Footer Area End -->
<script src="assets/js/vendor/vendor.min.js"></script>
<script src="assets/js/plugins/plugins.min.js"></script>
<!-- Main Js -->
<script src="assets/js/main.js"></script>
</body>
</html>