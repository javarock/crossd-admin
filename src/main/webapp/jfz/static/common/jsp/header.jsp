<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jfz/static/common/jsp/common.jsp" %>

<c:if test="${param.index }">
	<link rel="stylesheet" href="${staticPath }jquerylayout/layout-default.css"/>
</c:if>

<link rel="stylesheet" href="${staticPath }jqueryui/jquery-ui.css">

<c:if test="${!param.index }">
	<link rel="stylesheet" href="${staticPath }jquerytimepicker/jquery-ui-timepicker-addon.min.css">
	<link rel="stylesheet" href="${staticPath }jqgrid/css/ui.jqgrid.css" />
</c:if>

<link rel="stylesheet" href="${staticPath }common/css/index.css" />

<!-- 校验样式 -->
<link rel="stylesheet" href="${staticPath }jqueryvalidation/css/cmxform.css" />

<script type="text/javascript" src="${staticPath }common/js/jquery-1.11.0.min.js"></script>

<c:if test="${param.index }">
	<script type="text/javascript" src="${staticPath }jquerylayout/jquery.layout.js"></script>
</c:if>

<script type="text/javascript" src="${staticPath }jqueryui/jquery-ui.js"></script>

<script type="text/javascript" src="${staticPath }common/js/simpleDialog.js"></script>

<script type="text/javascript" src="${staticPath }common/js/common.js"></script>

<script type="text/javascript">
	/**
	*设置全局的AJAX请求默认选项
	*主要设置了AJAX请求遇到Session过期的情况
	*/
	$.ajaxSetup({
		complete:function(xhr,status) {
			// TODO
			if("error" == status) {
				$.simpleAlter("服务器未响应");
			} else {
				var sessionout = xhr.getResponseHeader('sessionout');
				if("true" == sessionout) {
					$.simpleAlter("会话失效，请刷新页面重新登录");
				}
			}
		}
	});
	
	/**
	*在页面中任何嵌套层次的窗口中获取顶层窗口
	*/
	function getTopWindow() {
		var p = window;
		while(p != p.parent){
			p = p.parent;
		}
		return p;
	}
</script>
