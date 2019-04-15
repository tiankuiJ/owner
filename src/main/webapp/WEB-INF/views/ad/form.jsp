<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../common/uploader.jspf" %>
<%@include file="../common/layui.jspf" %>
<div class="row" style="margin-top:5px;">
    <div class="col-xs-12">
        <form id="form" name="form" class="form-horizontal" role="form"
              method="post">
            <c:if test="${!empty m}">
                <input type="hidden" name="id" id="id" value="${m.id }">
            </c:if>
            <div class="form-group">
                <label class="control-label col-sm-1 no-padding-right" for="img">封面图*</label>
                <div class="col-sm-2">
                    <div class="clearfix">
                        <ul class="clearfix ace-thumbnails">
                            <li style="border:0px;display:
                            <c:if test='${!empty m.img }'>inline-block</c:if>
                            <c:if test='${empty m.img }'>none</c:if>;">
                                <input name="img" id="imgUrl" type="hidden" value="${m.img }" onclick="showImg(this)"/>
                                <img id="img" src="${m.img }" class="uploader"
                                     style="height: 100px;width: auto;max-width:170px;"/>
                                <div class="tools tools-bottom in" style="height: auto;">
                                    <a href="javascript:void(0)" title="删除" onclick="delImg(this)"> <i
                                            class="ace-icon fa fa-times red"></i></a>
                                </div>
                            </li>
                        </ul>
                        <button id="uploadImgBtn" type="button" onclick="clickImgFile('image_file')"
                                class="btn btn-success btn-xs">
                            <i class="fa fa-upload"></i>&nbsp; 上传
                        </button>
                    </div>
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
                <div class="col-sm-6">
                    <div class="clearfix">
                        <div class="span-help">
							<span class="help-inline"> 
								<span class="middle">
									图片上传说明*<br/>
									建议比例 3：2(长：宽)&nbsp;&nbsp;&nbsp;建议尺寸720 x 480
								</span>
							</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-1 no-padding-right" for="title">标题</label>
                <div class="col-sm-6">
                    <div class="clearfix">
                        <input class="form-control" name="title" type="text"
                               value="${m.title }"/>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-1 no-padding-right"
                       for="position">位置</label>
                <div class="col-sm-2">
                    <div class="clearfix">
                        <select class="form-control" name="position">
                            <option value="顶部"
                                    <c:if test="${empty m or m.position eq '顶部' }">selected="selected"</c:if> >顶部
                            </option>
                            <option value="底部"
                                    <c:if test="${m.position eq '底部' }">selected="selected"</c:if> >底部
                            </option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="form-group" id="urlDiv">
                <label class="control-label col-sm-1 no-padding-right" for="url">地址</label>
                <div class="col-sm-6">
                    <div class="clearfix">
                        <input class="form-control" id="url" name="url" type="text"
                               value="${m.url }"/>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-1 control-label no-padding-right">时效*</label>
                <div class="col-sm-2">
                    <div class="clearfix">
                        <input class="layui-input" placeholder="开始时间" id="LAY_demorange_s"
                               name="startTime" value="${startTime }">
                    </div>
                </div>
                <div style="float: left;">
                    <label class="control-label">至</label>
                </div>
                <div class="col-sm-2">
                    <div class="clearfix">
                        <input class="layui-input" placeholder="结束时间" id="LAY_demorange_e"
                               name="endTime" value="${endTime }">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-1 no-padding-right" for="weight">排序</label>
                <div class="col-sm-2">
                    <div class="clearfix">
                        <input class="form-control" name="weight" type="number"
                               value="${empty m?99:m.weight }" max="999999999"
                               value="${m.weight }"/>
                    </div>
                </div>
            </div>
        </form>
        <div class="row">
            <div class="col-xs-12">
                <label class="col-xs-1"></label>
                <c:if test="${empty m }">
                    <%-- <shiro:hasPermission name="admin:ad:create"> --%>
                    <button type="button"
                            onclick="javascript:$('#form').submit();"
                            class="btn btn-success btn-xs">
                        <i class="fa fa-save"></i>&nbsp;
                        添加
                    </button>
                    <%-- </shiro:hasPermission> --%>
                </c:if>
                <c:if test="${!empty m}">
                    <%-- <shiro:hasPermission name="admin:ad:update"> --%>
                    <button type="button"
                            onclick="javascript:$('#form').submit();"
                            class="btn btn-success btn-xs">
                        <i class="fa fa-save"></i>&nbsp;
                        保存
                    </button>
                    <%-- </shiro:hasPermission> --%>
                </c:if>
                <button id="btn" type="button" onclick="loadPage('/ad/listUI.action')"
                        class="btn btn-info btn-sm">
                    <i class="fa fa-undo"></i>&nbsp;返回
                </button>
            </div>
        </div>
        <form id="img_upload_form" enctype="multipart/form-data" method="post">
            <input type="file" accept="image/gif,image/jpg,image/jpeg,image/png,image/bmp" name="image_file"
                   style="display: none;"
                   id="image_file" onchange="fileSelected(this,'imgProgress','img_upload_form','imgUrl','image');"/>
        </form>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        validateForm();
    });

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
                img: {
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
//                if ($("#url").val() == "") {
//                    layer.msg("请填写地址", {icon: 0});
//                    return;
//                }
                var uId = $("#id").val();
                var url = "";
                if (uId != undefined) {
                    url = '/ad/update.action';
                } else {
                    url = '/ad/add.action';
                }
                commit('form', url, '/ad/listUI.action');
            }
        });
    }
    $(":radio[name='type']").click(function () {
        var val = $(this).val();
        changeDiv(val);
    });



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


    layui.use('laydate', function () {
        var laydate = layui.laydate;

        var start = {
            min: laydate.now(),
            max: '2099-06-16',
            istoday: false,
            istime: true,
            format: 'YYYY-MM-DD',
            choose: function (datas) {
                end.min = datas; // 开始日选好后，重置结束日的最小日期
                end.start = datas // 将结束日的初始值设定为开始日
            }
        };

        var end = {
            min: laydate.now(),
            max: '2099-06-16',
            istoday: false,
            istime: true,
            format: 'YYYY-MM-DD',
            choose: function (datas) {
                start.max = datas; // 结束日选好后，重置开始日的最大日期
            }
        };

        document.getElementById('LAY_demorange_s').onclick = function () {
            start.elem = this;
            laydate(start);
        }
        document.getElementById('LAY_demorange_e').onclick = function () {
            end.elem = this
            laydate(end);
        }

    });
</script>