<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jfz/static/common/jsp/common.jsp" %> 
<%@ taglib
    prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" 
%>
<!DOCTYPE html>
<html lang="en">
    <head>

        <link rel="shortcut icon" href="jfz/static/adminLogin/images/jinniu_icon.png" />
        <meta charset="utf-8">
        
        <!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
        Remove this if you use the .htaccess -->
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

        <title>crossd管理系统</title>
        
        <jsp:include page="/jfz/static/common/jsp/header.jsp">
        	<jsp:param value="true" name="index"/>
        </jsp:include>
        
        <jsp:include page="/jfz/static/common/jsp/bottom.jsp">
        	<jsp:param value="true" name="index"/>
        </jsp:include>
        
        <script type="text/javascript">
        	
        	//布局
			var myLayout;
        	//tabs
			var tabs;
        	//当前tab的数量
			var tabCounter = 1;
        	
			var list = createLinkList();
        	
			$(document).ready(function() {
				
				initLayout();
				
				initAccordion();
				
				initMenu();
				
				initTabs();
				
				delTab();
				
				addTab();
				
				initUI();
				
				list.add(0);
				
			});
			
			/**初始化布局*/
			function initLayout() {
        		//初始化布局
				myLayout = $('body').layout({
					//north : {
					//	size : 30
					//
					//},
					west : {
						size : 250

					}
				});
        	}
        	
			/**初始化accordion*/
        	function initAccordion() {
        		//初始化accordion
				$("#accordion").accordion({
					collapsible: true,
					icons: {
						header: "ui-icon-circle-arrow-e",
						activeHeader: "ui-icon-circle-arrow-s"
					},
					heightStyle: "content"//fill or content
					
				});
        	}
        	
			/**初始menu*/
        	function initMenu() {
        		//初始menu
				$(".menu").menu();
        	}
        	
			/**初始化tab*/
        	function initTabs() {
				tabs = $("#tabs").tabs();
        	}
        	
			/**tab绑定关闭事件*/
        	function delTab() {
        		//关闭tab
				tabs.delegate("span.ui-icon-close", "click", function() {

					var panelId = $(this).closest("li").remove().attr("aria-controls");
					var tabId = $(this).closest("li").attr("id");
					var index = tabId.substring(tabId.lastIndexOf("-")+1,tabId.length);
					list.del(index);
					$("#" + panelId).remove();
					tabs.tabs("refresh");
					//tabCounter--;
				});
        	}
        	
			/**menu绑定添加tab事件*/
        	function addTab() {
        		//添加tab
				$(".menu li").click(function() {	
					var index = $(this).attr("index");
					if(index && $("#tabs-" + index).size() > 0) {
						tabs.tabs({
							active : list.indexOf(index)
						});
						return;
					}
					//重新打开标签
					var id;
					var tabIndex;
					if(index){
						tabIndex = index;
						id = "tabs-" + index;
					}else{
						id = "tabs-" + tabCounter;
						$(this).attr("index", tabCounter);
						tabIndex = tabCounter;
						tabCounter++;
					}
					list.add(tabIndex);
					var title = $(this).text();
					var link = $(this).attr("link");
					
					var li = "<li id='" + id + "'><a href='" + link + "'>" + title + 
						"</a><span class='ui-icon ui-icon-close' role='presentation'>Remove Tab</span></li>";
					tabs.find(".ui-tabs-nav").append(li);
					tabs.tabs("refresh");
					tabs.tabs({
						active : list.indexOf(tabIndex)
					});
					
					
				});
        	}
			
			/**初始化ui*/
			function initUI() {
				$("#update_password_submit").button();
			}
			
        </script>
        
    </head>

    <body>
    
        <div class="ui-layout-west" style="margin: 0px; padding: 0px;">
        	
            <div id="accordion">
                <h3>管理员设置</h3>
                <div>
                	<ul class="menu" style="border:0;">
                		<!-- 
                        <li link="${path }iframe?data=user/list">
                           	<span>用户列表</span>
                        </li>
                        
                         -->
                        <c:if test="${sessionScope.admin.privlegeMap.admin.readable||sessionScope.admin.isSuperAdmin}">
	                        <li link="${path }iframe?data=admin/list">
	                           	<span>管理员列表</span>
	                        </li>
                        </c:if>
					</ul>
                </div>
                
               <h3>金币系统</h3>
                <div>
                	
                	<ul class="menu" style="border:0;">
                		<c:if test="${sessionScope.admin.privlegeMap.withDrawBill.readable||sessionScope.admin.isSuperAdmin}">

							<li link="${path }iframe?data=share/list">
								<span>动态圈</span>
							</li>

                        </c:if>

                        <c:if test="${sessionScope.admin.privlegeMap.withDrawBill.readable||sessionScope.admin.isSuperAdmin}">

                        	<li link="${path }iframe?data=share/listImgsList">
                        		<span>照片集锦</span>
                        	</li>

                        </c:if>

						<c:if test="${sessionScope.admin.privlegeMap.withDrawBill.readable||sessionScope.admin.isSuperAdmin}">

							<li link="${path }iframe?data=share/listImgs">
								<span>照片圈</span>
							</li>

						</c:if>


                </div>


                <h3>系统环境</h3>
                <div>
                    <ul class="menu" style="border:0;">
                        <c:if test="${sessionScope.admin.privlegeMap.withDrawBill.readable||sessionScope.admin.isSuperAdmin}">
							<li link="${path }iframe?data=propertyConfig/list">
								<span>环境变量</span>
							</li>
                        </c:if>
                    </ul>
                </div>

                <h3>操作日志</h3>
                <div>
                    <ul class="menu" style="border:0;">
                        <c:if test="${sessionScope.admin.privlegeMap.withDrawBill.readable||sessionScope.admin.isSuperAdmin}">
							<li link="${path }iframe?data=systemLog/list">
								<span>详细日志</span>
							</li>
                        </c:if>

                    </ul>
                </div>

            </div>
            
        </div>

        <div class="ui-layout-center" style="margin: 0px; padding: 0px;">
        
            <div id="tabs">
                <ul>
                    <li>
                        <a href="#tabs-0">欢迎</a>
                    </li>
                </ul>
                <div id="tabs-0">
                    <p>
                    	欢迎 ${sessionScope.admin.adminName } 来到后台!
                    	
                    	<a href="${path }loginout">退出登录</a>
                    </p>
                </div>
                
            </div>
            
        </div>
    </body>
</html>
