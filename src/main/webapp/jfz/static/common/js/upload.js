//上传文件
function uploadFile(baseUrl, formId, fileId) {
	if (!isImage(fileId)) {
		return;
	}
	var URL = baseUrl + "/uploadImage";
	var bannerForm = $(formId);
	bannerForm.attr("action", URL);
	bannerForm.submit();

}

//上传Excel
function uploadExcel(baseUrl, formId, fileId){

    $("#processCover1").dialog({
        modal: true,
        closeOnEscape:false,
        open:function(event,ui){$(".ui-dialog-titlebar-close").hide();},
        show:{
            effect: "fade",
            duration: 500
        },
        width: 400,
        title:"提示信息(保存完失败的号码后可点击关闭。)"
    });

    if (!isExcel(fileId)) {
        return;
    }
    var URL = baseUrl + "/uploadExcel";
    var bannerForm = $(formId);
    bannerForm.attr("action", URL);
    bannerForm.submit();
    $(fileId).val("");
}
//   异步上传excel
function uploadCardExcelAsync(baseUrl, fileId,cardType){

    if (!isExcel( $("#"+fileId))) {
    	alert("只接受excel");
        return;
    }
    var url = baseUrl + "/uploadExcel"; 
    $.ajaxFileUpload( {  
        url : url,//用于文件上传的服务器端请求地址  
        secureuri : false,//一般设置为false  
        fileElementId : fileId,//文件上传控件的id属性  
        dataType : 'text',//返回值类型 一般设置为json  
        success : function(data, status) //服务器成功响应处理函数  
        {  
            alert(data);//从服务器返回的json中取出message中的数据,其中message为在struts2中定义的成员变量  
            location.reload();
        },  
        error : function(data, status, e)//服务器响应失败处理函数  
        {  
            alert(e);  
        }  
    })  
}

//验证是否是Excel文件
function isExcel(fileId) {
    var images = new Array("xls","xlsx");
    var isImage = false;
    var fileName = $.trim($(fileId).val());
    if (fileName == "") {
        return false;
    }
    var ext = fileName.substr(fileName.lastIndexOf(".") + 1).toLowerCase();
    for (var i = 0; i < images.length; i++) {
        if (images[i] == ext) {
            isImage = true;
            break;
        }
    }
    return isImage;
}


//验证是否是图片
function isImage(fileId) {
	var images = new Array("jpg","jpeg","gif","png");
	var isImage = false;
	var fileName = $.trim($(fileId).val());
	if (fileName == "") {
		return false;
	}
	var ext = fileName.substr(fileName.lastIndexOf(".") + 1).toLowerCase();
	for (var i = 0; i < images.length; i++) {
		if (images[i] == ext) {
			isImage = true;
			break;
		}
	}
	return isImage;
}


function afterUpload(isUpload, url, imgId, inputId){
	document.getElementById(imgId).src = url;
	$("#"+imgId).show();
	document.getElementById(inputId).value = url;
}


function afterUploadExcel(boolean){
    $("#processCover1").dialog("destroy");
    if(boolean == true){
        alert('上传Excel文件成功！');
    }else{
        alert('有失败的数据！');
    }
}
function excelDataOverflow(){
    $("#processCover1").dialog("destroy");
    alert('上传失败！原因：数据超过两百条，我不想处理。');
}

function interfaceError(){
    $("#processCover1").dialog("destroy");
    alert('上传失败！原因：数据过多，后台处理超时！');
}

function afterUploadExcelError(){
    $("#processCover1").dialog("destroy");
}

function notModel(){
    $("#processCover1").dialog("destroy");
    alert('上传失败！原因：上传文件格式与模板不同！');
}