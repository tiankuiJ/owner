<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../common/combotree.jspf" %>
<div class="row">
    <div class="col-sm-12">
        <h4 class="m-t">
            <c:if test="${sessionScope.managerSession.orgType == null}">
                <button class="btn btn-xs btn-success" type="button" onclick="add()">
                    <i class="ace-icon glyphicon glyphicon-plus"></i>添加
                </button>
            </c:if>
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
<div class="modal fade" id="infoModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                </button>
                <h4 class="modal-title">保存</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="infoForm">
                    <input name="id" id="id" type="hidden">

                    <input name="type" value="社区"  type="hidden">
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="userName">名称*</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <input type="text" name="name" id="name" class="form-control" />
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="passWord">电话*</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <input type="text" name="tel" id="tel" class="form-control" />
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right"
                               for="areaId">地区</label>
                        <div class="col-sm-3">
                            <input name="area" type="hidden" id="area">
                            <div class="clearfix">
                                <input type="text" name="areaId" id="areaId" onchange="changeArea();"/>
                            </div>
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="passWord">地址*</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <input type="text" name="address" id="address" class="form-control" />
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" onclick="javascript:$('#infoForm').submit();" class="btn btn-success btn-sm">
                    保存
                </button>
                <button type="button" class="btn btn-info btn-sm" data-dismiss="modal">
                    关闭
                </button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var addFlag=false;
    var saveDataAry=[];
    var data1={"userName":"test","password":"gz"};
    var data2={"userName":"ququ","password":"gr"};
    saveDataAry.push(data1);
    saveDataAry.push(data2);
    $.ajax({
        url:"http://localhost:8080/users/testPost",
        type:"post",
        dataType:"json",
        contentType: "application/json",
        data:JSON.stringify(data1),
        success:function (data) {

        }
    })
    $("#areaId").combotree({
        url: sys.rootPath + "/region/getByPid.action",
        method: 'get',
        onBeforeSelect: function (node) {
            if (node.state == "closed" || node.children.length > 0) {
                return false;
            }
        },
        panelWidth: 300,
        panelHeight: 400
    });
    $("#jsonmap").jqGrid({
        url:sys.rootPath+'/adminOrg/sheQuList.action',
        datatype: "json",
        mtype:"GET",
        colNames:['ID','名称','电话','地区','地址','添加时间','操作'],
        colModel:[
            {name:'id',index:'id',width:1,align:'center',key:true},
            {name:'name',sortable:false,width:2},
            {name:'tel',sortable:false,width:2},
            {name:'areaName',sortable:false,width:2},
            {name:'address',sortable:false,width:3},
            {name:'createTime',sortable:false,width:2,align:'center'},
            {name:'op',index:'op',sortable:false,align:'center',width:2,formatter:formaterOpretion}
        ],
        rowList:[10,20,30],
        pager: '#pjmap',
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
    function formaterOpretion(cellvalue, options, rowdata) {
        var a =  '<a href="javascript:void(0)" title="编辑" onclick="editUI('+rowdata.id+');"class="tab_a"><i class="ace-icon glyphicon glyphicon-edit"></i></a>&nbsp;&nbsp;'+'<a href="javascript:void(0)" title="人员管理" onclick="managerUI('+rowdata.id+');" class="tab_a"><i class="ace-icon fa fa-users"></i></a>'
        return a;
    }


    function editUI(id) {
        addFlag=false;
        $.ajax({
            type: "GET",
            url: sys.rootPath +"/adminOrg/detail.action",
            data: {
                "id":id,
            },
            dataType: "json",
            success: function (data) {
                if (data.success) {
                    $("#name").val(data.data.name);
                    $("#address").val(data.data.address);
                    $("#tel").val(data.data.tel);
                    $("#areaId").combotree("setValue", data.data.areaId);
                    $("#areaId").combotree("setText",$("#jsonmap").jqGrid('getCell', id, 'areaName'));
                    $("#id").val(data.data.id);
                    $('#infoModal').modal('show');
                } else {
                    layer.msg(data.message, {icon: 5});
                }
            }
        });
    }

    function add(){
        addFlag=true;
        $('#infoModal').modal('show');
        $("#infoForm :text").val("");
    }

    function reloadGrid(){
        $("#jsonmap").trigger("reloadGrid");
    }


    function managerUI(id) {
        localStorage.setItem("orgId",id);
        localStorage.setItem("orgType","社区");
        loadPage("/managerListUI.action?orgId="+id,"人员管理");
    }
    $(function(){
        validateInfoForm();
    });

    function validateInfoForm(){
        $('#infoForm').validate({
            errorElement : 'div',
            errorClass : 'help-block',
            focusInvalid : false,
            ignore : "",
            rules : {
                name : {
                    required:true
                },
                tel : {
                    required:true
                },
                address : {
                    required:true
                },
            },
            messages : {
                name : {
                    required:'该信息为必填信息'
                },
                tel : {
                    required:'该信息为必填信息'
                },
                address : {
                    required:'该信息为必填信息'
                },
            },
            highlight : function(e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },
            success : function(e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-success');
                $(e).remove();
            },
            errorPlacement : function(error, element) {
                if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
                    var controls = element.closest('div[class*="col-"]');
                    if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
                    else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
                }
                else if(element.is('.select2')) {
                    error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
                }
                else if(element.is('.chosen-select')) {
                    error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
                }
                else error.insertAfter(element.parent());
            },
            submitHandler : function(form) {
                $("button").attr("disabled","true");
                var url="/adminOrg/addOrg.action";
                if(!addFlag)
                    url = "/adminOrg/update.action";
                var obj = parseToObj("infoForm");




                $.post(sys.rootPath+url,obj,function(data){
                    if(data.success){
                        reloadGrid();
                        $('#infoModal').modal('hide');
                        layer.msg(data.message,{icon:1});
                    }else{
                        layer.msg(data.message,{icon:5});
                    }
                    $('button').removeAttr("disabled");
                },"json");
            }
        });
    }
</script>

