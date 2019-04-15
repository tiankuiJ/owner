<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@include file="../common/uploader.jspf" %>
<%@include file="../common/layui.jspf" %>
<style type="text/css">
    ul,
    li {
        list-style: none;
    }

    p {
        display: block;
        -webkit-margin-before: 0em !important;
        -webkit-margin-after: 0em !important;
        -webkit-margin-start: 0px;
        -webkit-margin-end: 0px;
    }

    .top_infos {
        padding: 20px;
        border-radius: 3px;
        border: 1px solid rgb(228, 228, 228);
        min-width: 120px;
        float: left;
        margin: 0;
        margin-top: 10px;

    }

    .top_infos li > span {
        width: 100px;
        display: inline-block;
        font-size: 16px;
        color: #666666;
    }

    .top_infos li > p {
        display: inline-block;
        font-size: 12px !important;
        color: #999;
        margin-left: 10px;
    }

    .top_infos hr {
        border: 0;
        border-bottom: 1px solid rgb(228, 228, 228);
    }

    .top_infos label {
        min-width: 105px;
        display: inline-block;
        font-size: 13px !important;
        color: #666;
        margin-top: 10px;
    }

    .top_infos label > span {
        font-size: 20px;
        display: inline-block;
        margin-top: 10px;
    }

    .top_infost label {
        margin-right: 30px;
        min-width: 90px !important;
    }
</style>
<div class="row">
    <div class="col-sm-12">
        <h4 class="m-t">
            <button class="btn-sm  btn_ col-xs-1" type="button" onclick="backInfo()">
                <i class="ace-icon glyphicon glyphicon-backward"></i>返回列表
            </button>
            <div class="col-xs-2">
                <select name="stageId" id="bBusiness" onchange="changeXiao();" style="display: none;"
                        class="form-control">
                </select>
            </div>
            <label hidden="hidden" class="col-xs-8" style="padding-top: 7px;"> 参加业主总面积:<font color="red"
                                                                                             id="sum">0</font></label>

            <%--<div style="float: right;padding-right: 3px;">--%>
                <%--<input class="col-xs-8" type="text" id="searchInput"--%>
                       <%--placeholder="关键字搜索" style="height: 32px;">--%>
                <%--<button class="btn btn-sm btn_" onclick="searchStr()" type="button">--%>
                    <%--<i class="ace-icon glyphicon glyphicon-search"></i>查询--%>
                <%--</button>--%>
            <%--</div>--%>
            <br/>
            <br/>
            <ul class="top_infos" style="width: 380px;margin-right: 30px;display: none" id="div1">
                <li>
                    <span style="width: 80px;">表决统计</span>
                    <p id="userCount">参与人数：0人</p>
                    <p id="orgType"> 社区/小区总面积：0㎡</p>

                    <hr/>
                </li>
                <li>
                    <label>
                        同意
                        <br/>
                        <span id="agreenUserCount">0</span>人
                    </label>
                    <label>
                        反对
                        <br/>
                        <span id="rejectUserCount">0</span>人
                    </label>
                    <label>
                        弃权
                        <br/>
                        <span id="giveUpUserCount">0</span>人
                    </label>
                </li>

            </ul>

            <ul class="top_infos top_infost" style="width: 620px;display: none" id="div2">
                <li>
                    <span>同意投票统计</span>
                    <hr/>
                </li>
                <li>
                    <label>
                        同意人数
                        <br/>
                        <span id="agreeUserCountt">0</span>人
                    </label>
                    <label>
                        占投票总人数比例
                        <br/>
                        <span id="agreenCountScale">0%</span>
                    </label>
                    <label>
                        同意业主建筑面积
                        <br/>
                        <span id="agreenSum">0㎡</span>
                    </label>
                    <label style="margin-right:0px">
                        占总建筑物总面积比例
                        <br/>
                        <span id="agreenSumScale">0%</span>
                    </label>
                </li>

            </ul>

            <div style="clear:both ;"></div>

        </h4>

        <div class="jqGrid_wrapper" id="tt" style="">
            <table id="jsonmap"></table>
            <div id="pjmap"></div>
        </div>
        <div id="biaojueDiv" style="margin-top: 10px" hidden="hidden">
            同意业主总面积:<font color="red" id="agreen">0</font>&nbsp;&nbsp;&nbsp;<font color="red"
                                                                                  id="agreens">0%</font><br/>
            反对业主总面积:<font color="red" id="reject">0</font>&nbsp;&nbsp;&nbsp;<font color="red"
                                                                                  id="rejects">0%</font><br/>
            弃权业主总面积:<font color="red" id="giveUp">0</font>&nbsp;&nbsp;&nbsp;<font color="red" id="giveUps">0%</font>
        </div>
    </div>


</div>

<div class="modal fade" id="dialog" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                </button>
                <h4 class="modal-title">详情</h4>
            </div>
            <div class="modal-body">
                <div class="col-sm-12" style="margin-top: 10px;margin-bottom: 10px;">
                    <label class="col-sm-2">详情:</label>
                    <label class="col-sm-10" id="logContent"></label>
                </div>
                <div class="col-sm-12" style="margin-top: 10px;margin-bottom: 10px;">
                    <label class="col-sm-2">图片:</label>
                    <div class="col-sm-12" id="imgDiv" style="overflow-y: auto;">

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-info btn-sm" data-dismiss="modal">
                        关闭
                    </button>
                </div>

            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

    var sumArr;
    var baseOid;

    if (localStorage.getItem("op") == '表决') {
        if (localStorage.getItem("bjids") != "null" && localStorage.getItem("bjids").length > 0) {
            $.ajax({
                url: sys.rootPath + "/opInfo/selectByIds.action?ids=" + localStorage.getItem("bjids"),
                type: 'get',
                dataType: 'json',
                async: false,//使用同步的方式,true为异步方式
                success: function (data) {
                    var htmlStr = '';
                    for (var i = 0; i < data.length; i++) {
                        if (i == 0) {
                            localStorage.setItem("oid", data[i].id);
                        }
                        htmlStr += '<option value="' + data[i].id + '"><font><font>' + data[i].title + '</font></font></option>';
                    }
                    $("#bBusiness").html(htmlStr);
                },
            });
            $("#bBusiness").css("display", "inline-block");
        }
        $("#jsonmap").jqGrid({
            url: sys.rootPath + '/regRecord/regRecordList.action?opId=' + localStorage.getItem("oid"),
            datatype: "json",
            mtype: "GET",
            colNames: ['ID', '', '业主姓名', '业主电话', '面积', '观点', '参加时间', '操作'],
            colModel: [
                {name: 'id', index: 'id', key: true, width: 1, align: 'center'},
                {name: 'userId', index: 'id', hidden: true, width: 1, align: 'center'},
                {name: 'ownerName', sortable: false, width: 2},
                {name: 'ownerPhone', sortable: false, width: 2, align: 'center'},
                {name: 'acreage', index: "b.acreage", sortable: true, width: 1, align: 'center'},
                {
                    name: 'choice',
                    index: "a.choice",
                    sortable: true,
                    width: 1,
                    formatter: formaterChoice,
                    align: 'center'
                },
                {name: 'createTime', sortable: false, width: 2, align: 'center'},
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
        initAllData();
    }else{
        $("#jsonmap").jqGrid({
            url: sys.rootPath + '/regRecord/regRecordList.action?opId=' + localStorage.getItem("oid"),
            datatype: "json",
            mtype: "GET",
            colNames: ['ID', '', '业主姓名', '业主电话', '面积', '参加时间', '操作'],
            colModel: [
                {name: 'id', index: 'id', key: true, width: 1, align: 'center'},
                {name: 'userId', index: 'id', hidden: true, width: 1, align: 'center'},
                {name: 'ownerName', sortable: false, width: 2},
                {name: 'ownerPhone', sortable: false, width: 2, align: 'center'},
                {name: 'acreage', index: "b.acreage", sortable: true, width: 1, align: 'center'},
                {name: 'createTime', sortable: false, width: 2, align: 'center'},
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
        initAllData();
    }

    function changeXiao() {
        localStorage.setItem("oid", $("#bBusiness").val());
        initAllData();
    }

    function backInfo() {
        var from = localStorage.getItem("from");
        if (from == "info") {
            loadPage("/info/listUI.action", "公告列表");
        } else if (from == "biaojue") {
            loadPage("/opInfo/listUI.action?type=biaojue", "表决管理");
        } else if (from == "baoming") {
            loadPage("/opInfo/listUI.action?type=baoming", "报名管理");
        } else if (from == "yijian") {
            loadPage("/opInfo/listUI.action?type=yijian", "意见管理");
        }
    }

    function initAllData() {
        $("#jsonmap").jqGrid('setGridParam', {
            url: sys.rootPath + '/regRecord/regRecordList.action?opId=' + localStorage.getItem("oid"),
            datatype: 'json',
            page: 1
        }).trigger("reloadGrid");
        var joinUserSum=0;
        //获取参加活动人的总面积
        $.get(sys.rootPath + "/regRecord/selectSumAcreageByInfo.action", {
            opId: localStorage.getItem("oid"),
        }, function (data) {
            if (data.success) {
                sumArr = data.data;
                $("#sum").text(data.data);
            }
        }, "json");
        if (localStorage.getItem("op") == "表决") {
            $(".top_infos").show();
            $("#tt").css("padding-top", "10px");
            //获取活动所属机构所有人总面积
            $.get(sys.rootPath + "/selectSumAcreage.action", {
                orgId: localStorage.getItem("orgId"),
            }, function (data) {
                if (data.success) {
                    //获取活动所属机构类型
                    $.get(sys.rootPath + "/selectOrgType.action", {
                        orgId: localStorage.getItem("orgId"),
                    }, function (d) {
                        if (d.success) {
                            $("#orgType").text(d.data + "总面积" + data.data + "㎡");
                        }
                    }, "json");
                }
            }, "json");

            //获取参加人数分组
            $.get(sys.rootPath + "/regRecord/selectBioaJueUserCount.action", {
                opId: localStorage.getItem("oid"),
            }, function (data) {
                if (data.success) {
                    $("#agreenUserCount").text(data.data.agreenUserCount);
                    $("#agreeUserCountt").text(data.data.agreenUserCount);
                    if (((parseInt(data.data.agreenUserCount) / parseInt(data.data.userCount)) * 100).toFixed(2) != "NaN") {
                        $("#agreenCountScale").text(((parseInt(data.data.agreenUserCount) / parseInt(data.data.userCount)) * 100).toFixed(2) + "%");
                    }
                    $("#rejectUserCount").text(data.data.rejectUserCount);
                    $("#giveUpUserCount").text(data.data.giveUpUserCount);
                    $("#userCount").text("参与人数:" + data.data.userCount);
                }
            }, "json");
            $.get(sys.rootPath + "/regRecord/selectAcreageBiaoJue.action", {
                opId: localStorage.getItem("oid"),
            }, function (data) {
                if (data.data.length > 0) {
                    for (var i = 0; i < data.data.length; i++) {
                        var temp = data.data[i];
                        var sum = parseInt(sumArr);
                        if (temp.choice == "同意") {
                            $("#agreenSum").text(temp.acreage + "㎡");
                            if (((parseInt(temp.acreage) / parseInt(sum)) * 100).toFixed(2) != "NaN") {
                                $("#agreenSumScale").text(((parseInt(temp.acreage) / parseInt(sum)) * 100).toFixed(2) + "%");
                            }

                        }
                    }
                }
            }, "json");
        } else {
//        $("#tt").css("margin-top","0px");
        }
    }


    $("#jsonmap").jqGrid('navGrid', '#pjmap', {edit: false, add: false, del: false, search: false});
    function formaterOpretion(cellvalue, options, rowdata) {
        var a = '<a href="javascript:void(0)" title="详情" onclick="showDialog(' + rowdata.userId + ');" class="tab_a"><i class="ace-icon glyphicon glyphicon-edit"></i></a>&nbsp;&nbsp;';
        return a;
    }

    function formaterChoice(cellvalue, options, rowdata) {
        if (rowdata.choice) {
            return rowdata.choice;
        }
        return "";
    }

    function showDialog(id) {
        $("#imgDiv").html("");
        $.get(sys.rootPath + "/regRecord/regRecordDetail.action", {
            opId: localStorage.getItem("oid"),
            userId: id
        }, function (data) {
            if (data.success) {
                $("#logContent").text(data.data.content);
                if (data.data.imgs) {
                    var arr = new Array(); //定义一数组
                    arr = data.data.imgs.split(",")
                    if (arr.length > 0) {
                        var imgStr = "";
                        for (var i = 0; i < arr.length; i++) {
                            imgStr += ' <div style="margin-left: 40px;background: rgba(0,0,0,0.5);margin-bottom:20px;width: 200px;float: left; height: 180px;max-width:500px;overflow: hidden; margin-right:10px; display: -webkit-box; display: -ms-flexbox; display: -webkit-flex;display: flex; -webkit-box-pack: center;-ms-flex-pack: center;-webkit-justify-content: center;justify-content: center;-webkit-box-align: center;-ms-flex-align: center;-webkit-align-items: center;align-items: center;"><img src="' + arr[i] + '" style="width:100%;"> </div>';
                        }
                        $("#imgDiv").html(imgStr);
                    }
                } else {
                    $("#imgDiv").html("无图片");
                }
            }
        }, "json");
        $("#dialog").modal("show")

    }

    function hideDialog() {
        $("#dialog").hide();
    }


</script>

