<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jfz/static/common/jsp/common.jsp" %>

<script type="text/javascript" src="${staticPath }jqueryvalidation/jquery.form.js"></script>
<script type="text/javascript" src="${staticPath }jqueryvalidation/jquery.validate.js"></script>
<script type="text/javascript" src="${staticPath }jqueryvalidation/localization/messages_zh.js"></script>
<c:if test="${!param.index }">
	<script type="text/javascript" src="${staticPath }jqueryui/jquery-ui-datepicker-zh.js"></script>
	<script type="text/javascript" src="${staticPath }jqgrid/js/i18n/grid.locale-en.js"></script>
	<script type="text/javascript" src="${staticPath }jqgrid/js/jquery.jqGrid.min.js"></script>
	<script type="text/javascript" src="${staticPath }jquerytimepicker/jquery-ui-timepicker-addon.min.js"></script>
	<script type="text/javascript" src="${staticPath }jquerytimepicker/jquery-ui-sliderAccess.js"></script>
	<script type="text/javascript" src="${staticPath }jquerytimepicker/i18n/jquery-ui-timepicker-zh-CN.js"></script>
</c:if>  