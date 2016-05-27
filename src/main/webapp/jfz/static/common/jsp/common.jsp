<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%
	String path = request.getContextPath();
	request.setAttribute("path", path + "/");
	request.setAttribute("staticPath", path + "/jfz/static/");
%>