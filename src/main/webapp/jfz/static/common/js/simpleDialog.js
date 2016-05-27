/**
 * 基于jqeury ui 封装的弹出框组件，注册为jqeury的扩展
 */
jQuery.extend({
	
	
	simpleAlter: function(text, title, id, fn) {
		id = id || "dialog-message";
		title = title || "提示信息";
		var html = "<div id=\"" + id + "\">" +
			"<span class=\"ui-icon ui-icon-alert\" style=\"float:left; margin:0 7px 20px 0;\"></span>" +
			"<span>" + text + "</span>" +
			"</div>";
		$(html).dialog({
			resizable: false,
			modal: true, 
			show: {  
                effect: "fade",  
                duration: 300  
            },
            open:function() {
            	
            },
            title: title,
            buttons: {
            	"确定": function() {
            		$(this).dialog("close");
            		fn && fn.call($(this));
            	}
            },
            close: function(event, ui) {
            	$(this).dialog("destroy");  
                $("#" + id).remove();
            }
            
		});
		
	},
	
	simpleDialog: function(text, title, width,height,id, fn) {
		id = id || "dialog-message";
		title = title || "提示信息";
		var html = "<div id=\"" + id + "\">" +
			"<span  style=\"float:left; margin:0 7px 20px 0;\"></span>" +
			"<span>" + text + "</span>" +
			"</div>";
		$(html).dialog({
			resizable: true,
			width:width,
			height:height,
			modal: true, 
			show: {  
                effect: "fade",  
                duration: 300  
            },
            open:function() {
            	
            },
            title: title,
            buttons: {
            	"确定": function() {
            		$(this).dialog("close");
            		fn && fn.call($(this));
            	}
            },
            close: function(event, ui) {
            	$(this).dialog("destroy");  
                $("#" + id).remove();
            }
            
		});
		
	},
	
	simpleTip: function(text, id, width, height, timeout) {
		id = id || "dialog-tip";
		width = width || 100;
		height = height || 100;
		timeout = timeout || 1000;
		var html = "<div id=\"" + id + "\">" +
			"<span class=\"ui-icon ui-icon-alert\" style=\"float:left; margin:0 7px 20px 0;\"></span>" +
			"<span>" + text + "</span>" +
			"</div>";
		$(html).dialog({
			height: height,
			width: width,
			show: {  
	            effect: "fade",  
	            duration: 300  
	        },
	        open:function() {
	        	
	        },
	        open: function() {
	        	setTimeout(function () {
	        		$("#" + id).dialog("close"); 
	        		$("#" + id).dialog("destroy"); 
	        		$("#" + id).remove();
	        	}, timeout);
	        }
		});
	},
	
	/**
	 * text:确认框的内容
	 * title:确认框的标题，默认为"确认信息"
	 * id:确认框的id，默认为"dialog-confirm"
	 * fn:确定之后的回调函数
	 * arg:函数的参数，为json格式
	 */
	simpleConfirm: function(text, title, id, fn, args) {
		id = id || "dialog-confirm";
		title = title || "确认信息";
		var html = "<div id=\"" + id + "\">" +
			"<span class=\"ui-icon ui-icon-alert\" style=\"float:left; margin:0 7px 20px 0;\"></span>" +
			"<span>" + text + "</span>" +
			"</div>";
		$(html).dialog({
			resizable: false,
			modal: true, 
			show: {  
                effect: "fade",  
                duration: 300  
            },
            title: title,
            buttons: {
            	"确定": function() {
            		debugger;
            		//args是一个json对象
            		//将fn的this替换为dialog
            		fn && fn.call($(this), args);
            		$(this).dialog("destroy"); 
            		$("#" + id).remove();
            	},
            	"取消": function() {
            		$(this).dialog("close");
            		$(this).dialog("destroy"); 
            		$("#" + id).remove();
            	}
            },
            close: function(event, ui) {
            	$(this).dialog("destroy");  
                $("#" + id).remove();
            }
            
		});
	}
});