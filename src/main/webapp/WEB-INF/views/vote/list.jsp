<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%--<%@include file="../common/combotree.jspf"%>--%>
<%--<%@include file="../push/downPushCommon.jsp"%>--%>

<div class="row">
    <div class="col-sm-12">
        <h4 class="m-t">
                <button class="btn btn-xs btn-success" type="button" onclick="loadPage('/vote/formUI.action','添加投票信息')">
                    <i class="ace-icon glyphicon glyphicon-plus"></i>添加
                </button>

            <div style="float: right;padding-right: 3px;">
                <input class="col-xs-8" type="text" id="searchInput"
                       placeholder="关键字搜索" style="height: 32px;">
                <button class="btn btn-sm btn_" onclick="searchStr()" type="button">
                    <i class="ace-icon glyphicon glyphicon-search"></i>查询
                </button>
            </div>
        </h4>
        <div class="jqGrid_wrapper">
            <table id="jsonmap"></table>
            <div id="pjmap"></div>
        </div>
    </div>
</div>
<script type="text/javascript">
    /**
     * Created by Administrator on 2017/3/20.
     */
    var selectId;
    $("#jsonmap").jqGrid({
        url: sys.rootPath + '/vote/list.action',
        datatype: "json",
        mtype: "GET",
        colNames: ['ID','pid','orgId','二维码', '投票标题','关联公告', '是否显示排名', '是否显示票数', '每人最多票数', '发布机构',  '创建时间',"操作"],
        colModel: [
            {name: 'id', index: 'id', width: 1,hidden:true, align: 'center'},
            {name:'pId',index:'activityPid',hidden:true},
            {name: 'orgId', index: 'activityPid', hidden: true},
            {name: 'qrCode', align: 'center',  sortable: false, width: 2,formatter:formatCellImg},
            {name: 'title', index: 'title', width: 3, sortable: false,formatter:formaterTitle},
            {name: 'infoName', index: 'title', width: 2, sortable: false},
            {name: 'showRank', index: 'a.show_rank', width: 1, sortable: false,editable : false,align:'center'},
            {name: 'showNum', index: 'a.show_num', width: 1,  align: "center"},
            {name: 'maxUserVote', index: 'a.max_user_vote', width: 1, align: 'center'},
            {name: 'orgName', index: 'a.org_id', width: 2},
            {name: 'createTime', index: 'a.create_time', width: 2,align:'center'},
            // {name: 'status', index: 'status', width: 1, align: 'center'},
            {name: 'opretion', index: 'opretion', width: 1, formatter: formaterOpretion,align:'center'},
        ],
        rowNum: 10,
        rowList: [10, 20, 30],
        pager: '#pjmap',
//        multiselect: true,
        multiboxonly: true,
        sortname: 'id',
        viewrecords: true,
        sortorder: "desc",
        jsonReader: {
            repeatitems: false,
            id: "0"
        },
        height: '100%',
        autowidth: true
    });

    $("#jsonmap").jqGrid('navGrid', '#pjmap', {edit: false, add: false, del: false, search: false});




    function editUI(id) {
        loadPage("/adminVoteInfo/editUI.xhtml?id="+id,"投票详情");
    }
    function editUI(id) {
       loadPage("/vote/formUI.action?id="+id)
    }

    function formaterOpretion(cellvalue, options, rowdata) {
        var a = '<a href="javascript:void(0)" title="编辑"  onclick="editUI(' + rowdata.id + ');"class="tab_a"><i class="ace-icon glyphicon glyphicon-edit"></i></a>&nbsp;&nbsp;';
        a+='<a href="javascript:void(0)"  title="删除"  onclick="del(\'/vote/del.action\',\''+rowdata.infoName+'\','+rowdata.id+')" class="tab_a"><i class="ace-icon glyphicon glyphicon-trash"></i></a>';
        return a;
    }

    function formaterTitle(cellvalue, options, rowdata) {
        var a = '<a href="javascript:void(0)" title="参加记录"  onclick="recoderUI(' + rowdata.id + ');"class="tab_a">'+rowdata.title+'</a>&nbsp;&nbsp;';
        return a;
    }

    function recoderUI(id) {
        localStorage.setItem("oid", id);
        localStorage.setItem("from", "vote");
        loadPage("/regRecord/voteRecordListUI.action","投票参加记录");
    }



    function del(nav, title,id) {
        if(title!="null"){
            layer.msg("当前投票信息已被公告关联，不能删除",{icon:5});
            return;
        }
        layer.confirm('确认删除吗？', {icon:3,title:'删除提示'},function(index, layero) {
            $.ajax({
                type : "POST",
                url : sys.rootPath + nav,
                data : {
                    "id":id
                },
                dataType : "json",
                success : function(resultdata) {
                    if (resultdata.success) {
                        layer.msg(resultdata.message,{icon:1});
                        $("#jsonmap").trigger("reloadGrid");
                    } else {
                        layer.msg(resultdata.message,{icon:5});
                    }
                },
                error : function(data,errorMsg) {
                    layer.msg('服务器未响应,请稍后再试',{icon:3});
                }
            });
            layer.close(index);
        });
    }




</script>
