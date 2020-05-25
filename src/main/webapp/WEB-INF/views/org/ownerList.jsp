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
            <div class="col-xs-3">
                <%--<button class="btn btn-xs btn-success" type="button" onclick="add()">--%>
                <%--<i class="ace-icon glyphicon glyphicon-plus"></i>添加--%>
                <%--</button>--%>
                <button class="btn btn-sm btn_" type="button" onclick="javascript:$('#importModal').modal('show');">
                    <i class="ace-icon fa fa-folder-open"></i>导入
                </button>
                <%--<button class="btn-sm  btn_" type="button" onclick="backOrg()">--%>
                <%--<i class="ace-icon glyphicon glyphicon-backward"></i>返回--%>
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

                    <%--<input name="orgId" type="hidden" id="orgId"/>--%>
                    <input name="oldPhone" type="hidden" id="oldPhone"/>
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="userName">姓名*</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <input type="text" name="name" id="name" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="userName">性别</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <label id="newsInfoTitle" class="control-label" style="font-style: italic;"></label>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="sex"
                                               checked="checked"
                                               value="男"
                                               class="ace">
                                        <span class="lbl">男</span>
                                    </label>
                                    <label>
                                        <input type="radio" name="sex"
                                               value="女"
                                               class="ace">
                                        <span class="lbl">女</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="userName">身份证号*</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <input type="text" name="psd" id="psd" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="userName">电话*</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <input type="text" name="phone" id="phone" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="userName">电话(2)</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <input type="text" name="phonet" id="phonet" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="passWord">职业</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <input type="text" name="job" id="job" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="passWord">出生年月</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <input type="text" name="birth" id="birth" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="passWord">文化程度</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <input type="text" name="whcd" id="whcd" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="passWord">政治面貌</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <input type="text" name="zzmm" id="zzmm" class="form-control"/>
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

<div class="modal fade" id="importModal" tabindex="-2" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                </button>
                <h4 class="modal-title">导入</h4>
            </div>
            <div class="modal-body">
                <form id="importForm" name="form" class="form-horizontal" role="form"
                      method="post">
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right">格式</label>
                        <div class="col-sm-9">
                            <div class="clearfix">
                                <label class="control-label" style="text-align: left;">请按照 <span style="color: red;">专有部分座落、业主姓名、手机号码、手机号码2、专有部分面积总和、身份证号码、备注</span>
                                    的顺序上传业主数据，顺序错误可能会导致数据导入失败，支持xls格式和xlsx格式。（日期格式：年/月/日 或 年-月-日）</label>
                                <a href="#"
                                   onclick="javascript:window.open('${pageContext.request.contextPath }/resources/file/业主导入模板.xlsx')">点击下载模板</a>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right">文件</label>
                        <div class="col-sm-9">
                            <div class="clearfix">
                                <input name="orgId" id="importOrgId" type="hidden"/>
                                <input type="file"
                                       accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel"
                                       id="excelFile" name="excelFile">
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-inverse btn-sm" data-dismiss="modal">
                    关闭
                </button>
                <button type="button" onclick="submitImportForm()" class="btn btn-primary btn-sm">
                    保存
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
            htmlStr += '<option value="' + data[i].id + '"><font><font>' + data[i].name + '</font></font></option>';
            hh += '<option value="' + data[i].id + '"><font><font>' + data[i].name + '</font></font></option>';
        }
        $("#bBusiness").html(htmlStr);
        $("#orgSelect").html(hh);
    }, "json");
    $("#orgId").val(localStorage.getItem("orgId"));
    $("#importOrgId").val(localStorage.getItem("orgId"));
    var addFlag = false;
    $("#jsonmap").jqGrid({
        url: sys.rootPath + '/selectOwnerList.action',
        datatype: "json",
        mtype: "GET",
        colNames: ['ID', '', '', '', '姓名', '性别', '电话', '职业', '出生年月', '文化程度', '政治面貌', '专有部分座落', '专有部分面积', '添加时间', '操作'],
        colModel: [
            {name: 'id', index: 'id', key: true, width: 1, align: 'center'},
            {name: 'psd', hidden: true, width: 1, align: 'center'},
            {name: 'orgId', hidden: true, width: 1, align: 'center'},
            {name: 'remark', hidden: true, width: 1, align: 'center'},
            {name: 'name', sortable: false, width: 1, align: 'center'},
            {name: 'sex', sortable: false, width: 1, align: 'center'},
            {name: 'phone', sortable: false, width: 1},
            {name: 'job', sortable: false, width: 1, align: 'center'},
            {name: 'birth', sortable: false, width: 1, align: 'center'},
            {name: 'whcd', sortable: false, width: 1},
            {name: 'zzmm', sortable: false, width: 1},
            {name: 'position', sortable: false, width: 1},
            {name: 'acreage', sortable: false, width: 1, align: 'center'},
            {name: 'createTime', sortable: false, width: 2, align: 'center'},
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
//        $("#phone").attr("readonly","readonly");
        $("#psd").attr("readonly", "readonly");
        $("#orgSelect").val($("#jsonmap").jqGrid('getCell', id, 'orgId'));
        $("#name").val($("#jsonmap").jqGrid('getCell', id, 'name'));
        $("#sex").val($("#jsonmap").jqGrid('getCell', id, 'sex'));
        $("#psd").val($("#jsonmap").jqGrid('getCell', id, 'psd'));
        $("#phone").val($("#jsonmap").jqGrid('getCell', id, 'phone'));
        $("#oldPhone").val($("#jsonmap").jqGrid('getCell', id, 'phone'));
        $("#job").val($("#jsonmap").jqGrid('getCell', id, 'job'));
        $("#birth").val($("#jsonmap").jqGrid('getCell', id, 'birth'));
        $("#whcd").val($("#jsonmap").jqGrid('getCell', id, 'whcd'));
        $("#zzmm").val($("#jsonmap").jqGrid('getCell', id, 'zzmm'));
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


    function cList(id) {
        loadPage("/adminBusiness/clistUI.action?mark=a&pId=" + id);
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
                var url = "/addOwner.action";
//                    if(orgId==0){
//                        layer.msg("请选择小区再添加", {icon: 5});
//                        return;
//                    }
                $("button").attr("disabled", "true");
                if (!addFlag)
                    url = "/updateOwner.action";
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
                url: sys.rootPath + "/adminOrg/falseDelete.action",
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

    function backOrg() {
        loadPage("/adminOrg/xiaoQuListUI.action");
    }


    function submitImportForm() {
        if(!($("#excelFile").val())){
            layer.msg('请选择文件',{icon:2});
            return;
        }
        if (orgId == 0) {
            layer.msg("请选择小区再导入", {icon: 5});
            return "";
        }
        $("button").attr("disabled", "true");
        var formData = new FormData($("#importForm")[0]);
        var index;
        $.ajax({
            url: sys.rootPath + "/importOwner.action",
            type: 'POST',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function (returndata) {
                returndata = JSON.parse(returndata);
                $('button').removeAttr("disabled");
                if (returndata.success) {
                    layer.msg(returndata.message, {icon: 1});
                    reloadGrid();
                } else {
                    var content = "";
                    var errorData = returndata.data;
                    for (var i = 0; i < errorData.length; i++) {
                        content += "<p>错误行数:" + ((errorData[i].errorRowIndex)) + "&nbsp;&nbsp;&nbsp;&nbsp;错误原因:" + errorData[i].errorContent + "</p>";
                    }
                    layer.open({
                        content: content
                    });
                }
            },
            error: function () {
                $('button').removeAttr("disabled");
                layer.msg('服务器未响应,请稍后再试', {icon: 2});
            }
        });
        $('#importModal').modal('hide');
    }

    function changeXiao() {
        if ($("#bBusiness").val() != null && $("#bBusiness").val() != "null") {
            orgId = $("#bBusiness").val();
            $("#orgId").val(orgId);
            $("#importOrgId").val(orgId);
            $("#jsonmap").jqGrid('setGridParam', {
                url: sys.rootPath + '/selectOwnerList.action?orgId=' + $("#bBusiness").val(),
                datatype: 'json',
                page: 1
            }).trigger("reloadGrid");
        } else {
            orgId = 0;
            $("#jsonmap").jqGrid('setGridParam', {
                url: sys.rootPath + '/selectOwnerList.action',
                datatype: 'json',
                page: 1
            }).trigger("reloadGrid");
        }

    }
</script>

