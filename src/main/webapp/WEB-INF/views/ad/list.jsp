<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="row">
	<div class="col-sm-12">
		<h4 class="m-t">
				<button class="btn btn-xs btn-success" type="button" onclick="loadPage('/ad/formUI.action','添加')">
					<i class="ace-icon fa fa-plus"></i> 添加
				</button>
		</h4>
		<div class="jqGrid_wrapper">
			<table id="jsonmap"></table>
			<div id="pjmap"></div>
		</div>
	</div>
</div>

<%-- <shiro:hasPermission name="admin:ad:update"> --%>
	<input type="hidden" id="updateFlag" />
<%-- </shiro:hasPermission> --%>
<%-- <shiro:hasPermission name="admin:ad:delete"> --%>
	<input type="hidden" id="delFlag" />
<%-- </shiro:hasPermission> --%>
<script type="text/javascript">
    $("#jsonmap").jqGrid({
        url:sys.rootPath+'/ad/list.action',
        datatype: "json",
        mtype:"GET",
        colNames:['ID','封面图','标题','位置','开始时间','结束时间','排序','操作'],
        colModel:[
            {name:'id',index:'id',hidden:true},
            {name:'img',sortable:false,width:2,formatter:formaterImg,align:'center'},
            {name:'title',sortable:false,width:3},
            {name:'position',index:"position",width:2,align:'center'},
            {name:'startTime',sortable:false,width:2,align:'center'},
            {name:'endTime',sortable:false,width:2,align:'center'},
            {name:'weight',sortable:false,width:1,align:'center'},
            {name:'op',index:'op',sortable:false,align:'center',width:2,formatter:function(cellvalue,options,rowObject){
                var html = '';
                if($("#updateFlag").val()!=undefined)
//   				html += '&nbsp;&nbsp;<a href="javascript:void(0)" onclick="loadPage(\'/adminAd/editUI.action?id='+rowObject.id+'\',\'详情\')" class="tab_a">[详情]</a>';
                    html += '&nbsp;&nbsp;<a href="javascript:void(0)" title="编辑" onclick="loadPage(\'/ad/formUI.action?id='+rowObject.id+'\',\'详情\')" class="tab_a"><i class="ace-icon glyphicon glyphicon-edit"></i></button>';
                if($("#delFlag").val()!=undefined)
//   				html += '&nbsp;&nbsp;<a href="javascript:void(0)" onclick="delModel(\'/adminAd/del.action\',reloadGrid,'+rowObject.id+')" class="tab_a">[删除]</a>';
                    html += '&nbsp;&nbsp;<a href="javascript:void(0)"  title="删除" onclick="delModel(\'/ad/del.action\',reloadGrid,'+rowObject.id+')" class="tab_a"><i class="ace-icon glyphicon glyphicon-trash"></i></button>';
                return html;
            }}
        ],
        rowList:[10,20,30],
        pager: '#pjmap',
        rownumbers: true,
        sortname: 'id',
        viewrecords: true,
        sortorder: "desc",
        jsonReader: {
            repeatitems : false,
            id: "0"
        },
        height: '100%',
        autowidth:true,
        multiselect:false,
        page:$("#g_page").val(),
        rowNum:$("#g_rows").val()
    });
    $("#jsonmap").jqGrid('navGrid','#pjmap',{edit:false,add:false,del:false,search:false});

    function reloadGrid(){
        $("#jsonmap").trigger("reloadGrid");
    }
</script>
