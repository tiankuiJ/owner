<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="zh-cn" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="common/common.jspf"%>
</head>

<body class="no-skin">
<!-- #section:basics/navbar.layout -->
<jsp:include page="common/header.jsp"/>

<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
    <script type="text/javascript">
        try {
            ace.settings.check('main-container', 'fixed')
        } catch (e) {
        }
    </script>

    <!-- #section:basics/sidebar -->
    <div id="sidebar" class="sidebar responsive">
        <script type="text/javascript">
            try {
                ace.settings.check('sidebar', 'fixed')
            } catch (e) {
            }
        </script>

        <ul class="nav nav-list">
            <%@include file="common/menu.jsp"%>

        </ul>
        <!-- /.nav-list -->

        <!-- #section:basics/sidebar.layout.minimize -->
        <div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
            <i class="ace-icon fa fa-angle-double-left"
               data-icon1="ace-icon fa fa-angle-double-left"
               data-icon2="ace-icon fa fa-angle-double-right"></i>
        </div>

        <!-- /section:basics/sidebar.layout.minimize -->
        <script type="text/javascript">
            try {
                ace.settings.check('sidebar', 'collapsed')
            } catch (e) {
            }
        </script>
    </div>

    <!-- /section:basics/sidebar -->
    <div class="main-content">
        <div class="main-content-inner">
            <!-- #section:basics/content.breadcrumbs -->
            <div class="breadcrumbs" id="breadcrumbs">
                <script type="text/javascript">
                    try {
                        ace.settings.check('breadcrumbs', 'fixed')
                    } catch (e) {
                    }
                </script>

                <ul class="breadcrumb">

                </ul>
            </div>

            <!-- #section:settings.box -->
            <div class="ace-settings-container" id="ace-settings-container"
                 style="display: none;">
                <div class="btn btn-app btn-xs btn-warning ace-settings-btn"
                     id="ace-settings-btn">
                    <i class="ace-icon fa fa-cog bigger-130"></i>
                </div>

                <div class="ace-settings-box clearfix" id="ace-settings-box">
                    <div class="pull-left width-50">
                        <!-- #section:settings.skins -->
                        <div class="ace-settings-item">
                            <div class="pull-left">
                                <select id="skin-colorpicker" class="hide">
                                    <option data-skin="no-skin" value="#438EB9">#438EB9</option>
                                    <option data-skin="skin-1" value="#222A2D">#222A2D</option>
                                    <option data-skin="skin-2" value="#C6487E">#C6487E</option>
                                    <option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option>
                                </select>
                            </div>
                            <span>&nbsp; Choose Skin</span>
                        </div>

                        <!-- /section:settings.skins -->

                        <!-- #section:settings.navbar -->
                        <div class="ace-settings-item">
                            <input type="checkbox" class="ace ace-checkbox-2"
                                   id="ace-settings-navbar" /> <label class="lbl"
                                                                      for="ace-settings-navbar"> Fixed Navbar</label>
                        </div>

                        <!-- /section:settings.navbar -->

                        <!-- #section:settings.sidebar -->
                        <div class="ace-settings-item">
                            <input type="checkbox" class="ace ace-checkbox-2"
                                   id="ace-settings-sidebar" /> <label class="lbl"
                                                                       for="ace-settings-sidebar"> Fixed Sidebar</label>
                        </div>

                        <!-- /section:settings.sidebar -->

                        <!-- #section:settings.breadcrumbs -->
                        <div class="ace-settings-item">
                            <input type="checkbox" class="ace ace-checkbox-2"
                                   id="ace-settings-breadcrumbs" /> <label class="lbl"
                                                                           for="ace-settings-breadcrumbs"> Fixed Breadcrumbs</label>
                        </div>

                        <!-- /section:settings.breadcrumbs -->

                        <!-- #section:settings.rtl -->
                        <div class="ace-settings-item">
                            <input type="checkbox" class="ace ace-checkbox-2"
                                   id="ace-settings-rtl" /> <label class="lbl"
                                                                   for="ace-settings-rtl"> Right To Left (rtl)</label>
                        </div>

                        <!-- /section:settings.rtl -->

                        <!-- #section:settings.container -->
                        <div class="ace-settings-item">
                            <input type="checkbox" class="ace ace-checkbox-2"
                                   id="ace-settings-add-container" /> <label class="lbl"
                                                                             for="ace-settings-add-container"> Inside <b>.container</b>
                        </label>
                        </div>

                        <!-- /section:settings.container -->
                    </div>
                    <!-- /.pull-left -->

                    <div class="pull-left width-50">
                        <!-- #section:basics/sidebar.options -->
                        <div class="ace-settings-item">
                            <input type="checkbox" class="ace ace-checkbox-2"
                                   id="ace-settings-hover" /> <label class="lbl"
                                                                     for="ace-settings-hover"> Submenu on Hover</label>
                        </div>

                        <div class="ace-settings-item">
                            <input type="checkbox" class="ace ace-checkbox-2"
                                   id="ace-settings-compact" /> <label class="lbl"
                                                                       for="ace-settings-compact"> Compact Sidebar</label>
                        </div>

                        <div class="ace-settings-item">
                            <input type="checkbox" class="ace ace-checkbox-2"
                                   id="ace-settings-highlight" /> <label class="lbl"
                                                                         for="ace-settings-highlight"> Alt. Active Item</label>
                        </div>

                        <!-- /section:basics/sidebar.options -->
                    </div>
                    <!-- /.pull-left -->
                </div>
                <!-- /.ace-settings-box -->
            </div>
            <!-- /.ace-settings-container -->

            <!-- /section:settings.box -->

            <!-- /section:basics/content.breadcrumbs -->
            <div class="page-content"></div>
            <!-- /.page-content -->
        </div>
    </div>
    <!-- /.main-content -->

   <jsp:include page="common/footer.jsp"/>

    <a href="#" id="btn-scroll-up"
       class="btn-scroll-up btn btn-sm btn-inverse"> <i
            class="ace-icon fa fa-angle-double-up icon-only fa-2x"></i>
    </a>
</div>
<!-- /.main-container -->

<!-- modal -->
<div class="modal fade" id="pswmodal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title">修改密码</h4>
			</div>
			<div class="modal-body">
				<form id="changePassWordForm" name="form" class="form-horizontal" role="form"
					method="post">
					<div class="form-group">
						<label class="control-label col-sm-2 no-padding-right" for="oldPassWord">原密码</label>
						<div class="col-sm-9">
							<div class="clearfix">
								<input class="form-control" name="oldPassWord" id="oldPassWord" type="password"
									placeholder="原密码" />
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2 no-padding-right" for="newPassWord">新密码</label>
						<div class="col-sm-9">
							<div class="clearfix">
								<input class="form-control" name="newPassWord" id="newPassWord" type="password"
									placeholder="新密码" />
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success btn-sm" onclick="javascript:$('#changePassWordForm').submit();">保存</button>
				<button type="button" class="btn btn-info btn-sm" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<script>


</script>
</body>
</html>
