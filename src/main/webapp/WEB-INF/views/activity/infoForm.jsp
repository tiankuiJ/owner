<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@include file="../common/layui.jspf" %>
<%@include file="../common/combotree.jspf" %>
<%@include file="../common/uploader.jspf" %>
<%@include file="../common/kindeditor.jspf" %>
<div class="row">
    <div class="col-sm-12">
        <div class="tabbable">
            <div class="tab-content">
                <div id="fir" class="tab-pane fade in active">
                    <form id="img_upload_form" enctype="multipart/form-data" method="post">
                        <input type="file" accept="image/*" name="image_file" style="display: none;" id="image_file"
                               onchange="fileSelected(this,'imgProgress','img_upload_form','imgUrl','image');"/>
                    </form>
                    <form id="infoForm" name="form" class="form-horizontal" role="form"
                          method="post">
                        <input type="hidden" id="id" value="${m.id}" name="id"/>
                        <input type="hidden" id="oid" value="${m.oid}" name="oid"/>
                        <input type="hidden" id="voteId" value="${m.oid}" name="voteId"/>
                        <input type="hidden" id="bjids" value="${m.bjids}" name="bjids"/>
                        <div class="form-group">
                            <label class="control-label col-sm-1 no-padding-right" for="name">项目标题</label>
                            <div class="col-sm-3">
                                <div class="clearfix">
                                    <input class="form-control" name="title" id="title" type="text"
                                           value="${m.title}"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" id="bBusinessDiv">
                            <label class="control-label col-sm-1 no-padding-right" for="userName">阶段</label>
                            <div class="col-sm-3">
                                <div class="clearfix">
                                    <select class="form-control" name="stageId" id="bBusiness"
                                            style="width: 100%;float: left;">
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-1 no-padding-right" for="userName">附加活动</label>
                            <div class="col-sm-3">
                                <div class="clearfix">
                                    <label id="newsInfoTitle" class="control-label" style="font-style: italic;"></label>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="op"
                                                   <c:if test="${empty m}">checked="checked"</c:if>
                                                   value="无"
                                                   class="ace" <c:if
                                                    test="${m.op eq '无'}"> checked="checked"</c:if>>
                                            <span class="lbl">无</span>
                                        </label>
                                        <label>
                                            <input type="radio" name="op"
                                                    value="报名"
                                                   class="ace" <c:if
                                                    test="${m.op eq '报名'}"> checked="checked"</c:if>>
                                            <span class="lbl">报名</span>
                                        </label>
                                        <label>
                                            <input type="radio" name="op"
                                                    value="表决"
                                                   class="ace" <c:if
                                                    test="${m.op eq '表决'}"> checked="checked"</c:if>>
                                            <span class="lbl">表决</span>
                                        </label>
                                        <label>
                                            <input type="radio" name="op"
                                                    value="意见"
                                                   class="ace" <c:if
                                                    test="${m.op eq '意见'}"> checked="checked"</c:if>>
                                            <span class="lbl">意见</span>
                                        </label>
                                        <label>
                                            <input type="radio" name="op"
                                                    value="投票"
                                                   class="ace" <c:if
                                                    test="${m.op eq '投票'}"> checked="checked"</c:if>>
                                            <span class="lbl">投票</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <%--<div class="form-group">--%>
                            <%--<label class="control-label col-sm-1 no-padding-right" for="name">活动时间</label>--%>
                            <%--<div class="col-sm-2">--%>
                                <%--<div class="clearfix">--%>
                                    <%--<input class="layui-input form-control" placeholder="开始时间" value="${startTime}"--%>
                                           <%--id="startTime" name="startTime">--%>
                                <%--</div>--%>
                            <%--</div>--%>
                            <%--<div style="float: left;">--%>
                                <%--<label class="control-label">至</label>--%>
                            <%--</div>--%>
                            <%--<div class="col-sm-2">--%>
                                <%--<div class="clearfix">--%>
                                    <%--<input class="layui-input form-control" placeholder="结束时间" value="${endTime}"--%>
                                           <%--id="endTime" name="endTime">--%>
                                <%--</div>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                        <input type="hidden" name="activityId" id="activityId"/>
                        <div class="form-group">
                            <label class="control-label col-sm-1 no-padding-right">视频</label>
                            <div class="col-sm-3">
                                <div class="clearfix">
                                    <p>
                                        <video
                                                <c:if test="${empty m.video}">hidden="hidden"</c:if>
                                                id="courseVideo"
                                                width="400px;" height="450px;" src="${m.video }"
                                                controls="controls"></video>
                                        <input placeholder="输入视频地址或手动上传" style="width: 300px" name="video"
                                               cid="courseVideo" id="courseVideoInput" type="text"
                                               value="${m.video }" onchange="showVideo(this)"/>
                                        <button type="button" class="btn btn-primary btn-sm"
                                                onclick="clickImgFile('courseVideoImage_file')">
                                            <i class="fa fa-upload">上传</i>&nbsp;
                                        </button>
                                    <div class="span-help">
                                        <span class="help-inline">
                                            <span class="middle">
                                                视频上传说明*<br/>
                                                建议上传格式为MP4,大小不超过500M的视频文件<br/>
                                            </span>
                                        </span>
                                    </div>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1"></label>
                            <div class="col-sm-6">
                                <div class="clearfix">
                                    <div id="courseVideoImgProgress"></div>
                                </div>
                            </div>
                        </div>
                        <input type="hidden" id="stagetIdValue" value="${m.stageId}"/>
                        <div class="form-group">
                            <label class="control-label col-sm-1 no-padding-right" for="name">活动内容</label>
                            <div class="col-sm-3">
                                <div class="clearfix">
                           <textarea id="editor_id" name="content" style="width:700px;height:300px;">
                               ${m.content}
                           </textarea>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-1"></label>
                            <button id="btnAdd" type="button"
                                    onclick="javascript:$('#infoForm').submit();"
                                    class="btn btn-primary btn-sm">
                                <i class="fa fa-save"></i>&nbsp;
                                保存
                            </button>

                            <button id="btn" type="button"
                                    onclick="loadPage('/info/listUI.action')"
                                    class="btn btn-info btn-sm">
                                <i class="fa fa-undo"></i>&nbsp;返回
                            </button>
                        </div>
                    </form>
                    <form id="courseVideoImg_upload_form" enctype="multipart/form-data" method="post">
                        <input type="file" accept="video/*" name="courseVideoImage_file" style="display: none;"
                               id="courseVideoImage_file"
                               onchange="fileSelected(this,'courseVideoImgProgress','courseVideoImg_upload_form','courseVideoInput','media');"/>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="newsInfoModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                </button>
                <h4 class="modal-title">选择信息</h4>
            </div>
            <div class="modal-body">
                <h4 class="m-t">
                    <input class="col-xs-6" type="text" id="searchInput"
                           placeholder="请输入关键词" style="height: 30px;">
                    <button class="btn btn-xs btn-warning" type="button" onclick="searchStr()">
                        <i class="ace-icon glyphicon glyphicon-search"></i>查询
                    </button>
                </h4>
                <div class="jqGrid_wrapper">
                    <table id="jsonmap"></table>
                    <div id="pjmap"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" onclick="selectNewsInfo()" class="btn btn-success btn-sm">
                    确定
                </button>
                <button type="button" class="btn btn-info btn-sm" data-dismiss="modal">
                    关闭
                </button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    loadK("editor_id");//初始化富文本编辑框
    $.get(sys.rootPath + "/info/stageListNoPage.action", {}, function (data) {
        data = data.data;
        var htmlStr = '';
        for (var i = 0; i < data.length; i++) {
            htmlStr += '<option value="' + data[i].id + '"><font><font>' + data[i].name + '</font></font></option>';
        }
        $("#bBusiness").html(htmlStr);
        if($("#stagetIdValue").val()!=""){
            $("#bBusiness").val($("#stagetIdValue").val());
        }
    }, "json");
    $("#activityId").val(localStorage.getItem("activityId"));
    function showVideo(e) {
        $(e).parent().css("display", "inline-block");
        $("#" + $(e).attr("cid")).attr("src", $(e).val());
        $("#" + $(e).attr("cid")).removeAttr("hidden");
        $("#" + $(e).attr("cid")).parent().attr("href", $(e).val());
        $(e).blur();
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
                title: {
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
                var id = $("#id").val();
                var url = "/info/add.action";
                if (id != "") {
                    url = "/info/update.action";
                }
                if (op!="无" && !selectVote) {
                    layer.msg("请选择附加活动信息", {icon: 5});
                    return;
                }
                $("button").attr("disabled", "true");
                var obj = parseToObj("infoForm");
                $.post(sys.rootPath + url, obj, function (data) {
                    if (data.success) {
                        layer.msg(data.message, {icon: 1});
                    } else {
                        layer.msg(data.message, {icon: 5});
                    }
                    loadPage("/info/listUI.action");
                    $('button').removeAttr("disabled");
                }, "json");
            }
        });
    }
    initActivityDateNoTimeInput();
    function initActivityDateNoTimeInput() {
        layui.use('laydate', function () {
            var laydate = layui.laydate;

            var start = {
                min: laydate.now(),
                max: '2099-06-16',
                istoday: false,
                istime: true,
                format: 'YYYY-MM-DD',
            };

            var end = {
                min: laydate.now(),
                max: '2099-06-16',
                istoday: false,
                istime: true,
                format: 'YYYY-MM-DD',
            };

            try {
                try {
                    document.getElementById('endTime').onclick = function () {
                        end.elem = this
                        laydate(end);
                    }
                } catch (err) {

                }


                document.getElementById('startTime').onclick = function () {
                    start.elem = this;
                    laydate(start);
                }

            } catch (err) {

            }

        });
    }


    $("#jsonmap").jqGrid({
        url: sys.rootPath + '/vote/list.action?infoId=1',
        datatype: "json",
        mtype: "GET",
        colNames: ['ID', '项目标题', '发布机构', '创建时间',],
        colModel: [
            {name: 'id', index: 'id', hidden: true},
            {name: 'title', sortable: false, width: 8},
            {name: 'orgName', index: 'a.org_id', width: 2},
            {name: 'createTime', index: 'a.create_time', width: 2},
        ],
        rowList: [10, 20, 30],
        pager: '#pjmap',
        rownumbers: true,
        sortname: 'id',
        viewrecords: true,
        sortorder: "desc",
        jsonReader: {
            repeatitems: false,
            id: "0"
        },
        height: '100%',
        width: 560,
        multiselect: true,
        page: $("#g_page").val(),
        rowNum: $("#g_rows").val()
    });
    $("#jsonmap").jqGrid('navGrid', '#pjmap', {edit: false, add: false, del: false, search: false});
    var selectVote = false;
    var op = "无";
    function selectNewsInfo() {
        var list = $("#jsonmap").jqGrid("getGridParam", "selarrrow");
        if(op=='表决'){
            if (list.length == 0) {
                layer.msg("你没有选取数据", {
                    icon: 0
                });
                return;
            }
            var selectTitles='';
            var selectIds='';
            for(var i=0;i<list.length;i++){
                selectTitles+=$("#jsonmap").jqGrid('getRowData', list[i]).title+",";
                selectIds=selectIds+$("#jsonmap").jqGrid('getRowData', list[i]).id+",";
            }
            $("#newsInfoTitle").text(selectTitles);
            $("#voteId").val($("#jsonmap").jqGrid('getRowData', list[0]).id);
            $("#bjids").val(selectIds);
            $("#newsInfoModal").modal("hide");
            selectVote = true;
        }else{
            if (list.length != 1) {
                layer.msg("你没有选取数据或选择了多条数据", {
                    icon: 0
                });
                return;
            }
            var rowData = $("#jsonmap").jqGrid('getRowData', list[0]);
            $("#newsInfoTitle").text(rowData.title);
            $("#voteId").val(rowData.id);
            $("#newsInfoModal").modal("hide");
            selectVote = true;
        }
    }


    $(":radio[name='op']").click(function () {
        var val = $(this).val();
        op=val;
        var url = "";
        if (val != "无") {
            if (val == "投票") {
                url = sys.rootPath + '/vote/list.action?infoId=1';
            } else {
                if($("#id").val()==""){
                    url = sys.rootPath + '/opInfo/list.action?type=' + val+"&infoId=1";
                }else{
                    url = sys.rootPath + '/opInfo/list.action?type=' + val+"&infoId="+$("#id").val();
                }
            }
            if(val=='表决'){
                $("#jsonmap").jqGrid('setGridParam', {
                    url: url,
                    datatype: 'json',
                    multiselect: true,
                    page: 1
                }).trigger("reloadGrid");
            }else{
                $("#jsonmap").jqGrid('setGridParam', {
                    url: url,
                    datatype: 'json',
                    page: 1
                }).trigger("reloadGrid");
            }
            $("#newsInfoModal").modal("show");
        }

    });

</script>