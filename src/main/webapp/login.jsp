<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>社区后台登录</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/login.css"/>
</head>
<body>

<div class="login_con" >
	<div class="login_content">
		<img src="${ctx}/resources/images/new_icon.png" class="login_icon"/>
		<%--<p>欢迎登录</p>--%>
		<%--<span>社区公共服务系统</span>--%>
		<br />
		<br />
		<div class="userName">
			<img src="${ctx}/resources/images/login_user.png" />
			<input type="text" id="username"  placeholder="请输入登录账号" />
		</div>
		<div class="passWord">
			<img src="${ctx}/resources/images/login_key.png" />
			<input type="password" id="password"  placeholder="请输入登录密码" />
		</div>
		<button class="login_btn" onclick="login()">
			登&nbsp;&nbsp;&nbsp;&nbsp;录
		</button>


	</div>
	<div class="foot">
		<p class="login_bq">Copyright © 吉光信息
			<%--<a href="http://www.kafeikeji.com"> www.kafeikeji.com</a> --%>
		</p>
	</div>
</div>


</body>
<script type="text/javascript"
		src="${ctx}/resources/js/jquery/jquery-2.1.4.min.js"></script>
<!-- layer 弹出层 -->
<script type="text/javascript"
		src="${ctx}/resources/js/layer-v2.1/layer.js"></script>
<script type="text/javascript">
//    var windowScreen = document.documentElement;
//    var main_div = document.getElementById("content");
//    var main_top = (windowScreen.clientHeight - main_div.clientHeight) / 2.4;
//    setTop();
//    $(window).resize(function() {
//        main_top = (windowScreen.clientHeight - main_div.clientHeight) / 2.4;
//        setTop();
//    });
    $(function(){
        //注册回车键事件
        document.onkeypress = function(e){
            var ev = document.all ? window.event : e;
            if(ev.keyCode==13) {
                login();
            }
        };
    });
    function setTop(){
        if(main_top > -73) {
            main_div.style.marginTop = main_top + "px";
        }
    }
    var sys = sys || {};
    sys.rootPath = "${ctx}";
    function login(){
        var username = $("#username").val();
        var password = $("#password").val();
        if(username=="" || password==""){
            $("#span").removeClass("green");
            $("#span").addClass("red");
            $("#span").html("请输入用户名和密码");
            return;
        }
        var index = layer.load(1, {
            shade: [0.1,'#fff']
        });
        $.post(sys.rootPath+"/loginAdmin.action",{account:username,psd:password},function(result){
            layer.close(index);
            if(!result.success){
                layer.msg(result.message,{icon:0});
                return;
            }
            layer.msg(result.message,{icon:1});
            window.location.href=sys.rootPath+"/index.action";
        },"json");

    }
</script>
</html>
