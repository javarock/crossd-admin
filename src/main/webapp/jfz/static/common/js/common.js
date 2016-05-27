//js 只能输入数字和一个小数点
function clearNoNum(obj) {
	//先把非数字的都替换掉，除了数字和.
	obj.value = obj.value.replace(/[^\d.]/g, "");
	//必须保证第一个为数字而不是.
	obj.value = obj.value.replace(/^\./g, "");
	//保证只有出现一个.而没有多个.
	obj.value = obj.value.replace(/\.{2,}/g, ".");
	//保证.只出现一次，而不能出现两次以上
	obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$",".");
}

//js 只能输入数字
function clearOnlyNum(obj) {
	//先把非数字的都替换掉，除了数字
	obj.value = obj.value.replace(/[^\d]/g, "");
}

//js 只能输入数字和无限
function clearNumAndInfinite(obj) {
	//先把非数字的都替换掉，除了数字
	obj.value = obj.value.replace(/[^\d无限]/g, "");
}

//显示与隐藏提示
function displayLabel(labelId){
	$(labelId).show();
}

function hideLabel(labelId){
	$(labelId).hide();
}

//显示与隐藏固定与随机虚拟币数量
function editRandomNum(flag){
	if (flag) {
		$("#down_0").show();
		$("#down_1").show();
		$("#up_0").show();
		$("#up_1").show();
		$("#fix_0").hide();
		$("#fix_1").hide();
		$("#fix_1").val("");
	}else{
		$("#fix_0").show();
		$("#fix_1").show();
		$("#down_0").hide();
		$("#down_1").hide();
		$("#up_0").hide();
		$("#up_1").hide();
		$("#down_1").val("");
		$("#up_1").val("");
	}
}

//显示与隐藏分享文案
function checkTaskType(obj){
	if (obj.value == 'share_friend_cycle') {
		$("#share_0").show();
	}else{
		$("#share_0").hide();
		$("#share_1").val("");
	}
}

//显示与隐藏分享文案2
function checkTaskType2(obj){
	if (obj.value == 'share_friend_cycle') {
		$("#share_2").show();
	}else{
		$("#share_2").hide();
		$("#share_3").val("");
	}
}

//显示与隐藏固定与随机虚拟币数量2
function editRandomNum2(flag){
	if (flag) {
		$("#down_2").show();
		$("#random_downlimit_2").show();
		$("#up_2").show();
		$("#random_uplimit_2").show();
		
		$("#fix_2").hide();
		$("#gain_virasset_value_2").hide();
		$("#gain_virasset_value_2").val("");
	}else{
		$("#fix_2").show();
		$("#gain_virasset_value_2").show();
		
		$("#down_2").hide();
		$("#random_downlimit_2").hide();
		$("#up_2").hide();
		$("#random_uplimit_2").hide();
		$("#random_downlimit_2").val("");
		$("#random_uplimit_2").val("");
	}
}

function searchClick(btnId){
	$(btnId).click();
}


function cleanFilter(){
	$("#filter_0").val("");
	$("#filter_1").val("");
	$("#filter_2").val("");
	$("#filter_3").val("");
	$("#filter_4").val("");
	$("#filter_5").val("");
	$("#search_btn").click();
}

function cleanFilter2(){
	$("#filter_0").val("");
	$("#filter_1").val("");
	$("#filter_2").val("");
	$("#filter_3").val("");
	$("#filter_4").val("");
	$("#filter_5").val("");
	$("#filter_6").val("");
	$("#filter_7").val("");
	$("#filter_8").val("");
	$("#filter_9").val("");
	$("#filter_10").val("");
	$("#filter_11").val("");
	$("#coins_mission_search_btn").click();
}

function cleanFilter3(){
    $("#filter_0").val("");
    $("#filter_1").val("");
    $("#filter_2").val("");
    $("#filter_3").val("");
    $("#filter_4").val("");
    $("#filter_5").val("");
    $("#filter_6").val("");
    $("#filter_7").val("");
    $("#filter_8").val("");
    $("#filter_9").val("");
    $("#search_btn").click();
}

function cleanFilter4(){
    $("#filter_0").val("");
    $("#filter_1").val("");
    $("#filter_2").val("");
    $("#filter_3").val("");
    $("#filter_4").val("");
    $("#system_log_search_btn").click();
}


//单向链表实现
var createLinkList = function(){
    var _this = {}, first = null;
        _this.length = 0;
        _this.add = function(val) {
            first = {data:val, next: first || null};
            _this.length++;
        }
        // --- del
        _this.del = function(val){
            if (first.data == val){
                first = first.next;
                _this.length--;
                return ;
            }
            var ptemp = temp = first;
            for( ; temp; ptemp = temp ,temp= temp.next){
                if(temp.data == val){
                    ptemp.next = temp.next;
                    _this.length--;
                    return ;
                }
            }
        }
        // --- get
        _this.get = function(val){
            for( var temp = first ; temp; temp= temp.next){
                if(temp.data == val){
                	return temp.data;
                }
            }
        }
        
        _this.indexOf = function(val){
        	var i = -1;
        	for(var temp = first;temp; temp = temp.next){
        		i++;
        		if(temp.data == val){
        			return (_this.length-i-1);
        		}
        	}
        	return i;
        }
        
        _this.show = function(fn) {
            for(temp=first;temp;temp=temp.next) {
                fn(temp.data);
            }
        }
        return _this;
    }

