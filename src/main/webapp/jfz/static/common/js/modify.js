//提交修改数据
function submitModify(baseurl,formId,listId) {
	var fields = $(formId).serializeArray();
	var map = {};
	$.each(fields, function(i, field) {
		map[field.name] = field.value;
	});
	var URL = baseurl + "/modify";
	$.post(URL, map, function(data,status){
		$(formId).dialog("destroy");
		$(formId)[0].reset();
		$(listId).trigger("reloadGrid");}
	);
}




function showRewardTrafficDialog(rowId){
	var rowObject = $("#goods_list").jqGrid('getRowData', rowId);

	$("#id").val(rowObject.id);
	$("#rewardTraffic").val(rowObject.rewardTraffic);
	$("#appChannel").val(rowObject.appChannel);
	$("#appChannel_cn").val(rowObject.appChannel_cn);
	$("#platform").val(rowObject.platform);
	$("#operators").val(rowObject.operators);
	
	$("#showGoodsDialogForm").dialog({
		modal : true,
		show : {
			effect : "fade",
			duration : 500
		},
        title : "渠道商品",
        height : 850,
		width : 900

	});
	
}
//关闭编辑对话框
function cancelModify(formId) {
	$(formId).dialog("destroy");
}

function showActivityDialog(rowId){
	var rowObject = $("#goods_list").jqGrid('getRowData', rowId);
	$("#name").val(rowObject.name);
	$("#id").val(rowObject.id);
	var platform=rowObject.platform;
	if (platform=='滚雪球'){
		$("#platform").val(1);
	}else if (platform=='金斧子'){
		$("#platform").val(2);
	}else if (platform=='金融港'){
		$("#platform").val(3);
	}
    var status=rowObject.status;
    if (status=='下架'){
    	$("#status").val(0);
    }else if (status=='上架'){
    	$("#status").val(1);
    }
	
	$("#add_goods_dialog_form_begin_time").val(rowObject.beginTime);
	$("#add_goods_dialog_form_end_time").val(rowObject.endTime);
	$("#showGoodsDialogForm").dialog({
		modal : true,
		show : {
			effect : "fade",
			duration : 500
		},
        title : "编辑商品",
        height : 850,
		width : 900

	});
	
}

//编辑具体商品对话框
function showGoodsDialog(rowId) {

	var rowObject = $("#goods_list").jqGrid('getRowData', rowId);


	//对虚拟币类型反赋值
	switch (rowObject.virasset_type_id) {
	case "雪币":
		rowObject.virasset_type_id = "1";
		break;
	case "金币":
		rowObject.virasset_type_id = "2";
		break;
	
	}
	
	
	//对商品类型反赋值
	/*switch (rowObject.consumable_type_id) {
	case "话费":
		rowObject.consumable_type_id = "1";
		break;
	case "50元京东电子卡":
		rowObject.consumable_type_id = "2";
		break;
	case "唯品会卡":
		rowObject.consumable_type_id = "3";
		break;
	default :
		alert(rowObject.consumable_type_id);
		alert("商品类型无法找到,请检查modify.js中的showGoodsDialog方法来适应新品种的添加")
	
	}
	*/
	//对库存无需反赋值
	
	
	
	
	
	
	//对商品状态反赋值
	switch (rowObject.status) {
	case "已下架":
		rowObject.status = "0";
		break;
	case "已上架":
		rowObject.status = "1";
		break;
	}
	
	//对商品icon反赋值
	if (rowObject.img_url == '<img height="40" width="40" border="0">') {
		rowObject.img_url = "";
	}else{
		var reg = new RegExp("<img src=\"(.*)\" height.*");
		rowObject.img_url = rowObject.img_url.match(reg);
		rowObject.img_url = rowObject.img_url[1];
	}
	

	//查看商品对话框UI
	$("#showGoodsDialogForm").dialog({
		modal : true,
		show : {
			effect : "fade",
			duration : 500
		},
        title : "编辑商品",
        height : 850,
		width : 900

	});
	$("#id_1").html(rowObject.id);
	$("#id").val(rowObject.id);
	$("#name").val(rowObject.name);
	$("#sub_name").val(rowObject.sub_name);
	$("#price").val(rowObject.price);
	$("#virasset_value").val(rowObject.virasset_value);
	$("#virasset_type_id").val(rowObject.virasset_type_id);
	$("#stock").val(rowObject.stock);
	$("#description").val(rowObject.description);
	$("#icon_img").attr("src",rowObject.img_url);
	$("#consumable_type_id").val(rowObject.consumable_type_id);
	$("#status").val(rowObject.status);
	$("#begin_time").val(rowObject.begin_time);
	$("#end_time").val(rowObject.end_time);
	$("#create_time").html(rowObject.create_time);
	$("#update_time").html(rowObject.update_time);
	$("#button_title").val(rowObject.button_title);
	$("#position").val(rowObject.position);
	$("#platform").val(rowObject.platform);
	$("#client").val(rowObject.client);
	$("#img_url").val(rowObject.img_url);

}

//编辑具体任务对话框
function showCoinsMissionDialog(rowId) {

	var rowObject = $("#coins_mission_list").jqGrid('getRowData', rowId);


	//对虚拟币类型反赋值
	switch (rowObject.virasset_type_id) {
	case "雪币":
		rowObject.virasset_type_id = "1";
		break;
	case "金币":
		rowObject.virasset_type_id = "2";
		break;
	}
	
	//对商品状态反赋值
	switch (rowObject.status) {
	case "结束":
		rowObject.status = "0";
		break;
	case "开始":
		rowObject.status = "1";
		break;
	}
	
	//对接入平台反赋值
	switch (rowObject.platform) {
	case "滚雪球":
		rowObject.platform = "1";
		break;
	case "金斧子APP":
		rowObject.platform = "2";
		break;
	case "金融港":
		rowObject.platform = "3";
		break;
	}
	
	//对是否新手专享反赋值
	switch (rowObject.limit_new_user) {
	case "否":
		rowObject.limit_new_user = "0";
		break;
	case "股基新手":
		rowObject.limit_new_user = "1";
		break;
	case "票据新手":
		rowObject.limit_new_user = "2";
		break;
	}
	
	//对商品icon反赋值
	if (rowObject.img_url == '<img height="40" width="40" border="0">') {
		rowObject.img_url = "";
	}else{
		var reg = new RegExp("<img src=\"(.*)\" height.*");
		rowObject.img_url = rowObject.img_url.match(reg);
		rowObject.img_url = rowObject.img_url[1];
	}
	

	//查看商品对话框UI
	$("#modify_coins_mission_dialog_form").dialog({
		modal : true,
		show : {
			effect : "fade",
			duration : 500
		},
        title : "编辑任务",
        height : 800,
		width : 900

	});
	
	$("#id_1").html(rowObject.id);
	$("#id").val(rowObject.id);
	$("#father_task_id").html(rowObject.father_task_id);
	$("#task_key").html(rowObject.task_key);
	$("#name").val(rowObject.name);
	$("#sub_name").val(rowObject.sub_name);
	$("#task_type").val(rowObject.task_type);
	
	if (rowObject.task_type == 'share_friend_cycle') {
		$("#share_2").show();
	}else{
		$("#share_2").hide();
	}
	
	$("#cycle_type").val(rowObject.cycle_type);
	
	$("#limit_new_user").val(rowObject.limit_new_user);
	
	if (rowObject.status == "1") {
		$("#status_1").attr("checked","checked");
	}else{
		$("#status_0").attr("checked","checked");
	}
	$("#share_3").val(rowObject.share_content);
	$("#jump_url").val(rowObject.jump_url);
	$("#virasset_type_id").val(rowObject.virasset_type_id);
	$("#button_title").val(rowObject.button_title);
	
	if (rowObject.is_random_gain_virasset == "1") {
		$("#is_random_gain_virasset_1").attr("checked","checked");
		$("#down_2").show();
		$("#random_downlimit_2").show();
		$("#up_2").show();
		$("#random_uplimit_2").show();
		$("#fix_2").hide();
		$("#gain_virasset_value_2").hide();
	}else{
		$("#is_random_gain_virasset_0").attr("checked","checked");
		$("#fix_2").show();
		$("#gain_virasset_value_2").show();
		$("#down_2").hide();
		$("#random_downlimit_2").hide();
		$("#up_2").hide();
		$("#random_uplimit_2").hide();
	}
	
	$("#is_random_gain_virasset").val(rowObject.is_random_gain_virasset);
	$("#random_downlimit_2").val(rowObject.random_downlimit);
	$("#random_uplimit_2").val(rowObject.random_uplimit);
	$("#gain_virasset_value_2").val(rowObject.gain_virasset_value);
	
	if (rowObject.is_show == 0) {
		$("#is_show_0").attr("checked","checked");
	}else{
		$("#is_show_1").attr("checked","checked");
	}
	$("#is_show").val(rowObject.is_show);
	$("#position").val(rowObject.position);
	$("#create_time").html(rowObject.create_time);
	$("#update_time").html(rowObject.update_time);
	$("#platform").val(rowObject.platform);
	$("#client").val(rowObject.client);
	$("#show_img").attr("src",rowObject.img_url);
	$("#img_url").val(rowObject.img_url);
}

function showPropertyConfigDialog(rowId){

    var rowObject = $("#property_config_list").jqGrid('getRowData', rowId);

    //对状态反赋值
    switch (rowObject.ENABLED) {
        case "启用":
            rowObject.ENABLED = "Y";
            break;
        case "禁用":
            rowObject.ENABLED = "N";
            break;
    }

    //查看商品对话框UI
    $("#showConfigDialogForm").dialog({
        modal : true,
        show : {
            effect : "fade",
            duration : 500
        },
        width : 750

    });

    $("#ID").val(rowObject.ID);
    $("#PROP_NAME").val(rowObject.PROP_NAME);
    $("#PROP_VALUE").val(rowObject.PROP_VALUE);
    $("#ENABLED").val(rowObject.ENABLED);
    $("#type").val(rowObject.type);
    $("#DESC").val(rowObject.DESC);
    $("#EFFECT_FROM").val(rowObject.EFFECT_FROM);
    $("#EFFECT_TO").val(rowObject.EFFECT_TO);
    $("#CREATE_TIME").html(rowObject.CREATE_TIME);
    $("#UPDATE_TIME").html(rowObject.UPDATE_TIME);
}


function showSystemLogDialog(rowId){

    var rowObject = $("#system_log_list").jqGrid('getRowData', rowId);


    //查看商品对话框UI
    $("#modify_system_log_dialog_form").dialog({
        modal : true,
        show : {
            effect : "fade",
            duration : 500
        },
        title : "操作详情",
        width : 750

    });

    var a = "";
    var json = $.parseJSON(rowObject.description);
    for (var key in json){
        a += key;
        a += "="
        a += json[key];
        a += "\n";
        a += "\n";
    }
    //$("#description").val(json);
    $("#description").val(a);

}