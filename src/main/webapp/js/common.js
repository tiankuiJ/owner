// if(localStorage.ROOTPATH == undefined) {
//     localStorage.ROOTPATH = "http://sq.kafeikeji.com:8083/owner/";
// }
// localStorage.ROOTPATH = "http://sq.kafeikeji.com:8083/owner/";

function getRootPath_web() {
   //获取当前网址
   var curWwwPath = window.document.location.href;
   //获取主机地址之后的目录
   var pathName = window.document.location.pathname;
   var pos = curWwwPath.indexOf(pathName);
   //获取主机地址
   var localhostPaht = curWwwPath.substring(0, pos);
   //获取带"/"的项目名
   var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
   return(localhostPaht+projectName+"/");
}
localStorage.ROOTPATH =getRootPath_web();

var bt = baidu.template;
var orgId;


if(getQueryString("orgId") == null){
    orgId = localStorage.orgId;
}else{
    orgId = getQueryString("orgId")
    localStorage.orgId=orgId;
}


//广告列表
$.get(localStorage.ROOTPATH + "adList.xhtml", {
    "orgId": orgId,
    "position":"顶部"
}, function(data) {
    //打印数据
    //console.log(JSON.stringify(data));
    //打印数据
    //渲染页面
    var html = bt('bnr', data);
    $("#banner").html(html);
    //渲染页面
    //轮播动效
    var mySwiper = new Swiper('#lb',{
        pagination : '#lb .swiper-pagination'
        //pagination : '#swiper-pagination1'
    });
    //轮播动效
}, "json");
//广告列表

//截取字符
function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if(r != null) return unescape(r[2]);
    return null;
}
//截取字符

