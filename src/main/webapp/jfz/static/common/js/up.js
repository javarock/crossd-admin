//上架操作
function upOperate(rowId, baseUrl,listId) {

	var URL = baseUrl + "/upOperate";
	$.post(URL, {
		rowId : rowId
	}, function(data,status){
		$(listId).trigger("reloadGrid");});

}

