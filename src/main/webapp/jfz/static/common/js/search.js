


//搜索指定任务
function commonSearch(baseUrl, formId, listId){
	var fields = $(formId).serializeArray();
	var url = baseUrl  + "/data?";
	$.each( fields, function(i, field){
		url += (field.name + "=" + field.value + "&")
	});
	url = url.substring(0, url.length-1);
	$(listId).jqGrid('setGridParam',{url:url,page:1}).trigger("reloadGrid");
}