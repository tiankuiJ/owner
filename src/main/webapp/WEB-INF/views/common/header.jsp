<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div id="navbar" class="navbar navbar-default" style="background-color: #4876FF;">
	<script type="text/javascript">
		try {
			ace.settings.check('navbar', 'fixed')
		} catch (e) {
		}
	</script>

	<div class="navbar-container" id="navbar-container">
		<!-- #section:basics/sidebar.mobile.toggle -->
		<button type="button" class="navbar-toggle menu-toggler pull-left"
			id="menu-toggler" data-target="#sidebar">
			<span class="sr-only"></span> <span class="icon-bar"></span> <span
				class="icon-bar"></span> <span class="icon-bar"></span>
		</button>

		<!-- /section:basics/sidebar.mobile.toggle -->
		<div class="navbar-header pull-left">
			<!-- #section:basics/navbar.layout.brand -->
			<a href="#" class="navbar-brand"> <small>
				<img style="float:left;margin-top: -2px;" alt="" src="${ctx }/resources/images/mlogo.png" />
				<div style="float:left;padding-left:10px;margin-top:-5px;">
					<img style="width:76px" alt="" src="${ctx }/resources/images/mlogo2.png" />
					<span style="font-size:10px;"></span>
					<p style="font-size:10px;color:white;margin-top:-1px;margin-bottom:0px;">欢迎登录<span style="color:#FFFF00;">
						<%--<c:if test="${!empty userSession.siteName }"> ${userSession.siteName } </c:if></span>--%>
						社区公共服务管理系统</p>
				</div>
			</small>
			</a>

			<!-- /section:basics/navbar.layout.brand -->

			<!-- #section:basics/navbar.toggle -->

			<!-- /section:basics/navbar.toggle -->
		</div>
		<!-- #section:basics/navbar.dropdown -->
		<div class="navbar-buttons navbar-header pull-right" role="navigation">
			<ul class="nav ace-nav">
				
				<li class="light-blue">
					<a href="#"> 
						<i class="ace-icon fa fa-user"></i><c:if test="${empty sessionScope.managerSession.orgType }">系统管理员</c:if>
						<c:if test="${not empty sessionScope.managerSession.orgType }">${sessionScope.managerSession.orgType}管理员</c:if>
					</a>
				</li>
				<li class="light-blue">
					<a data-toggle="modal" href="#pswmodal"> <i
							class="ace-icon fa fa-cog"></i> 修改密码
					</a>
				</li>
				<li class="light-blue">
					<a href="${ctx}/logoutAdmmin.action"> <i
							class="ace-icon fa fa-power-off"></i> 退出
					</a>
				</li>
				<!-- /section:basics/navbar.user_menu -->
			</ul>
		</div>

		<!-- /section:basics/navbar.dropdown -->
	</div>
	<!-- /.navbar-container -->
</div>
