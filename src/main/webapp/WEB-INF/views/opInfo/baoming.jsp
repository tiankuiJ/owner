<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@include file="../common/uploader.jspf" %>
<%--<%@include file="../common/layui.jspf" %>--%>
<div class="row">
    <div class="col-sm-12">
        <h4 class="m-t">
            <button class="btn btn-xs btn-success" type="button" onclick="add()">
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

<!-- modal -->

<script type="text/javascript">
    $("#jsonmap").jqGrid({
        url: sys.rootPath + '/opInfo/list.action?type=报名',
        datatype: "json",
        mtype: "GET",
        colNames: ['ID','','二维码', '项目标题', '发布机构','关联公告',  '浏览量', '添加时间', '操作'],
        colModel: [
            {name: 'id', index: 'id', key: true, width: 1, align: 'center'},
            {name: 'orgId', width: 1, align: 'center',hidden:true},
            {name: 'qrCode', align: 'center',  sortable: false, width: 2,formatter:formatCellImg},
            {name: 'title', sortable: false, width: 2,formatter:formaterTitle},
            {name: 'orgName', index: 'a.org_id', sortable: false, width: 1},
            {name: 'infoName', index: 'title', width: 2, sortable: false},
            {name: 'viewNum', index: 'a.view_num', sortable: true, width: 1,align: 'center'},
            {name: 'createTime', sortable: false, width: 1,align:'center'},
            {name: 'op', index: 'op', sortable: false, align: 'center', width: 1, formatter: formaterOpretion}
        ],
        rowList: [10, 20, 30],
        pager: '#pjmap',
        sortname: 'id',
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
    function formaterOpretion(cellvalue, options, rowdata) {
        var a = '<a href="javascript:void(0)" title="编辑" onclick="editUI(' + rowdata.id + '); "class="tab_a"><i class="ace-icon glyphicon glyphicon-edit"></i></a>&nbsp;&nbsp;' + '<a href="javascript:void(0)" title="删除" onclick="del(\'/opInfo/del.action\',\''+rowdata.infoName+'\','+rowdata.id+')" class="tab_a"><i class="ace-icon glyphicon glyphicon-trash"></i></a>';
        return a;
    }
    function formaterTitle(cellvalue, options, rowdata) {
        var a = '<a href="javascript:void(0)" title="参加记录"  onclick="recoderUI(' + rowdata.id + ');"class="tab_a">'+rowdata.title+'</a>&nbsp;&nbsp;';
        return a;
    }

    function recoderUI(id) {
        localStorage.setItem("oid", id);
        localStorage.setItem("op", "报名");
        localStorage.setItem("from", "baoming");
        loadPage("/regRecord/listUI.action","报名参加记录");
    }


    function editUI(id) {
        localStorage.setItem("opType","报名");
        loadPage("/opInfo/formUI.action?id="+id,"报名详情");
    }

    function add() {
        localStorage.setItem("opType","报名");
        loadPage("/opInfo/formUI.action","添加报名");
    }
    function reloadGrid() {
        $("#jsonmap").trigger("reloadGrid");
    }

    function del(nav, infoTitle,id) {
        if(infoTitle!="null"){
            layer.msg("当前信息已被公告关联，不能删除",{icon:5});
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
                        reloadGrid();
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

