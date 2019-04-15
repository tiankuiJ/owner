<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@include file="../common/uploader.jspf" %>
<%@include file="../common/layui.jspf" %>
<style>
    tab_a{
        color: #337ab7;
        text-decoration: none;
    }
</style>
<div class="row">
    <div class="col-sm-12">
        <h4 class="m-t">
            <button class="btn btn-xs btn-success" type="button" onclick="add()">
                <i class="ace-icon glyphicon glyphicon-plus"></i>添加
            </button>

            <button class="btn-sm  btn_" type="button" onclick="backActivity()">
                <i class="ace-icon glyphicon glyphicon-backward"></i>返回活动列表
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

<form id="img_upload_form" enctype="multipart/form-data" method="post">
    <input type="file" accept="image/gif,image/jpg,image/jpeg,image/png,image/bmp" name="image_file"
           style="display: none;" id="image_file"
           onchange="fileSelected(this,'imgProgress','img_upload_form','imgUrl','image');"/>
</form>
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

                    <input name="type" value="社区" type="hidden">
                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="userName">项目标题*</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <input type="text" name="title" id="title" class="form-control"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="userName">状态</label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <select class="form-control" name="status" id="status" style="width: 100%;float: left;">
                                    <option value="已发布">已发布</option>
                                    <option value="未发布">未发布</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-2 no-padding-right" for="img">封面图*</label>
                        <div class="col-sm-2">
                            <ul class="clearfix ace-thumbnails">
                                <li id="imgLi" style="border:0px;display: none;">
                                    <input name="img" id="imgUrl" type="hidden" onclick="showImg(this)"/>
                                    <a href="${m.img }" title="预览" data-rel="colorbox" target='_Blank'>
                                        <img id="img" src="${m.img }" style="height: 100px;width: auto;"/>
                                    </a>
                                    <div class="tools tools-bottom in" style="height: auto;">
                                        <a href="javascript:void(0)" title="删除" onclick="delImg(this)"> <i
                                                class="ace-icon fa fa-times red"></i></a>
                                    </div>
                                </li>
                            </ul>
                            <button type="button" class="btn btn-primary btn-sm"
                                    onclick="clickImgFile('image_file')">
                                <i class="fa fa-upload">上传</i>&nbsp;
                            </button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1"></label>
                        <div class="col-sm-6">
                            <div class="clearfix">
                                <div id="imgProgress"></div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1"></label>
                        <div class="col-sm-10">
                            <div class="clearfix">
                                <div class="span-help">
							<span class="help-inline">
								<span class="middle">
									图片上传说明*<br/>
									建议比例 2：1(长：宽)&nbsp;&nbsp;&nbsp;建议尺寸720 x 360<br/>
								</span>
							</span>
                                </div>
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
    function showImg(e) {
        $(e).parent().css("display", "inline-block");
        $("#img").attr("src", $(e).val());
        $("#img").parent().attr("href", $(e).val());
        $("#img").css({"height": "100px", "width": "auto"});
        $(e).blur();
    }
    function delImg(e) {
        $("#imgUrl").val("");
        $("#img").removeAttr("src");
        $(e).parent().parent().css("display", "none");
        $("#imgProgress").empty();
    }
    function clickImgFile(image_file) {
        $("#" + image_file).click();
    }
    var addFlag = false;
    $("#jsonmap").jqGrid({
        url: sys.rootPath + '/info/list.action?activityId='+localStorage.getItem("activityId"),
        datatype: "json",
        mtype: "GET",
        colNames: ['ID', '','项目标题',  '阶段', '辅助活动', '浏览量', '添加时间', '操作'],
        colModel: [
            {name: 'id', index: 'id', key: true, width: 1, align: 'center'},
            {name: 'orgId',   width: 1, align: 'center',hidden:true},
            {name: 'title', sortable: false, width: 2},
            {name: 'stageName', sortable: false, width: 2,align:'center'},
            {name: 'op', sortable: false, width: 1, align: 'center',formatter: formaterOp},
            {name: 'viewNum', index: 'a.view_num', sortable: true, width: 1,align: 'center'},
            {name: 'createTime', sortable: false, width: 2,align:'center'},
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
        var a = '<a href="javascript:void(0)" title="编辑"  onclick="editUI(' + rowdata.id + ');"class="tab_a"><i class="ace-icon glyphicon glyphicon-edit"></i></a>&nbsp;&nbsp;' ;
        a+='<a href="javascript:void(0)"  title="删除"  onclick="del(\'/info/del.action\',reloadGrid,'+rowdata.id+')" class="tab_a"><i class="ace-icon glyphicon glyphicon-trash"></i></a>';
//        if(rowdata.op!="无"){
//            a+='&nbsp;&nbsp;<a href="#" title="参加记录" onclick="infoUI(' + rowdata.id + ',\''+rowdata.op+'\');" class="tab_a"><i class="ace-icon fa fa-align-left"></i></a>'
//        }
        return a;
    }
    function formaterOp(cellvalue, options, rowdata) {
        if(rowdata.op!="无"){
            if(rowdata.op=="投票"){
                return '<a href="#" title="投票结果" onclick="infoUI('+rowdata.orgId+','+rowdata.oid+','+ rowdata.id + ',\''+rowdata.op+'\');" class="tab_a">投票结果></a>';
            }
            if(rowdata.op=="表决"){
                return '<a href="#" title="表决结果" onclick="infoUI('+rowdata.orgId+','+rowdata.oid+','+ rowdata.id + ',\''+rowdata.op+'\',\''+ rowdata.bjids + '\');" class="tab_a">表决结果></a>';
            }
            if(rowdata.op=="意见"){
                return '<a href="#" title="意见反馈" onclick="infoUI('+rowdata.orgId+','+rowdata.oid+','+ rowdata.id + ',\''+rowdata.op+'\');" class="tab_a">意见反馈></a>';
            }
            if(rowdata.op=="报名"){
                return '<a href="#" title="报名列表" onclick="infoUI('+rowdata.orgId+','+rowdata.oid+','+ rowdata.id + ',\''+rowdata.op+'\');" class="tab_a">报名列表></a>';
            }
        }
        return rowdata.op;
    }

    function del(nav, callback,id) {
        layer.confirm('删除该条信息会一并删除该信息所有关联信息，确认删除吗？', {icon:3,title:'删除提示'},function(index, layero) {
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
                        if (callback) {
                            callback();
                        }
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


    function editUI(id) {
        loadPage("/info/formUI.action?id="+id)
    }
    function backActivity() {
        loadPage("/activity/listUI.action","活动列表")
    }

    function add() {
//        addFlag = true;
//        $('#infoModal').modal('show');
//        $("#infoForm :text").val("");
        loadPage("/info/formUI.action");
    }

    function reloadGrid() {
        $("#jsonmap").trigger("reloadGrid");
    }


    function infoUI(orgId,oid,id,op,bjids) {
        localStorage.setItem("infoId", id);
        localStorage.setItem("oid", oid);
        localStorage.setItem("op", op);
        localStorage.setItem("from", "info");
        if(op=="投票"){
            loadPage("/regRecord/voteRecordListUI.action",op+"记录");
        }else{
            localStorage.setItem("bjids", bjids);
            loadPage("/regRecord/listUI.action",op+"记录");
        }
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
                title: {
                    required: true
                },
            },
            messages: {
                name: {
                    required: '该信息为必填信息'
                },
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
                    url = "/activity/update.action";
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

