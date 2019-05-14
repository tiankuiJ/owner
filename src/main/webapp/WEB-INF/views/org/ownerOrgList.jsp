<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    th {
        text-align: center;
    }
</style>
<div class="row">
    <div class="col-sm-12">
        <h4 class="m-t">
            <div class="col-xs-2">
                <select name="stageId" id="bBusiness" onchange="changeXiao();"
                        class="form-control">
                </select>
            </div>
            <div class="col-xs-3" >
                <%--<button class="btn btn-xs btn-success" type="button"  onclick="add()">--%>
                    <%--<i class="ace-icon glyphicon glyphicon-plus"></i>添加--%>
                <%--</button>--%>
            </div>

            <div class="col-xs-4">

            </div>
            <div class="col-xs-3">
                <input class="col-xs-9" type="text" id="searchInput"
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
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="infoForm">
                    <input name="id" id="id" type="hidden">
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="userName">小区*</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <select name="orgId" id="orgSelect"
                                        class="form-control">
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="userName">业主*</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <input type="text" name="name" id="name" readonly="readonly" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="passWord">专有部分座落</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <input type="text" name="position" id="position" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="passWord">专有部分面积*</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <input type="number" name="acreage" id="acreage" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="userName">备注</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <input type="text" name="remark" id="remark" class="form-control"/>
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
    var orgId = 0;
    $.get(sys.rootPath + "/adminOrg/xiaoQuListNoPage.action", {}, function (data) {
        var htmlStr = '<option value="null">不限</option>';
        var hh = '';
        for (var i = 0; i < data.length; i++) {
            htmlStr += '<option value="' + data[i].id + '">' + data[i].name + '</option>';
            hh += '<option value="' + data[i].id + '">' + data[i].name + '</option>';
        }
        $("#bBusiness").html(htmlStr);
        $("#orgSelect").html(hh);
    }, "json");
    $("#orgId").val(localStorage.getItem("orgId"));
    $("#importOrgId").val(localStorage.getItem("orgId"));
    var addFlag = false;
    $("#jsonmap").jqGrid({
        url: sys.rootPath + '/selectOwnerOrgList.action',
        datatype: "json",
        mtype: "GET",
        colNames: ['ID', '','', '业主', '电话', '小区','专有部分座落', '专有部分面积', '备注', '操作'],
        colModel: [
            {name: 'id', index: 'id', key: true, width: 1, align: 'center'},
            {name: 'userId', index: 'userId',  width: 1, align: 'center',hidden:true},
            {name: 'orgId', index: 'orgId',  width: 1, align: 'center',hidden:true},
            {name: 'ownerName', sortable: false, width: 1, align: 'center'},
            {name: 'phone', sortable: false, width: 1},
            {name: 'orgName',index:'b.org_id', sortable: false, width: 1},
            {name: 'position', sortable: false, width: 1},
            {name: 'acreage', sortable: false, width: 1, align: 'center'},
            {name: 'remark', sortable: false, width: 1, align: 'center'},
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
        var a = '<a href="javascript:void(0)" title="编辑" onclick="editUI(' + rowdata.id + ');" class="tab_a"><i class="ace-icon glyphicon glyphicon-edit"></i></a>&nbsp;&nbsp;' + '<a href="javascript:void(0)"  title="删除" onclick="deleteUI(' + rowdata.id + ');" class="tab_a"><i class="ace-icon glyphicon glyphicon-trash"></i></a>&nbsp;&nbsp;';
        return a;
    }

    function editUI(id) {
        addFlag = false;
        $("#id").val($("#jsonmap").jqGrid('getCell', id, 'id'));
        $("#orgSelect").val($("#jsonmap").jqGrid('getCell', id, 'orgId'));
        $("#name").val($("#jsonmap").jqGrid('getCell', id, 'ownerName'));
        $("#position").val($("#jsonmap").jqGrid('getCell', id, 'position'));
        $("#acreage").val($("#jsonmap").jqGrid('getCell', id, 'acreage'));
        $("#remark").val($("#jsonmap").jqGrid('getCell', id, 'remark'));
        $('#infoModal').modal('show');
    }

    function add() {
        addFlag = true;
        $("#orgId").val(orgId);
        $("#phone").removeAttr("readonly");
        $("#psd").removeAttr("readonly");
        $('#infoModal').modal('show');
        $("#infoForm :text").val("");
    }

    function reloadGrid() {
        $("#jsonmap").trigger("reloadGrid");
    }


    $(function () {
        validateInfoForm();
    });

    function validateInfoForm() {
        $('#infoForm').validate({
            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            ignore: "",
            rules: {
                phone: {
                    required: true
                },
                psd: {
                    required: true
                },
                acreage: {
                    required: true
                }
            },
            messages: {
                phone: {
                    required: '该信息为必填信息'
                },
                psd: {
                    required: '该信息为必填信息'
                },
                acreage: {
                    required: '该信息为必填信息'
                }
            },
            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },
            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-success');
                $(e).remove();
            },
            errorPlacement: function (error, element) {
                if (element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
                    var controls = element.closest('div[class*="col-"]');
                    if (controls.find(':checkbox,:radio').length > 1) controls.append(error);
                    else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
                }
                else if (element.is('.select2')) {
                    error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
                }
                else if (element.is('.chosen-select')) {
                    error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
                }
                else error.insertAfter(element.parent());
            },
            submitHandler: function (form) {
                var url = "/addOwnerOrg.action";
                $("button").attr("disabled", "true");
                if (!addFlag)
                    url = "/updateOwnerOrg.action";
                var obj = parseToObj("infoForm");
                $.post(sys.rootPath + url, obj, function (data) {
                    if (data.success) {
                        reloadGrid();
                        $('#infoModal').modal('hide');
                        layer.msg(data.message, {icon: 1});
                    } else {
                        layer.msg(data.message, {icon: 5});
                    }
                    $('button').removeAttr("disabled");
                }, "json");
            }
        });
    }

    function deleteUI(id) {
        layer.confirm('是否删除该信息？', {icon: 1, title: '删除提示'}, function (index, layero) {
            $.ajax({
                type: "POST",
                url: sys.rootPath + "/deleteOwnerOrg.action",
                data: {
                    id: id
                },
                dataType: "json",
                success: function (data) {
                    if (data.success) {
                        layer.msg(data.message, {icon: 1});
                        reloadGrid();
                    } else {
                        layer.msg(data.message, {icon: 5});
                    }
                }
            });
        });
    }

    function changeXiao() {
        if ($("#bBusiness").val() != null && $("#bBusiness").val() != "null") {
            orgId = $("#bBusiness").val();
            $("#orgId").val(orgId);
            $("#importOrgId").val(orgId);
            $("#jsonmap").jqGrid('setGridParam', {
                url: sys.rootPath + '/selectOwnerOrgList.action?orgId=' + $("#bBusiness").val(),
                datatype: 'json',
                page: 1
            }).trigger("reloadGrid");
        } else {
            orgId = 0;
            $("#jsonmap").jqGrid('setGridParam', {
                url: sys.rootPath + '/selectOwnerOrgList.action',
                datatype: 'json',
                page: 1
            }).trigger("reloadGrid");
        }

    }
</script>

