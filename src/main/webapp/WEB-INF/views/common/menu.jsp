<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<li class=""><a href="javascript:void(0)" class="dropdown-toggle">
    <i class="menu-icon fa fa fa-pencil-square-o"></i> <span
        class="menu-text"> 机构设置 </span> <b class="arrow fa fa-angle-down"></b>
</a> <b class="arrow"></b>
    <ul class="submenu">
        <c:if test="${sessionScope.managerSession.orgType != '小区'}">
            <li class=""><a href="javascript:void(0)"
                            nav-menu="机构设置,社区管理,/adminOrg/sheQuListUI.action"> <i
                    class="menu-icon fa fa-caret-right"></i>社区管理
            </a> <b class="arrow"></b></li>
        </c:if>
        <li class=""><a href="javascript:void(0)"
                        nav-menu="机构设置,小区管理,/adminOrg/xiaoQuListUI.action"> <i
                class="menu-icon fa fa-caret-right"></i>小区管理
        </a> <b class="arrow"></b></li>
        <li class=""><a href="javascript:void(0)"
                        nav-menu="机构设置,业主管理,/ownerListUI.action"> <i
                class="menu-icon fa fa-caret-right"></i>业主管理
        </a> <b class="arrow"></b></li>

    </ul>
</li>

<li class=""><a href="javascript:void(0)" class="dropdown-toggle">
    <i class="menu-icon fa fa fa-pencil-square-o"></i> <span
        class="menu-text"> 信息管理 </span> <b class="arrow fa fa-angle-down"></b>
</a> <b class="arrow"></b>
    <ul class="submenu">
        <c:if test="${sessionScope.managerSession.orgType == null}">
            <li class=""><a href="javascript:void(0)"
                            nav-menu="信息管理,服务阶段设置,/info/stageListUI.action"> <i
                    class="menu-icon fa fa-caret-right"></i>服务阶段设置
            </a> <b class="arrow"></b></li>
        </c:if>
        <li class=""><a href="javascript:void(0)"
                        nav-menu="信息管理,服务列表,/activity/listUI.action"> <i
                class="menu-icon fa fa-caret-right"></i>服务管理
        </a> <b class="arrow"></b></li>

        <li class=""><a href="javascript:void(0)"
                        nav-menu="信息管理,用户列表,/ad/listUI.action"> <i
                class="menu-icon fa fa-caret-right"></i>广告管理
        </a> <b class="arrow"></b></li>

        <li class=""><a href="javascript:void(0)"
                        nav-menu="信息管理,投票信息,/vote/listUI.action"> <i
                class="menu-icon fa fa-caret-right"></i>投票信息
        </a> <b class="arrow"></b></li>

        <li class=""><a href="javascript:void(0)"
                        nav-menu="信息管理,表决管理,/opInfo/listUI.action?type=biaojue"> <i
                class="menu-icon fa fa-caret-right"></i>表决管理
        </a> <b class="arrow"></b></li>

        <li class=""><a href="javascript:void(0)"
                        nav-menu="信息管理,报名管理,/opInfo/listUI.action?type=baoming"> <i
                class="menu-icon fa fa-caret-right"></i>报名管理
        </a> <b class="arrow"></b></li>

        <li class=""><a href="javascript:void(0)"
                        nav-menu="信息管理,意见管理,/opInfo/listUI.action?type=yijian"> <i
                class="menu-icon fa fa-caret-right"></i>意见管理
        </a> <b class="arrow"></b></li>
    </ul>
</li>




