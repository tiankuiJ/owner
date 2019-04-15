var editor;
KindEditor.ready(function(K) {
	editor = K.editor({
		allowFileManager : true,
		uploadJson : sys.rootPath + '/upload/upload.action'
	});
});

//单图片上传弹出框
function initKindImg(input,img) {
	editor.loadPlugin('image', function() {
		editor.plugin.imageDialog({
//			showRemote : false,
			clickFn : function(url, title, width, height, border, align) {
				$('#' + input).val(url);
				$("#"+img).attr("src",url);
				$("#"+img).parent("a").attr("href",url);
				$("#"+img).parent("a").parent("div").css("display","block");
				editor.hideDialog();
			}
		});
	});
}

function newInitKindImg(input) {
    editor.loadPlugin('image', function() {
        editor.plugin.imageDialog({
            clickFn : function(url, title, width, height, border, align) {
                $('#' + input).val(url);
                jQuery("#showImg").html('<img width="100px" height="67px" src="'+url+'"/>');
                editor.hideDialog();
            }
        });
    });
}

//多图片上传弹出框
function initKindImgs(input,imgDiv) { 
  editor.loadPlugin('multiimage', function () {
      editor.plugin.multiImageDialog({
          clickFn: function (urlList) {  
              var div = $('#' + imgDiv);
              $.each(urlList, function (i, data) {
            	  div.append("<li><a href='"+data.url+"' class='cboxElement' target='_Blank'>" +
            	  		"<img style='height:100px;width:auto;' src='"+data.url+"'></a></li>");
                  var url = $("#"+input).val();
                  if(url==""){
                	  url = data.url;
                  }else{
                	  url = url+","+data.url;
                  }
                  $("#"+input).val(url);
              });
              editor.hideDialog();
          }
      });
  });
}

function initKindImgsTwo(imgDiv) {
	  editor.loadPlugin('multiimage', function () {
	      editor.plugin.multiImageDialog({
	          clickFn: function (urlList) {  
	              var div = $('#' + imgDiv);
	              $.each(urlList, function (i, data) {
	            	  div.append("<li><a href='"+data.url+"' data-rel='colorbox' target='_Blank'><img src='"+data.url+"' style='height:100px;width: auto; ' /></a>" +
	            	  		"<div class='tools tools-bottom in' style='height: auto;'><a href='javascript:void(0)' onclick='delImg(this)'> <i class='ace-icon fa fa-times red'></i></a></div></li>");
	              });
	              editor.hideDialog();
	          }
	      });
	  });
	}

function loadK(content) {
	window.editor = KindEditor.create('#' + content, {
		/* cssPath : '../plugins/code/prettify.css', */
		uploadJson : sys.rootPath + '/upload/upload.xhtml',
		items : ['preview', 'print',
				'template', 'cut', 'copy', 'paste', 'plainpaste',
				'wordpaste', '|', 'justifyleft', 'justifycenter',
				'justifyright', 'justifyfull', 'insertorderedlist',
				'insertunorderedlist', 'indent', 'outdent', 'subscript',
				'superscript', 'clearhtml', 'quickformat', 'selectall', '|',
				'fullscreen', 'formatblock', 'fontname', 'fontsize', '|',
				'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
				'strikethrough', 'lineheight', 'removeformat', '|', 'image',
				'multiimage', 'insertfile', 'table', 'hr',
				'emoticons', 'pagebreak', 'anchor', 'link',
				'unlink' ],
		afterBlur : function() {
			this.sync();
		},
		//autoHeightMode : true,
		allowImageRemote:true,
		formatUploadUrl:true,
		height:"500px",
		width:"900px",
        afterUpload : function(url, data, name) { //上传文件后执行的回调函数，必须为3个参数
            if(name=="image" || name=="multiimage"){ //单个和批量上传图片时
                var img = new Image(); img.src = url;
                img.onload = function(){ //图片必须加载完成才能获取尺寸
                    if(img.width>900) window.editor.html(window.editor.html().replace('<img src="' + url + '"','<img src="' + url + '" width="100%"'))
                }
            }
        },
		//urlType:"domain",
		afterCreate : function() {
			// this.loadPlugin('autoheight');
			this.exec("fontsize","14px");
		}
	});
}
