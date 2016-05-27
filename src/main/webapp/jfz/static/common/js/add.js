



//弹出新增对话框
function popAddDialog(formId,obj){
	$(formId).dialog({
		modal : true,
		show : {
			effect : "fade",
			duration : 500
			
			
			
		},
        height : 800,
		width : 900,
		title : $(obj).val()

    });
}

//弹出新增对话框
function popAddDialog2(formId,obj){
    $(formId).dialog({
        modal : true,
        show : {
            effect : "fade",
            duration : 500
        },
        width : 900,
        title : $(obj).val()

    });
}

//提交新增对话框
function submitAddDialog(baseUrl,formId,listId) {
	//先进行数据审核校验
	var fields = $(formId).serializeArray();
	var map = {};
	$.each(fields, function(i, field) {
		map[field.name] = field.value;
	});
	var URL = baseUrl + "/add";
	$.post(URL, map, function(data,status){
		$(formId).dialog("destroy");
		$(formId)[0].reset();
		$(listId).trigger("reloadGrid");}
	);
}



//关闭新增商品对话框
function cancelAddDialog(formId) {
	$(formId).dialog("destroy");
}

