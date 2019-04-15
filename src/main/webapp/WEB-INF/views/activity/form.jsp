<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../common/uploader.jspf" %>
<%@include file="../common/layui.jspf" %>
<%@include file="../common/kindeditor.jspf" %>
<div class="row" style="margin-top:5px;">
    <form id="img_upload_form" enctype="multipart/form-data" method="post">
        <input type="file" accept="image/gif,image/jpg,image/jpeg,image/png,image/bmp" name="image_file"
               style="display: none;" id="image_file"
               onchange="fileSelected(this,'imgProgress','img_upload_form','imgUrl','image');"/>
    </form>
    <div class="col-xs-12">
        <form id="form" name="form" class="form-horizontal" role="form"
              method="post">
            <c:if test="${!empty m}">
                <input type="hidden" name="id" id="id" value="${m.id }">
            </c:if>
            <div class="form-group">
                <label class="control-label col-sm-1 no-padding-right" for="userName">项目名称*</label>
                <div class="col-sm-6">
                    <div class="clearfix">
                        <input type="text" value="${m.title}" name="title" id="title" class="form-control"/>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-1 no-padding-right" for="userName">是否发布</label>
                <div class="col-sm-6">
                    <div class="clearfix">
                        <label id="newsInfoTitle" class="control-label" style="font-style: italic;"></label>
                        <div class="radio">
                            <label>
                                <input type="radio" name="status"
                                       <c:if test="${empty m}">checked="checked"</c:if>
                                       value="未发布"
                                       class="ace" <c:if
                                        test="${m.status eq '未发布'}"> checked="checked"</c:if>>
                                <span class="lbl">否</span>
                            </label>
                            <label>
                                <input type="radio" name="status"
                                       value="已发布"
                                       class="ace" <c:if
                                        test="${m.status eq '已发布'}"> checked="checked"</c:if>>
                                <span class="lbl">是</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-1 no-padding-right" for="img">封面图*</label>
                <div class="col-sm-1">
                    <ul class="clearfix ace-thumbnails">
                        <li id="imgLi" style="border:0px;
                        <c:if test='${!empty m.img }'>display:inline-block</c:if>
                        <c:if test='${empty m.img }'>display: none</c:if>;">
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
            <div class="form-group">
                <label class="control-label col-sm-1 no-padding-right" for="name">项目介绍</label>
                <div class="col-sm-6">
                    <div class="clearfix">
                           <textarea id="editor_id" name="content" style="width:700px;height:300px;">
                               ${m.content}
                           </textarea>
                    </div>
                </div>
            </div>
        </form>
        <div class="row">
            <div class="col-xs-12">
                <label class="col-xs-1"></label>
                <c:if test="${empty m }">
                    <button type="button"
                            onclick="javascript:$('#form').submit();"
                            class="btn btn-success btn-xs">
                        <i class="fa fa-save"></i>&nbsp;
                        添加
                    </button>
                </c:if>
                <c:if test="${!empty m}">
                    <button type="button"
                            onclick="javascript:$('#form').submit();"
                            class="btn btn-success btn-xs">
                        <i class="fa fa-save"></i>&nbsp;
                        保存
                    </button>
                </c:if>
                <button id="btn" type="button" onclick="backList();"
                        class="btn btn-info btn-xs">
                    <i class="fa fa-undo"></i>&nbsp;返回
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
    loadK("editor_id");//初始化富文本编辑框
    $("#type").val(localStorage.getItem("opType"));
    $(function () {
        validateForm();
    });
    function backList() {
        loadPage('/activity/listUI.action');
    }
    function clickImgFile(image_file) {
        $("#" + image_file).click();
    }

    /**
     * 表单验证
     */
    function validateForm() {
        $('#form').validate({
            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            ignore: "",
            rules: {
                title: {
                    required: true
                },
                startTime: {
                    required: true
                },
                endTime: {
                    required: true
                }
            },
            messages: {
                title: {
                    required: "请输入项目标题"
                },
                img: {
                    required: "请上传封面图片"
                },
                startTime: {
                    required: "请选择开始时间"
                },
                endTime: {
                    required: "请选择结束时间"
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
                var uId = $("#id").val();
                var url = "";
                if (uId != undefined) {
                    url = '/activity/update.action';
                } else {
                    url = '/activity/add.action';
                }
                commit('form', url, '/activity/listUI.action');
            }
        });
    }


    function delImg(e) {
        $("#imgUrl").val("");
        $("#img").removeAttr("src");
        $(e).parent().parent().css("display", "none");
        $("#imgProgress").empty();
    }
    function showImg(e) {
        $(e).parent().css("display", "inline-block");
        $("#img").attr("src", $(e).val());
        $("#img").css({"height": "100px", "width": "auto", "max-width": "170px"});
        $(e).blur();
    }


</script>