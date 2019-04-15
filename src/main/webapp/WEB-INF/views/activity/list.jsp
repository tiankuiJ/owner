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
                <%--<h4 class="modal-title"></h4>--%>
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
                                    <option value="未发布">未发布</option>
                                    <option value="已发布">已发布</option>
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
//    $.ajax({
//        type : "POST",
//        url : "http://localhost:8080/wxfc/login",
//        data : {
//            username:"005",
//            password:"zx1958"
//        },
//        xhrFields:{
//            withCredentials:true
//        },
//        dataType : "json",
//        success : function(resultdata) {
//            alert(JSON.stringify(resultdata));
//            $.ajax({
//                type : "GET",
//                xhrFields:{
//                    withCredentials:true
//                },
//                url : "http://localhost:8080/wxfc/admin/huXing/ajax/list",
//                dataType : "json",
//                success : function(resultdata) {
//                    alert(JSON.stringify(resultdata));
//                }
//            });
//        },
//        error : function(data,errorMsg) {
//            layer.msg('服务器未响应,请稍后再试',{icon:3});
//        }
//    });



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
        url: sys.rootPath + '/activity/list.action',
        datatype: "json",
        mtype: "GET",
        colNames: ['ID','orgId', '项目标题', '图片','二维码', '发布机构', '是否发布', '浏览量', '添加时间', '操作'],
        colModel: [
            {name: 'id', index: 'id', key: true, width: 1, align: 'center'},
            {name: 'orgId', width: 1, align: 'center',hidden:true},
            {name: 'title', sortable: false, width: 2,formatter:formaterTitle},
            {name: 'img', hidden: true, sortable: false, width: 2},
            {name: 'qrCode', align: 'center',  sortable: false, width: 2,formatter:formatCellImg},
            {name: 'orgName', index: 'a.org_id', sortable: false, width: 2},
            {name: 'status', sortable: false, width: 1,formatter: formaterStatus, align: 'center'},
            {name: 'viewNum', index: 'a.view_num', sortable: true, width: 1,align: 'center'},
            {name: 'createTime', sortable: false, width: 1,align:'center'},
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
        var a = '<a href="javascript:void(0)" title="编辑" onclick="editUI(' + rowdata.id + '); "class="tab_a"><i class="ace-icon glyphicon glyphicon-edit"></i></a>&nbsp;&nbsp;' + '<a href="javascript:void(0)" title="删除" onclick="del(\'/activity/del.action\',reloadGrid,'+rowdata.id+')" class="tab_a"><i class="ace-icon glyphicon glyphicon-trash"></i></a>';
//        a+=' <a href="#" title="公告管理" onclick="infoUI(' + rowdata.id + ');" class="tab_a"><i class="ace-icon fa fa-info-circle"></i></a>'
        return a;
    }

    function formaterTitle(cellvalue, options, rowdata) {
        var a = '<a href="javascript:void(0)" title="参加记录"  onclick="infoUI('+rowdata.orgId+',' + rowdata.id + ');"class="tab_a">'+rowdata.title+'</a>&nbsp;&nbsp;';
        return a;
    }


    function formaterStatus(cellvalue, options, rowdata) {
        if(rowdata.status=="已发布")
            return "是";
        return "否"
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
//        $.get(sys.rootPath + "/activity/detail.action", {
//            id:id
//        }, function (data) {
//            addFlag = false;
//            var img = data.data.img;
//            if (img) {
//                $("#imgLi").css("display", "inline-block");
//                $("#img").attr("src", img);
//                $("#imgUrl").val(img);
//                $("#img").parent().attr("href", img);
//                $("#img").css({"height": "100px", "width": "auto"});
//            }
//            $("#id").val(data.data.id);
//            $("#title").val(data.data.title);
//            $("#status").val(data.data.status);
//            $('#infoModal').modal('show');
//        }, "json");

        loadPage("/activity/formUI.action?id="+id,"编辑活动");
    }

    function add() {
//        addFlag = true;
//        $('#infoModal').modal('show');
//        $("#infoForm :text").val("");
        loadPage("/activity/formUI.action","添加活动");
    }

    function reloadGrid() {
        $("#jsonmap").trigger("reloadGrid");
    }


    function infoUI(orgId,id) {
        localStorage.setItem("orgId", orgId);
        localStorage.setItem("activityId", id);
        loadPage("/info/listUI.action","公告列表");
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
                }
            },
            messages: {
                title: {
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

