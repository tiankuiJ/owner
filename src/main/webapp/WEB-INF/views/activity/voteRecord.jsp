<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@include file="../common/uploader.jspf" %>
<%@include file="../common/layui.jspf" %>
<div class="row">
    <div class="col-sm-12">
        <h4 class="m-t">
            <button class="btn-sm  btn_ col-xs-1" type="button" onclick="backInfo()">
                <i class="ace-icon glyphicon glyphicon-backward"></i>返回列表
            </button>
            <button class="btn-sm  btn_ col-xs-1" type="button" onclick="resultUI()">
                <i class="ace-icon fa fa-sort-amount-asc"></i>投票结果
            </button>
            <%--<label class="col-xs-8" style="padding-top: 7px;"> 参加业主总面积:<font color="red" id="sum">0</font></label>--%>
            <%--<div class="col-xs-3">--%>
                <%--<input class="col-xs-9" type="text" id="searchInput"--%>
                       <%--placeholder="手机号码、姓名" style="height: 32px;">--%>
                <%--<button class="btn btn-sm btn_" type="button" onclick="searchStr()">--%>
                    <%--<i class="ace-icon glyphicon glyphicon-search"></i>查询--%>
                <%--</button>--%>
            <%--</div>--%>

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
        <%--<div id="biaojueDiv" hidden="hidden">--%>
            <%--同意业主总面积:<font color="red" id="agreen">0</font><br/>--%>
            <%--反对业主总面积:<font color="red" id="reject">0</font><br/>--%>
            <%--弃权业主总面积:<font color="red" id="giveUp">0</font>--%>
        <%--</div>--%>
    </div>


</div>

<%--<div class="modal fade" id="dialog"  role="dialog"--%>
     <%--aria-labelledby="myModalLabel" aria-hidden="true">--%>
    <%--<div class="modal-dialog">--%>
        <%--<div class="modal-content">--%>
            <%--<div class="modal-header">--%>
                <%--<button type="button" class="close" data-dismiss="modal">--%>
                    <%--<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>--%>
                <%--</button>--%>
                <%--<h4 class="modal-title">详情</h4>--%>
            <%--</div>--%>
            <%--<div class="modal-body">--%>
                <%--<div class="col-sm-12" style="margin-top: 10px;margin-bottom: 10px;">--%>
                    <%--<label class="col-sm-2">详情:</label>--%>
                    <%--<label class="col-sm-10" id="logContent"></label>--%>
                <%--</div>--%>
                <%--<div class="col-sm-12" style="margin-top: 10px;margin-bottom: 10px;">--%>
                    <%--<label class="col-sm-2">图片:</label>--%>
                    <%--<div class="col-sm-12" id="imgDiv" style="overflow-y: auto;">--%>

                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="modal-footer">--%>
                    <%--<button type="button" class="btn btn-info btn-sm" data-dismiss="modal">--%>
                        <%--关闭--%>
                    <%--</button>--%>
                <%--</div>--%>

            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>
<script type="text/javascript">

    function backInfo() {
        if(localStorage.getItem("from")=="info"){
            loadPage("/info/listUI.action","公告列表");
        }else{
            loadPage("/vote/listUI.action","投票信息");
        }
    }

    function resultUI() {
        loadPage("/regRecord/resultUI.action?voteId="+localStorage.getItem("oid"),"投票结果");
    }
    $("#jsonmap").jqGrid({
        url: sys.rootPath + '/regRecord/selectVoteRecordList.action?voteId='+localStorage.getItem("oid"),
        datatype: "json",
        mtype: "GET",
        rownumbers:true,
        colNames: [ '候选名称', '候选图片', '同意票数', '反对票数',  '弃权票数', '同意业主面积','反对业主面积','弃权业主面积'],
        colModel: [
            {name: 'name', sortable: false, width: 2},
            {name: 'img',  sortable: false, width: 2,align: 'center',formatter:formaterImg},
            {name: 'countAgreen',index:"countAgreen", sortable: true, width: 1,align: 'center'},
            {name: 'countReject',index:"countReject", sortable: true, width: 1,align: 'center'},
            {name: 'countGiveUp',index:"countGiveUp", sortable: true, width: 1,align: 'center'},
            {name: 'sumAgreen',index:"sumAgreen", sortable: true, width: 1,align: 'center'},
            {name: 'sumReject',index:"sumReject", sortable: true, width: 1,align: 'center'},
            {name: 'sumGiveUp',index:"sumGiveUp", sortable: true, width: 1,align: 'center'},
        ],
        rowList: [10, 20, 30],
        pager: '#pjmap',
        sortname: 'countAgreen',
        viewrecords: true,
        sortorder: "desc",
        jsonReader: {
            repeatitems: false,
            id: "0"
        },
        height: '100%',
        autowidth: true,
        multiselect: false,
        page: $("#g_page").val(),
        rowNum: $("#g_rows").val()
    });
    $("#jsonmap").jqGrid('navGrid', '#pjmap', {edit: false, add: false, del: false, search: false});



</script>

