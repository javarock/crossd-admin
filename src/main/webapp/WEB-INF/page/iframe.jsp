<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jfz/static/common/jsp/common.jsp"%>
<iframe src="${path }${param.data}" id="iframepage_${param.data }" name="iframepage" frameBorder=0  scrolling=no width="100%" onLoad="iFrameHeight()">
</iframe>    
<script type="text/javascript"> 
	// TODO
	/**iframe自适应高度*/
	function iFrameHeight() { 
		var ifm= document.getElementById("iframepage_${param.data}"); 
		var subWeb = document.frames ? document.frames["iframepage"].document : ifm.contentDocument; 
		if(ifm != null && subWeb != null) { 
			ifm.height = subWeb.body.scrollHeight; 
		}
		$("#iframepage").attr("id", randomString(16));
	} 
	
	/**生成指定长度的随机字符串*/
	function randomString(len) {
		var x = "0123456789qwertyuioplkjhgfdsazxcvbnm";
		var tmp = "";
		var timestamp = new Date().getTime();
		for(var i=0; i < len; i++)  {
			tmp += x.charAt(Math.ceil(Math.random()*100000000)%x.length);
		}
		return timestamp + tmp;
	}
</script> 


    