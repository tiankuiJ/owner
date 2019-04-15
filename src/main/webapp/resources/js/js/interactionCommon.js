/**
 * 互动模块公共js文件
 * Created by Administrator on 2017/3/22.
 */

var havePid=false;
var noReview=true;
var otherOrgData=false;

// try {//初始化下推机构选择树
//     $('#tt').tree({
//         url:sys.rootPath+"/siteInfo/getChildrenListSelf.xhtml",
//         checkbox:true
//     });
// }catch (err){
//
// }

//初始化日期选择框
function initDateInput() {
    layui.use('laydate', function() {
        var laydate = layui.laydate;

        var start = {
            min : laydate.now(),
            max : '2099-06-16 23:59:59',
            istoday : false,
            istime : true,
            format : 'YYYY-MM-DD hh:mm:ss',
            // choose : function(datas) {
            //     end.min = datas; // 开始日选好后，重置结束日的最小日期
            //     end.start = datas // 将结束日的初始值设定为开始日
            // }
        };

        var end = {
            min : laydate.now(),
            max : '2099-06-16 23:59:59',
            istoday : false,
            istime : true,
            format : 'YYYY-MM-DD hh:mm:ss',
            // choose : function(datas) {
            //     start.max = datas; // 结束日选好后，重置开始日的最大日期
            // }
        };

        try {
            try {
                document.getElementById('endTime').onclick = function() {
                    end.elem = this
                    laydate(end);
                }
            }catch (err){

            }


            document.getElementById('startTime').onclick = function() {
                start.elem = this;
                laydate(start);
            }


            document.getElementById('signStartTime').onclick = function() {
                start.elem = this;
                laydate(start);
            }
            document.getElementById('signEndTime').onclick = function() {
                end.elem = this
                laydate(end);
            }
        }catch (err){

        }

    });
}


//初始化日期选择框
function initActivityDateNoTimeInput() {
    layui.use('laydate', function() {
        var laydate = layui.laydate;

        var start = {
            min : laydate.now(),
            max : '2099-06-16',
            istoday : false,
            istime : true,
            format : 'YYYY-MM-DD',
        };

        var end = {
            min : laydate.now(),
            max : '2099-06-16',
            istoday : false,
            istime : true,
            format : 'YYYY-MM-DD',
        };

        try {
            try {
                document.getElementById('endTime').onclick = function() {
                    end.elem = this
                    laydate(end);
                }
            }catch (err){

            }


            document.getElementById('startTime').onclick = function() {
                start.elem = this;
                laydate(start);
            }


            document.getElementById('signStartTime').onclick = function() {
                start.elem = this;
                laydate(start);
            }
            document.getElementById('signEndTime').onclick = function() {
                end.elem = this
                laydate(end);
            }
            document.getElementById('createTime').onclick = function() {
                end.elem = this
                laydate(end);
            }
        }catch (err){

        }

    });
}



/**
 * 获取参加人群字符串
 */
function getCheckBoxValueStr(checkBoxName) {
    if($('#personType').val()==undefined){
        return "1";
    }
    var personType=new Array();
    $('input[name="'+checkBoxName+'"]:checked').each(function(){
        personType.push($(this).val());//向数组中添加元素
    });
    var typeStr=personType.join('-');//将数组元素连接起来以构建一个字符串
    if(!typeStr){
        alert("至少选择一种参加人群");
        return;
    }
    typeStr="-"+typeStr;
    $('#personType').val(typeStr);
    return typeStr;
}

//格式化浏览量点赞数
function formaterViewZan(cellvalue,options,rowObject){
    return rowObject.viewNum + '/' + rowObject.commentNum +'/'+rowObject.zanNum;
}

//格式化列表头像图片
function formaterHeadImg(cellvalue, options, rowdata) {
    return ' <img src="' + rowdata.headImg + '"  style="width:70px;height:50px;" />';
}

//格式化操作按钮
function formaterOpretion(cellvalue, options, rowdata) {
   var a =  '<a href="#" onclick="editUI('+rowdata.id+',\''+rowdata.type+'\');" class="tab_a"><i class="ace-icon glyphicon glyphicon-edit"></i></a>'
    // if(rowdata.status=='审核中' && !rowdata.pId){
    //     a +='<a data-toggle="modal" data-target="#rejectModdal"  href="#" onclick="reject('+rowdata.id+','+rowdata.orgId+');" class="tab_a"><i class="ace-icon glyphicon glyphicon-remove"></i></a>';
    // }
    return a;
}


//获取表格选中数据id数组
function getSelectDataIds() {
    var list = $("#jsonmap").jqGrid("getGridParam", "selarrrow");
    var idList = new Array();
    if (list.length > 0) {
        for (var i = 0; i < list.length; i++) {
            var rowData = $("#jsonmap").jqGrid('getRowData', list[i]);
            if(rowData.pId){
                havePid=true;
            }
            if(rowData.orgId && rowData.orgId!=currentSiteId)
                otherOrgData=true;
            if(rowData.status!='审核中'){
                noReview=false;
            }
            idList.push(rowData.id);
        }
    }
    return idList;
}


//获取表格选中数据id和父id数组
function getSelectDataIdAndPids() {
    var list = $("#jsonmap").jqGrid("getGridParam", "selarrrow");
    var idList = new Array();
    if (list.length > 0) {
        for (var i = 0; i < list.length; i++) {
            var rowData = $("#jsonmap").jqGrid('getRowData', list[i]);
            var obj=new Object();
            obj.id=rowData.id;
            if(rowData.orgId!=currentSiteId)
                otherOrgData=true;
            obj.pId=rowData.pId;
            idList.push(obj);
        }
    }
    return idList;
}
//刷新表格
function reloadGrid() {
    $("#jsonmap").trigger("reloadGrid");
}


//确认驳回
function comfirmReject(url) {
    if(otherOrgData==true){
        otherOrgData=false;
        layer.msg("所选信息包含上级公开信息,不能驳回", {icon: 5});
        return;
    }
    var tempReject = $("#reject").val();
    if(tempReject){
        $.ajax({
            type: "GET",
            // url: sys.rootPath + "/adminActivity/rejectActivity.xhtml",
            url: sys.rootPath +url,
            data: {
                "reject": $("#reject").val(),
                "id":selectId
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
    }else{
        var idList = getSelectDataIds();
        $.ajax({
            type: "GET",
            url: sys.rootPath +url,
            data: {
                "ids":idList
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
    }
    $("#reject").val("");

}


//批量删除
function deleteBatch(url) {
    var idList = getSelectDataIds();
    if(idList.length<1){
        layer.msg("请选择批量操作的记录", {icon: 5});
        return;
    }
    if(havePid==true){
        havePid=false;
        layer.msg("所选信息包含下级上推信息,不能删除", {icon: 5});
        return;
    }
    if(otherOrgData==true){
        otherOrgData=false;
        layer.msg("所选信息包含上级公开信息,不能删除", {icon: 5});
        return;
    }
    layer.confirm('确认删除吗？', {icon: 3, title: '删除提示'}, function (index, layero) {
        $.ajax({
            type: "POST",
            url:sys.rootPath+url,
            data: {
                "ids": idList,
                "operation": "delete"
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


//批量审核
function reviewBatch(url) {
    var idList = getSelectDataIds();
    if(idList.length<1){
        layer.msg("请选择批量操作的记录", {icon: 5});
        return;
    }
    if(!noReview){
        noReview=true;
        layer.msg("所选数据包含状态不为未审核数据,请重新选择", {icon: 5});
        return;
    }
    if(havePid==true){
        havePid=false;
        layer.msg("所选信息包含下级上推信息,没有权限审核", {icon: 5});
        return;
    }
    if(otherOrgData==true){
        otherOrgData=false;
        layer.msg("所选信息包含上级公开信息,没有权限审核", {icon: 5});
        return;
    }
    layer.confirm('是否通过该信息审核？', {icon: 1, title: '审核提示'}, function (index, layero) {
        $.ajax({
            type: "POST",
            url:sys.rootPath+url,
            data: {
                "ids": idList,
                "operation": "review"
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
/**
 * 得到投票选项json数组
 * @param divId input父divid
 */
function getOptionStr(divId) {
    var arr = new Array();
    $("#"+divId+" input").each(function(){
        if($(this).val()){
            var obj = new Object();
            obj.content=$(this).val();
            arr.push(obj);
        }
    });
    if(arr.length<1){
        alert("请添加选项");
        return;
    }
    return arr;
}


/**
 * 互动模块提交表单
 * @param formId 表单id
 * @param submitUrl 提交url地址
 * @param backUrl 提交成功返回地址
 */
function submitFormCommon(formId,submitUrl,backUrl) {
    var typeStr=getCheckBoxValueStr("form-field-checkbox")
    if(!typeStr){
        return;
    }
    $('#personType').val(typeStr);

    // if($('#firCbox').is(':checked')){
    //     $("#isComment").val("1");
    // }else{
    //     $("#isComment").val("0");
    // }
    commit(formId,submitUrl,backUrl);
}

/**
 * 批量上推信息
 * @param type 想要上推的类型
 */
function  upPushBatch(type) {
    var list = getSelectDataIdAndPids();
    if(list.length<1){
        layer.msg("请选择想要上推给上级的信息", {icon: 5});
        return;
    }
    if(otherOrgData==true){
        otherOrgData=false;
        layer.msg("所选信息包含上级公开信息,不能上推", {icon: 5});
        return;
    }
    $.ajax({
        type: "GET",
        url:sys.rootPath+"/adminPush/upPushBatch.xhtml",
        data: {
            "idAndPids": JSON.stringify(list),
            "type": type
        },
        dataType: "json",
        success: function (data) {
            if (data.success) {
                layer.msg(data.message, {icon: 1});
            } else {
                layer.msg(data.message, {icon: 5});
            }
        }
    });
}
/**
 * 批量下推信息
 */
function downPushBatch(type) {
    var infoIdList = getSelectDataIdAndPids();
    if(infoIdList.length<1){
        layer.msg("请选择想要下推的内容", {icon: 5});
        return;
    }
    var orgIdsArr = new Array();
    var orgIds =  $('#tt').tree('getChecked');
    for(var i=0;i<orgIds.length;i++){
        orgIdsArr.push(orgIds[i].id);
    }
    if(orgIdsArr.length<1){
        layer.msg("请选择下级机构", {icon: 5});
        return;
    }
    $.ajax({
        type: "GET",
        url:sys.rootPath+"/adminPush/downPushBatch.xhtml",
        data: {
            "idAndPids": JSON.stringify(infoIdList),
            "orgIds":orgIdsArr,
            "type": type
        },
        dataType: "json",
        success: function (data) {
            if (data.success) {
                layer.msg(data.message, {icon: 1});
            } else {
                layer.msg(data.message, {icon: 5});
            }
        }
    });
}
function changeCss(index) {
    $("#myTab li").removeClass("active");
    $("#myTab li[index="+index+"]").addClass("active");

}

$("#delImg").click(function () {
    var img = $("#titleImg").val();
    if(img != null && img != undefined && img.trim() != ''){
    }
    $("#titleImg").val("");
    $("#showImg").html("");
});


function getStorageId(idName) {
    return localStorage.getItem(idName);
}


function showImg(e){
    $(e).parent().css("display","inline-block");
    $("#img").attr("src",$(e).val());
    $("#img").parent().attr("href",$(e).val());
    $("#img").css({"height":"100px","width":"auto","max-width":"170px"});
    $(e).blur();
}
function delImg(e){
    $("#imgUrl").val("");
    $("#img").removeAttr("src");
    $(e).parent().parent().css("display","none");
    $("#imgProgress").empty();
}