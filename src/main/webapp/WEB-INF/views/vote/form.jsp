<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@include file="../common/layui.jspf" %>
<%@include file="../common/combotree.jspf" %>
<%@include file="../common/kindeditor.jspf" %>
<style type="text/css">
    body {
        background-color: white;
    }

    li {
        list-style-type: none;
    }

    .st {
        /*width: 91.6%;
        float: right;*/
        padding-top: 5px;
        margin-left: -10px;
    }

    .st li {
        /*	float: left;*/
        margin-top: 18px;
        /*margin-right: 15px;*/
    }

    .st li a {
        float: left;
        margin-left: 5px;
        margin-top: 7px;
    }

    .st li button {
        margin-top: -4px;
    }

    .wt_ {
        margin-top: 5px;
        text-align: right;
    }

    .clear {
        clear: both;
    }

    .checks span {
        float: left;
        margin-top: 8px;
    }

    .checks label {
        float: left;
        margin-top: 5px;
        margin-left: -15px;
    }

    .checks button {
        float: right;
    }

    #for fieldset {
        padding-top: 20px;
    }

    .delWt {
        margin-right: 20px;
        float: right;
        margin-top: 8px;
        font-size: 14px;
    }

    .widget-header {
        border: 0px;
        background-image: none;
        border-bottom: 1px solid #e7e7eb;
    }

    .widget-box {
        border: 1px solid #e7e7eb;
        margin-top: 20px;
    }

    .widget-box input {
        height: 32px;
    }

    .widget-box label {
        font-size: 14px;
    }

    .form-actions {
        background-color: transparent;
        width: 90%;
        margin: auto !important;
        padding-left: 0px !important;
        margin-top: 20px !important;
    }

    .addCon {
        width: 100%;
        height: 42px;
        line-height: 42px;
        text-align: center;
        border: 1px solid #dadbe0;
        margin-top: 50px;
        display: block;
        text-decoration: none !important;
        color: #222 !important;
    }

    .addCon:hover {
        background-color: #E7E7EB;
    }
</style>
<div class="row">
    <div class="col-sm-12">
        <div class="tabbable">
            <ul class="nav nav-tabs" id="myTab">
                <li index="1" class="active"><a data-toggle="tab" href="#fir"> 基本信息</a></li>
                <li index="2"><a data-toggle="tab" href="#sec"> 投票项信息 </a></li>
            </ul>

            <div class="tab-content">
                <div id="fir" class="tab-pane fade in active">
                    <form id="firForm" name="form" class="form-horizontal" role="form"
                          method="post">
                        <input type="hidden" value="${m.id}" id="id" name="id"/>
                        <div class="form-group">
                            <label class="control-label col-sm-1 no-padding-right" for="name">投票标题</label>
                            <div class="col-sm-3">
                                <div class="clearfix">
                                    <input class="form-control" name="title" id="title" type="text"
                                           value="${m.title}" placeholder="投票标题"/>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-1 control-label no-padding-right">时效*</label>
                            <div class="col-sm-2">
                                <div class="clearfix">
                                    <input class="layui-input form-control" placeholder="开始时间" id="LAY_demorange_s"
                                           name="startTime" value="${startTime }">
                                </div>
                            </div>
                            <div style="float: left;">
                                <label class="control-label">至</label>
                            </div>
                            <div class="col-sm-2">
                                <div class="clearfix">
                                    <input class="layui-input form-control" placeholder="结束时间" id="LAY_demorange_e"
                                           name="endTime" value="${endTime }">
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-1 no-padding-right" for="name">每人最大票数</label>
                            <div class="col-sm-1">
                                <div class="clearfix">
                                    <input class="form-control" name="maxUserVote"
                                           <c:if test="${not empty isBegin}">readonly="readonly"</c:if> id="maxUserVote"
                                           type="number"
                                           value="${m.maxUserVote}" placeholder="最大票数"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-1 no-padding-right">是否显示排名</label>
                            <div class="col-sm-2">
                                <div class="clearfix">
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="showRank" value="是" class="ace" <c:if
                                                    test="${m.showRank eq '是'}"> checked="checked"</c:if>>
                                            <span class="lbl">是</span>
                                        </label>
                                        <label>
                                            <input type="radio" name="showRank" value="否" class="ace" <c:if
                                                    test="${m.showRank eq '否'}"> checked="checked"</c:if>>
                                            <span class="lbl">否</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-1 no-padding-right">是否显示票数</label>
                            <div class="col-sm-2">
                                <div class="clearfix">
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="showNum" value="是" class="ace" <c:if
                                                    test="${m.showNum eq '是'}"> checked="checked"</c:if>>
                                            <span class="lbl">是</span>
                                        </label>
                                        <label>
                                            <input type="radio" name="showNum" value="否" class="ace" <c:if
                                                    test="${m.showNum eq '否'}"> checked="checked"</c:if>>
                                            <span class="lbl">否</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-1 no-padding-right" for="name">说明</label>
                            <div class="col-sm-3">
                                <div class="clearfix">
                           <textarea id="editor_id" name="content" style="width:700px;height:300px;">
                               ${m.content}
                           </textarea>
                                </div>
                            </div>
                        </div>
                        <input id="optionStr" name="candidateStr" type="hidden"/>
                    </form>
                </div>
                <div id="sec" class="tab-pane fade">
                    <div class="col-sm-8" style="margin: auto;float: none;">
                        <div id="for">
                            <c:if test="${not empty m}">
                                <c:forEach items="${options}" var="optionItem" varStatus="st">
                                    <input type="hidden" id="optionsSize" value="${options.size()}"/>
                                    <div class="widget-box">
                                        <div class="widget-header">
                                            <h5 class="widget-title">投票项</h5>
                                            <div class="widget-toolbar">
                                                <a href="#" data-action="collapse">
                                                    <i class="ace-icon fa fa-chevron-up"></i>
                                                </a>

                                            </div>
                                        </div>
                                        <div class="widget-body">
                                            <div class="widget-main no-padding">
                                                <form name="optionForm" index=${st.index+1} class="form-horizontal"
                                                      role="form">
                                                    <div class="form-group">
                                                        <input type="hidden" name="id" value="${optionItem.id}"
                                                               id="id${st.index+1}"/>
                                                        <label class="control-label col-sm-1 no-padding-right"
                                                        >图片</label>
                                                        <div class="col-sm-2">
                                                            <div class="clearfix">
                                                                <div style="display: inline-block;">
                                                                    <input name="titleImg${st.index+1}"
                                                                           id="titleImg${st.index+1}"
                                                                           type="hidden" value="${optionItem.img}"/>
                                                                    <a href="" target='_Blank'>
                                                                        <img id="imgUrl${st.index+1}" alt=""
                                                                             src="${optionItem.img}"
                                                                             style="height: 100px;width: auto;<c:if test="${empty optionItem.img}"> display: none</c:if>">
                                                                    </a>
                                                                    <br/><br/>
                                                                </div>
                                                                <button type="button"
                                                                        class="btn btn-primary btn-sm"
                                                                        onclick="initKindImg('titleImg${st.index+1}','imgUrl${st.index+1}')">
                                                                    <i class="fa fa-upload">上传</i>&nbsp;
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-sm-1 no-padding-right"
                                                               for="name">投票信息</label>
                                                        <div class="col-sm-5">
                                                            <div class="clearfix">
                                                                <input class="form-control" id="title${st.index+1}"
                                                                       name="title${st.index+1}"
                                                                       type="text"
                                                                       value="${optionItem.name}" placeholder="投票信息"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                </c:forEach>
                            </c:if>

                            <c:if test="${empty m}">
                                <div class="widget-box">
                                    <div class="widget-header">
                                        <h5 class="widget-title">投票项</h5>

                                        <div class="widget-toolbar">
                                            <a href="#" data-action="collapse">
                                                <i class="ace-icon fa fa-chevron-up"></i>
                                            </a>

                                        </div>

                                    </div>
                                    <div class="widget-body">
                                        <div class="widget-main no-padding">
                                            <form name="optionForm" index="1" class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <input type="hidden" name="id" id="id1"/>
                                                    <label class="control-label col-sm-1 no-padding-right"
                                                    >图片</label>
                                                    <div class="col-sm-2">
                                                        <div class="clearfix">
                                                            <div style="display: inline-block;">
                                                                <input name="titleImg" id="titleImg1"
                                                                       type="hidden"/>
                                                                <a href="" target='_Blank'>
                                                                    <img id="imgUrl1" src=""
                                                                         style="height: 100px;width: auto;">
                                                                </a>
                                                                <br/><br/>
                                                            </div>
                                                            <button type="button"
                                                                    class="btn btn-primary btn-sm"
                                                                    onclick="initKindImg('titleImg1','imgUrl1')">
                                                                <i class="fa fa-upload">上传</i>&nbsp;
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-sm-1 no-padding-right"
                                                           for="name">投票信息</label>
                                                    <div class="col-sm-5">
                                                        <div class="clearfix">
                                                            <input class="form-control" id="title1" name="title1"
                                                                   type="text"
                                                                   value="" placeholder="标题"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    <a href="javascript:void(this);" id="addCon" class="addCon">
                        添加投票项
                    </a>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-1"></label>
            <button id="btnAdd" type="button"
                    onclick="javascript:$('#firForm').submit();"
                    class="btn btn-primary btn-sm">
                <i class="fa fa-save"></i>&nbsp;
                保存
            </button>
            <button id="btn" type="button"
                    onclick="loadPage('/vote/listUI.action')"
                    class="btn btn-info btn-sm">
                <i class="fa fa-undo"></i>&nbsp;返回
            </button>
        </div>
    </div>
</div>

</div>
</div>
<script type="text/javascript">
    /**
     * Created by Administrator on 2017/3/22.
     */

    var temp = 1;
    if($("#optionsSize").val()==undefined){
        temp=1;
    }else{
        temp=$("#optionsSize").val();
    }
    loadK("editor_id");//初始化富文本编辑框

    $(function () {
        validateUserForm();
    });
    function validateUserForm() {
        $('#firForm').validate({
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
                },
                voteNum: {
                    required: true
                },
                content: {
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
                    required: "该信息为必填"
                },
                startTime: {
                    required: "该信息为必填"
                },
                endTime: {
                    required: "该信息为必填"
                },
                content: {
                    required: "该信息为必填"
                },
                startTime: {
                    required: "该信息为必填"
                },
                endTime: {
                    required: "该信息为必填"
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
                submitForm();
            }
        });
    }


    //因为投票信息要处理选项所以不调用公共的表单提交
    function submitForm() {
        var aa = new Array();
        $("form[name='optionForm']").each(function () {
            var obj = new Object();
            var index = $(this).attr("index");
            if ($("#title" + index).val()) {
                obj.name = $("#title" + index).val();
                obj.id = $("#id" + index).val();
                obj.img = $("#titleImg" + index).val();
            }
            aa.push(obj);
        });
        var str = JSON.stringify(aa);
        if (str.length > 5) {
            $("#optionStr").val(JSON.stringify(aa));
        }
        var arr = $("#optionStr").val();
        if (arr) {
            if ($("#id").val() == "") {
                commit("firForm", "/vote/add.action", "/vote/listUI.action");
            } else {
                commit("firForm", "/vote/update.action", "/vote/listUI.action");
            }

        } else {
            alert("请设置投票项");
        }
    }


    /*
     添加新的信息
     * */


    $("#addCon").click(function () {
        temp++;
        $("#for").append(' <div class="widget-box">' +
            ' <div class="widget-header">' +
            '<h5 class="widget-title">投票项</h5>' +
            '<div class="widget-toolbar">' +
            ' <a href="#" data-action="collapse">' +
            ' <i class="ace-icon fa fa-chevron-up"></i>' +
            ' </a>' +
            ' <a href="#" data-action="close">' +
            ' <i class="ace-icon fa fa-times"></i>' +
            ' </a>' +
            '</div>' +
            ' </div>' +
            ' <div class="widget-body">' +
            '<div class="widget-main no-padding" >' +
            '<form name="optionForm"  index="' + temp + '" class="form-horizontal" role="form">' +
            ' <input type="hidden" name="id' + temp + '" id="id' + temp + '"/>' +
            '<div class="form-group">' +
            '<label class="control-label col-sm-1 no-padding-right"' +
            ' >图片</label>' +
            ' <div class="col-sm-2">' +
            '<div class="clearfix">' +
            '<div style="display: inline-block;">' +
            '<input name="titleImg' + temp + '" id="titleImg' + temp + '"' +
            'type="hidden"/>' +
            '   <a href="" >' +
            '  <img id="imgUrl' + temp + '" alt="" src=""' +
            'style="height: 100px;width: auto;">' +
            '   </a>' +
            '  <br/><br/>' +
            '  </div>' +
            ' <button type="button"' +
            'class="btn btn-primary btn-sm"' +
            'onclick="initKindImg(\'titleImg' + temp + '\',\'imgUrl' + temp + '\')">' +
            '   <i class="fa fa-upload">上传</i>&nbsp;' +
            '</button>' +
            '</div>' +
            '</div>' +
            '</div>' +
            '<div class="form-group">' +
            '   <label class="control-label col-sm-1 no-padding-right" for="name">投票信息</label>' +
            '  <div class="col-sm-5">' +
            ' <div class="clearfix">' +
            '<input class="form-control"  id="title' + temp + '" name="title' + temp + '" type="text"' +
            'value="" placeholder="投票信息" />' +
            '   </div>' +
            '  </div>' +
            ' </div>' +
            ' </form></div></div>');
    });
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