// common variables
var iBytesUploaded = 0;
var iBytesTotal = 0;
var iPreviousBytesLoaded = 0;
var iMaxFilesize = 1048576; // 1MB
var oTimer = 0;
var sResultFileSize = '';
var close;

function secondsToTime(secs) { // we will use this function to convert seconds in normal time format
	var hr = Math.floor(secs / 3600);
	var min = Math.floor((secs - (hr * 3600)) / 60);
	var sec = Math.floor(secs - (hr * 3600) - (min * 60));

	if(hr < 10) {
		hr = "0" + hr;
	}
	if(min < 10) {
		min = "0" + min;
	}
	if(sec < 10) {
		sec = "0" + sec;
	}
	if(hr) {
		hr = "00";
	}
	return hr + ':' + min + ':' + sec;
};

function bytesToSize(bytes) {
	var sizes = ['Bytes', 'KB', 'MB'];
	if(bytes == 0) return 'n/a';
	var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
	return(bytes / Math.pow(1024, i)).toFixed(1) + ' ' + sizes[i];
};
var upNumber = 0;

var upNum = [];
var img = "file";
function setjd(name, dem, ele,type) {
	upNumber++;
	if(name.length > 20) {
		name = name.substring(0, 21) + "...";
	}
	if(type == "file") {
		img = "file";
		str = "请选择本地文件";
	} else if(type == "image") {
		img = "image";
		str = "请选择本地图片";
		$(ele).attr("accept","image/png,image/gif,image/jpeg");
	} else {
		img = "media";
		str = "请选择本地视频";
		$(ele).attr("accept","audio/mp4, video/mp4");
	}
	var html = '<div class="upload_list">' +
		'<span style="float:left;width:100%;">' + name + '<div class="progress_percent" id="progress_percent' + upNumber + '">100%</div></span>' +
		'<span class="uploadlist_close"></span>' +
		'<div id="progress' + upNumber + '" class="progress" style="display: block; width: 345px;margin-top: 10px;"></div>' +
		'<div class="upload_list_info">' +
		'<label id="speed' + upNumber + '"></label>' +
		'<label id="remaining' + upNumber + '"></label>' +
		'<span id="b_transfered' + upNumber + '"></span>' +
		'</div>' +
		'<div style="clear: both;">' +
		'</div>' +
		'</div>';
	$("#" + dem).append(html);

}

function fileSelected(ele, dem, fro, markImg,type) {
	$("#" + dem).html("");
	var oFile = document.getElementById(ele.id).files[0];
	close = ele;
	setjd(oFile.name, dem, ele,type);
	$("#upload_jd").fadeIn();
	$("#upload_popup").fadeOut();
	$("#upload_popup").remove();
	startUploading(fro, ele, markImg,dem,upNumber,type);
}

function startUploading(fro, ele, markImg,dem,num,type) {
	// cleanup all temp states
	iPreviousBytesLoaded = 0;
	var oProgress = document.getElementById('progress' + upNumber);
	oProgress.style.display = 'block';
	oProgress.style.width = '0px';

	// get form data for POSTing
	//var vFD = document.getElementById('upload_form').getFormData(); // for FF3
	//	var vFD = new FormData(document.getElementById(fro));
	//	console.log(vFD);
	var vFD = new FormData();
	vFD.append("img", $(ele).get(0).files[0]);
	var imgSrc = $(ele).get(0).files[0];
	//	$.ajax({
	//		type: "POST",
	//		url: "http://mzxf.my.gov.cn/upload/upload.xhtml",
	//		data: vFD,
	//		cache: false,
	//		contentType: false,
	//		processData: false,
	//		dataType: "json",
	//		error: function(request) {},
	//		success: function(data) {
	//			console.log(JSON.stringify(data));
	//		},
	//		complete:function(event){
	//			console.log(event);
	//			uploadProgress(event, upNumber);
	//		}
	//	});
	//create XMLHttpRequest object, adding few event listeners, and POSTing our data
	var oXHR = new XMLHttpRequest();
	var data = "";
	oXHR.upload.addEventListener('progress', function(event) {
		uploadProgress(event, upNumber, imgSrc, markImg,dem);
	}, false);
	oXHR.addEventListener('load', uploadFinish, false);
	oXHR.addEventListener('error', uploadError, false);
	oXHR.addEventListener('abort', uploadAbort, false);
	oXHR.onreadystatechange = function() {
		if(oXHR.readyState == 4) {
			//数据加载完成
			//callback(oXHR.responseText);
			try{
                var url = JSON.parse(oXHR.responseText);

                if(url.error==0){
                    for(var i = 0; i < tupian.length; i++) {
                        if(tupian[i].imgSrc == imgSrc) {
                            document.getElementById('remaining' + tupian[i].isnumber).innerHTML = '上传完成';
                            $("#"+tupian[i].markImg).val(url.url);
                            console.log(type);
                            if(type == 'media'){
                                $("#"+tupian[i].markImg).focus();
                                $("#"+tupian[i].markImg).blur();
                                showVideo($("#"+tupian[i].markImg));
							}else{
                                $("#"+tupian[i].markImg).click();
                            }
                            $("#"+tupian[i].dem).empty();
                            tupian.splice(i,1);
                            layer.msg('上传成功');
                        }
                    }
                }
			}catch(e){

			}

		}
	};
	//	oXHR.onload = function(e) {
	//		var data = oXHR.responseText;
	//		e = e || event;
	//		if(xhr.status == 200) {
	//			console.log(data)
	//		}
	//	};
	// oXHR.open('POST', 'http://211.149.204.181:8090/admin/upload/upload.xhtml?dir='+img, true);
	// oXHR.open('POST', 'http://mzxfweb.my.gov.cn/upload/upload.xhtml?dir='+img, true);
	oXHR.open('POST', sys.rootPath+'/upload/upload.action?dir='+img, true);
	oXHR.send(vFD);

	$(".upload_list").click(function() {
		$(this).remove();
		$("#" + close.id).val("");
        $(ele).val("");
        for(var i = 0; i < tupian.length; i++) {
            if(tupian[i].imgSrc == imgSrc) {

                tupian.splice(i,1);
            }
        }
        oXHR.abort();
	});

	return data;
}

var tupian = [];

function uploadProgress(e, umNumber, src, markImg,dem) { // upload process in progress
	if(e.lengthComputable && document.getElementById('progress_percent' + umNumber)) {
		//console.log(e);
		//		console.log(JSON.stringify(e));
		iBytesUploaded = e.loaded;
		iBytesTotal = e.total;
		var isTrue = false;
		for(var i = 0; i < tupian.length; i++) {
			if(tupian[i].isbytestotal == iBytesTotal) {
				isTrue = true;
				umNumber = tupian[i].isnumber;
			}
		}
		if(!isTrue) {
			var data = {
				"isnumber": umNumber,
				"isbytestotal": iBytesTotal,
				"imgSrc": src,
				"markImg": markImg,
				'dem':dem
			};
			tupian.push(data);
		}
		var iPercentComplete = Math.round(e.loaded * 100 / e.total);
		var iBytesTransfered = bytesToSize(iBytesUploaded);
		console.log(umNumber);
		document.getElementById('progress_percent' + umNumber).innerHTML = iPercentComplete.toString() + '%';
		document.getElementById('progress' + umNumber).style.width = (iPercentComplete * 3.3).toString() + 'px';
		document.getElementById('b_transfered' + umNumber).innerHTML = iBytesTransfered;

		var iCB = iBytesUploaded;
		var iDiff = iCB - iPreviousBytesLoaded;

		// if nothing new loaded - exit
		if(iDiff == 0)
			return;

		iPreviousBytesLoaded = iCB;
		iDiff = iDiff * 2;
		var iBytesRem = iBytesTotal - iPreviousBytesLoaded;
		var secondsRemaining = iBytesRem / iDiff;
		// update speed info
		var iSpeed = iDiff.toString() + 'B/s';
		if(iDiff > 1024 * 1024) {
			iSpeed = (Math.round(iDiff * 100 / (1024 * 1024)) / 100).toString() + 'MB/s';
		} else if(iDiff > 1024) {
			iSpeed = (Math.round(iDiff * 100 / 1024) / 100).toString() + 'KB/s';
		}

		document.getElementById('speed' + umNumber).innerHTML = iSpeed;
		document.getElementById('remaining' + umNumber).innerHTML = ' 剩余时间:' + secondsToTime(secondsRemaining);
	} else {
		//document.getElementById('progress').innerHTML = 'unable to compute';
	}
}

function uploadFinish(e) { // upload successfully finished
	if(document.getElementById('progress_percent')) {
		document.getElementById('progress_percent').innerHTML = '100%';
		document.getElementById('progress').style.width = '345px';
		clearInterval(oTimer);
	}
}

function uploadError(e) { // upload error
	//document.getElementById('error2').style.display = 'block';
	clearInterval(oTimer);
}

function uploadAbort(e) { // upload abort
	//document.getElementById('abort').style.display = 'block';
	clearInterval(oTimer);
}

function clickImgFile(image_file){
	$("#"+image_file).click();
}