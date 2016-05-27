//下架操作
function downOperate(rowId,baseUrl,listId) {

	var URL = baseUrl + "/downOperate";
	$.post(URL, {
		rowId : rowId
	}, function(data,status){
		$(listId).trigger("reloadGrid");});

}

