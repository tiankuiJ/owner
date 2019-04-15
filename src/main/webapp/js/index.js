//3登录
    //验证码
$(".yzCode input[type=text]").css("padding-right", "120px");
    //点击获得倒计时
$("#getYzm").click(function() {
    yzm();
    $("#login .code").removeClass("orange").addClass("gray");
});
    //倒计时
var time = 10;
function yzm() {
    if(time < 2) {
        $("#login .code").addClass("orange").removeClass("gray");
        $("#getYzm").html("获取验证码");
        time = 10;
        return;
    }
    time--;
    //console.log(time);
    $("#getYzm").html(time + "(s)");
    setTimeout(function() {
        yzm();
    }, 1000);
}
//3登录
