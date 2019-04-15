<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@include file="../common/uploader.jspf" %>
<%--<%@include file="../common/layui.jspf" %>--%>
<div class="row">
    <div class="col-sm-12">
        <%--<h4 class="m-t">--%>
            <%--&lt;%&ndash;<button class="btn btn-xs btn-success" type="button" onclick="add()">&ndash;%&gt;--%>
                <%--&lt;%&ndash;<i class="ace-icon glyphicon glyphicon-plus"></i>添加&ndash;%&gt;--%>
            <%--&lt;%&ndash;</button>&ndash;%&gt;--%>
        <%--</h4>--%>
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
                <%--<h4 class="modal-title"></h4>--%>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="infoForm">
                    <input name="id" id="id" type="hidden">
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="userName">标题*</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <input type="text" name="name" id="name" class="form-control"/>
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
    var addFlag = false;
    $("#jsonmap").jqGrid({
        url: sys.rootPath + '/info/stageList.action',
        datatype: "json",
        mtype: "GET",
        colNames: ['ID', '标题', '操作'],
        colModel: [
            {name: 'id', index: 'id', key: true, width: 1, align: 'center'},
            {name: 'name', sortable: false, width: 2,align:'center'},
            {name: 'op', index: 'op', sortable: false, align: 'center', width: 2, formatter: formaterOpretion}
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
        var a = '<a href="javascript:void(0)" title="编辑" onclick="editUI(' + rowdata.id + '); "class="tab_a"><i class="ace-icon glyphicon glyphicon-edit"></i></a>&nbsp;&nbsp;'
//            '<a href="javascript:void(0)" title="删除" onclick="del(\'/activity/del.action\',reloadGrid,'+rowdata.id+')" class="tab_a"><i class="ace-icon glyphicon glyphicon-trash"></i></a>';
//        a+=' <a href="#" title="公告管理" onclick="infoUI(' + rowdata.id + ');" class="tab_a"><i class="ace-icon fa fa-info-circle"></i></a>'
        return a;
    }







    function editUI(id) {
        $.get(sys.rootPath + "/info/stageDetail.action", {
            id:id
        }, function (data) {
            addFlag = false;
            $("#id").val(data.data.id);
            $("#name").val(data.data.name);
            $('#infoModal').modal('show');
        }, "json");

    }

    function add() {
        addFlag = true;
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
                name: {
                    required: true
                }
            },
            messages: {
                name: {
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
                $("button").attr("disabled", "true");
                var url = "/activity/add.action";
                if (!addFlag)
                    url = "/info/updateStage.action";
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
</script>

