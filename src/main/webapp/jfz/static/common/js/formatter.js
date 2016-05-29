/**
 * formatterXXX()修改前端显示 并且会修改其值，即传引用
 */
// 前端虚拟币类型显示
function formatterVirassetTypeId(virasset_type_id) {
	switch (virasset_type_id) {
	case 1:
		return "雪币";
	case 2:
		return "金币";
	default:
		return "未定义";
	}
}

// 前端商品类型显示
function formatterConsumableTypeId(consumable_type_id) {
/*	switch (consumable_type_id) {
	case 1:
		return "话费";
	case 2:
		return "50元京东电子卡";
	case 3:
		return "唯品会卡";
	default:
		alert("类型不正确,请检查formatter.js中的formatterConsumableTypeId方法");
		return "未定义";
	}*/
	return consumable_type_id;
}




// 前端商品库存显示
function formatterStock(stock) {
	switch (stock) {
	case "-1":
		return "无限";
	default:
		return stock;
	}
}

// 前端商品状态显示
function formatterStatus(status) {
	switch (status) {
	case 0:
		return "已下架";
	case 1:
		return "已上架";
	default:
		return "未定义";
	}
}

//前端商品状态显示
function formatterStatus2(status) {
	switch (status) {
	case 0:
		return "结束";
	case 1:
		return "开始";
	default:
		return "未定义";
	}
}

//前端图片URL 显示
function formatterImgUrl(imgs){

	if (imgs == "") {
		return "<img height='40' width='40' border='0'>";
	}else{
		var img_urls = imgs.split(",");
		var hostname = "http://image.crossd.me/";
		return "<img src="+hostname + img_urls[0]+" height='40' width='40'>";
	}
}


// 前端操作栏显示
function formatterOperate(rowId, status, baseUrl) {
	switch (status) {
	case 0:
		return "<input type='button' class='viewGoods_btn' value='编辑' onclick=\"showGoodsDialog("
				+ rowId
				+ ");\" />"
				+ "&nbsp&nbsp<input type='button' class='upGoods_btn' value='上架' onclick=\"upOperate("
				+ rowId 
				+","
				+"'"
				+ baseUrl
				+"'"
				+","
				+"'"
				+ "#goods_list"
				+"'"
				+ ");\" />";
		break;
	case 1:
		return "<input type='button' class='viewGoods_btn' value='编辑' onclick=\"showGoodsDialog("
				+ rowId
				+ ");\" />"
				+ "&nbsp&nbsp<input type='button' class='downGoods_btn' value='下架' onclick=\"downOperate("
				+ rowId
				+","
				+"'"
				+ baseUrl
				+"'"
				+","
				+"'"
				+ "#goods_list"
				+"'"
				+ ");\" />";
		break;
	}
}

//前端发放形式显示
function formatterPaymentForm(rowObject){
	switch(rowObject.is_random_gain_virasset){
	case 0:
		return  "固定虚拟币"
				+ "<br>"
				+ rowObject.gain_virasset_value;
		break;
	case 1:
		return  "随机虚拟币"
				+ "<br>"
				+ rowObject.random_downlimit
				+ "-"
				+ rowObject.random_uplimit;
		break;
	}
}

//前端接入平台显示
function formatterPlatform(platform){
	switch(platform){
	case 1:
		return  "滚雪球";
		break;
	case 2:
		return  "金斧子APP";
		break;
	case 3:
		return  "金融港";
		break;
	}
}


function formatterENABLED(ENABLED){

    switch(ENABLED){
        case 'Y':
            return  "启用";
            break;
        case 'N':
            return  "禁用";
            break;
    }

}

//前端是否新手专享显示
function formatterLimitNewUser(limit_new_user){
	switch(limit_new_user){
	case 0:
		return  "否";
		break;
	case 1:
		return  "股基新手";
		break;
	case 2:
		return  "票据新手";
		break;
	}
}


//前端操作栏显示2
function formatterOperate2(rowId, status, baseUrl) {
	switch (status) {
	case 0:
		return "<input type='button' class='viewGoods_btn' value='编辑' onclick=\"showCoinsMissionDialog("
				+ rowId
				+ ");\" />"
				+ "&nbsp&nbsp<input type='button' class='upGoods_btn' value='开始' onclick=\"upOperate("
				+ rowId 
				+","
				+"'"
				+ baseUrl
				+"'"
				+","
				+"'"
				+ "#coins_mission_list"
				+"'"
				+ ");\" />";
		break;
	case 1:
		return "<input type='button' class='viewGoods_btn' value='编辑' onclick=\"showCoinsMissionDialog("
				+ rowId
				+ ");\" />"
				+ "&nbsp&nbsp<input type='button' class='downGoods_btn' value='结束' onclick=\"downOperate("
				+ rowId
				+","
				+"'"
				+ baseUrl
				+"'"
				+","
				+"'"
				+ "#coins_mission_list"
				+"'"
				+ ");\" />";
		break;
	}
}

//前端操作栏显示2
function formatterOperate3(rowId) {

    return "<input type='button' class='view_btn' value='编辑' onclick=\"showPropertyConfigDialog("
        + rowId
        + ");\" />";
}

//前端详细信息按钮
function formatterDetail(rowId){
    return "<input type='button' class='view_btn' value='查看详情' onclick=\"showSystemLogDialog("
        + rowId
        + ");\" />";
}

//前端操作模块显示
function formatterOperateModule(operateModule){
    switch (operateModule){
        case "Admin":
            return "管理员";
        case "CoinsMission":
            return "金币任务";
        case "CoinsStore":
            return "金币商城";
        case "ConsumableOrder":
            return "兑奖记录";
        case "PropertyConfig":
            return "环境变量";
        case "BatchMission":
            return "批量完成任务"
    }
}

//前端操作显示
function formatterOperateDetail(operate){
    switch (operate){
        case "Add":
            return "新增记录";
        case "Modify":
            return "修改记录";
        case "Down":
            return "下架操作";
        case "Up":
            return "上架操作";
        case "Charge":
            return "发货操作";
        case "Login":
            return "登录操作";
        case "UploadExcel":
            return "上传Excel"
    }
}
