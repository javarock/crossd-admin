<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jfz/static/common/jsp/common.jsp" %>  
  
<!DOCTYPE html>
<html lang="en">
    <head>
    
        <meta charset="utf-8">
        
        <!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
        Remove this if you use the .htaccess -->
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

        <title>用户列表</title>
        
        <jsp:include page="/jfz/static/common/jsp/header.jsp"/>

    </head>
    <body>
    	<div>
    		
			<!-- 搜索 -->
			<form id="admin_search_form">
				<table>
					<tr>	
						<td>
							<label for="adminName">管理员账号</label>
						</td>
						<td>
							<input type="text" name="adminName" id="adminName" value="" 
								class="text ui-widget-content ui-corner-all">
						</td>
						<td>
							<label for="adminRealName">真实姓名</label>
						</td>
						<td>
							<input type="text" name="adminRealName" id="adminRealName" value="" 
								class="text ui-widget-content ui-corner-all">
						</td>
						<td>
							<a style="height:22px;" href="javascript:;" id='admin_search_btn' onclick="adminSearch()">搜索</a>
						</td>
					</tr>
					<!-- 
					<tr>
						<td>
							<label for="createTimeFrom">创建时间 from</label>
						</td>
						<td>
							<input type="text" id="createTimeFrom" name="createTimeFrom" 
								class="text ui-widget-content ui-corner-all">
						</td>
						<td>
							<label for="createTimeTo">注册时间 to</label>
						</td>
						<td>
							<input type="text" id="createTimeTo" name="createTimeTo" 
								class="text ui-widget-content ui-corner-all">
						</td>
					</tr>
					<tr>
						<td>
							<label for="lastLoginTimeFrom">上次登录时间 from</label>
						</td>
						<td>
							<input type="text" id="lastLoginTimeFrom" name="lastLoginTimeFrom" 
								class="text ui-widget-content ui-corner-all">
						</td>
						<td>
							<label for="lastLoginTimeTo">上次登录时间to</label>
						</td>
						<td>
							<input type="text" id="lastLoginTimeTo" name="lastLoginTimeTo" 
								class="text ui-widget-content ui-corner-all">
						</td>	
						 -->
					</tr>
				</table>
			</form>
			
			<br>
			
			<!-- grid内容展示区域 -->
			<table id="admin_list"></table>
			<div id="admin_pager"></div>
			
		</div>
		
		<!-- 添加用户 -->
		<form id="admin_add_form" style="display: none;">
			<table>
				<tr>
					<td>
						<label for="adminName">账户名</label>
					</td>
					<td>
						<input type="text" name="adminName" id="adminName" 
							class="text ui-widget-content ui-corner-all">
					</td>
				</tr>
				<tr>
					<td>
						<label for="adminRealName">真实姓名</label>
					</td>
					<td>
						<input type="text" name="adminRealName" id="adminRealName" 
							class="text ui-widget-content ui-corner-all">
					</td>
				</tr>
				<tr>
					<td>
						<label for="adminPassword">密码</label>
					</td>
					<td>
						<input type="password" name="adminPassword" id="adminPassword" 
							class="text ui-widget-content ui-corner-all">
					</td>
				</tr>
				<c:if test="${sessionScope.admin.isSuperAdmin}">
				<tr>
					<td>
						<label for="superAdmin">超级管理员</label>
					</td>
					<td>
						<input type="checkBox" name="superAdmin" id="superAdmin" value = "1" 
							>
					</td>
				</tr>
				</c:if>
				<!-- <tr>
					<td>
						<input type="submit" id="admin_add_submit" value="提交">
					</td>
				</tr> -->
			</table>
		</form>
		
		<div  id = "admin_priv_form" style = "display :none" >
		<!-- 权限列表 -->
		<form >
			<table id="admin_prov_list" ></table>
			<!-- 
			<div id="admin_prov_pager"></div>
			 -->
		</form>
		</div>
		
		<jsp:include page="/jfz/static/common/jsp/bottom.jsp"/>
		
		<script type="text/javascript">
			//获取数据的url
			var baseUrl = "${path}admin/data";
			var priUrl = "${path}adminPriv/priAdminData";
			var savePriUrl = "${path}adminPriv/savePriData";
			
			var isFirstLoad = true;
			var hasEdit = false;
			
			$(document).ready(function() {
				
				initUI();
				
				initGrid();
				
				initVaildator();
				
			});
			
			/**初始化ui*/
			function initUI() {
				
				$("#fromFdRegisterTime").datepicker();
				
				$("#toFdRegisterTime").datepicker();
				
				$("#admin_search_btn").button({
					icons: {
			        	primary: "ui-icon-search"
			      	},
			      	text:false
				});
				
				$("#admin_add_submit").button();
				
			}
			
			/**初始化grid*/
			function initGrid() {
				$("#admin_list").jqGrid({
					url : baseUrl,
					datatype : "json",
					colNames : ["操作",'管理员账户', '真实姓名','创建时间','上次登录时间'],
					colModel : [
					    {name: 'action', index:'action',align : "center",
							formatter:function(cellvalue, options, rowObject){
								var adminName = rowObject.adminName;
								//var fdName = rowObject.fdName;
								//var fdRealName = rowObject.fdRealName;
								return  "<input type='button' class='admin_del_btn' value='删除' onclick=\"delAdminDialog('"+adminName+"');\" />"
								+ "  <input type='button' class='admin_del_btn' value='管理权限' onclick=\"privManage('"+adminName+"');\" />"; 
							},
						sortable:false},
					   {name : 'adminName',index : 'adminName',width : 55,align : "center"}, 
					   {name : 'adminRealName',ndex : 'adminRealName',width : 90,align : "center"}, 
					   {name : 'createTime',index : 'createTime',width : 100,align : "center"},
					   {name : 'lastLoginTime',index : 'lastLoginTime',width : 100,align : "center"},
					],
					autowidth:true,
					height:650,
					rowNum : 17,
					//rowNum : 3,
					rowList : [10, 20, 30],
					pager : '#admin_pager',
					viewrecords : true,
					gridComplete: function(){
						$(".admin_edit_btn").button();
						$(".admin_del_btn").button();
					},
					caption : "管理员列表"
				}).jqGrid('navGrid', '#admin_pager', {
					edit : false,
					add : false,
					del : false,
					search:false
				}).jqGrid('navButtonAdd','#admin_pager',{
					caption:"添加用户",
					buttonicon:"ui-icon-plus",
					onClickButton:function() {
						addAdminDialog();
					},
					position:"last"
				});
			}
			
			function privManage(adminName){
				openPrivGrid(adminName);
				$("#admin_priv_form").dialog({
					  width: 700,
					  height: 400,
				      modal: true,
				      show:{
				          effect: "fade",
				          duration: 500
				      },
				      buttons:{
				    	  "编辑": function(){
				    		//todo 编辑按钮  
				    		changeGridEditable();
				    	  },
				    	  "保存": function() {
				    		  //addAdmin && addAdmin.call($(this));
				    		  //addAdmin();
				    		  saveEditPrivilege(adminName);
				    	  }
				      },
				      close:function() {
				    	  $("#admin_priv_form").dialog("close");
				    	  adminAddValidator.resetForm();
				      }
				 });
			}
			
			function openPrivGrid(adminName){
				hasEdit = false;
				if(isFirstLoad){
					initPrivGrid(adminName);
				}else{
					var url = priUrl+"?adminName="+adminName;
					$("#admin_prov_list").jqGrid('setGridParam',{url:url}).trigger("reloadGrid");
				}
				isFirstLoad = false;
			}
			
			function initPrivGrid(adminName){
				
				$("#admin_prov_list").jqGrid({
					url : priUrl+"?adminName="+adminName,
					datatype : "json",
					colNames : ['读','写','权限名', '描述','权限id'],
					colModel : [
					    {name: 'read', index:'read',width : 80,align : "center",
							formatter:function(cellvalue, options, rowObject){
								return outPutCheckBox(rowObject.readable,"read_"+rowObject.privilegeId);
							},
						sortable:false},
						{name: 'write', index:'write',width : 80,align : "center",
							formatter:function(cellvalue, options, rowObject){
								//var adminName = rowObject.adminName;
								//return  "<input type='checkBox'  checked="+rowObject.writable+"  />"
								return outPutCheckBox(rowObject.writable,"write_"+rowObject.privilegeId);
							},
						sortable:false},
					   {name : 'priName',index : 'priName',width : 220,align : "center"}, 
					   {name : 'description',index : 'description',width : 250,align : "center"}, 
					   {name: 'privilegeId', index : 'privilegeId',width : 10,align : "center", hidden : true
						   },
					],
					autowidth:true,
					height:240,
					rowNum : 20,
					rowList : [10, 20, 30],
					//pager : '#admin_pager',
					viewrecords : true,
					//gridComplete: function(){
					//	$(".admin_edit_btn").button();
					//	$(".admin_del_btn").button();
					//},
					//caption : "权限列表"
				});
			}
			
			function outPutCheckBox(checked,idName){
				var checkFlag="";
				if(checked){
					checkFlag = "checked"
				}
				return  "<input type='checkBox' id='"+idName+"' "+ checkFlag+"  disabled/>"
			}
			
			function changeGridEditable(){
				hasEdit = true;
				var rowsId = $("#admin_prov_list").jqGrid('getDataIDs');
				if(rowsId){
					for(var i=0;i<rowsId.length;i++){
						var curRowData = $("#admin_prov_list").jqGrid('getRowData',rowsId[i]);
						var id = curRowData['privilegeId']
						var idName = "#read_"+id;
						$(idName).removeAttr("disabled");
						var idWriteName = "#write_"+id;
						$(idWriteName).removeAttr("disabled");
					}
				}
				
				//var length = $("#admin_prov_list").jqGrid('getDataIDs').length;
				//for(var i = 0; i<length;i++){
				//	var idName = "#read_"+i;
				//	$(idName).removeAttr("disabled");
				//	var idWriteName = "#write_"+i;
				//	$(idWriteName).removeAttr("disabled");
				//}
			}
			
			function saveEditPrivilege(adminName){
				if(!hasEdit){
					closePrivDialog();
					return;
				}
				var priString = "";
				var rowsId = $("#admin_prov_list").jqGrid('getDataIDs');
				if(rowsId){
					for(var i=0;i<rowsId.length;i++){
						var curRowData = $("#admin_prov_list").jqGrid('getRowData',rowsId[i]);
						//alert(curRowData.privilegeId);
						var priId = curRowData.privilegeId;
						var idName = "#read_"+priId;
						var idWriteName = "#write_"+priId;
						priString = priString + priId;
						//1表示选中，0表示未被选中，如果拥有写权限，默认添加读权限
						if($(idWriteName).is(":checked")){
							priString = priString+'_'+1+'_'+1;
						}else{
							//priString = priString+'_'+0;
							if($(idName).is(":checked")){
								priString = priString+'_'+1+'_'+0;
							}else{
								priString = priString+'_'+0+'_'+0;
							}
						}
						priString = priString +';';
						//alert();
					}
				}
				var map = {};
				map["priData"]=priString;
				map["adminName"]=adminName;
				//map.put("priData",priString);
				//map.put("adminName",adminName);
				//var url = savePriUrl+'?&priData='+priString;
				//to 发送post 请求
				sendPost(savePriUrl,map);
			}
			
			function sendPost(url,data){
				$.post(url,data,function(data){
						if(data == "true") {
							closePrivDialog();
							$.simpleTip("保存成功");
						} else {
							$.simpleAlter("保存失败");
						}
					},
					 "text");//这里返回的类型有：json,html,xml,text
					
			}
			
			function closePrivDialog(){
				$("#admin_priv_form").dialog("close");
				hasEdit = false;
			}
			
			var adminAddValidator;
			var adminEditValidator;
			
			/**初始化校验*/
			function initVaildator() {
				
				var adminAddValidateOptions = {
					focusCleanup:true,
					focusInvalid:false,
					errorPlacement:function(error,element) {
						element.parent().append("<br>");
						error.appendTo(element.parent());
					},
					rules:{
						adminName:{
							required:true,
							minlength:3,
//							remote:{
//								type:"get",
//								url:"${path}admin/validateAdminByFdName",
//								data:{
//									"fdName":function(){
//										return $.trim($("#admin_add_form #fdName").val())
//									}
//								},
//							}
						},
						adminPassword:{
							required:true,
							minlength:6
						}
					},
					messages:{
						adminName:{
							required:"用户名不能为空",
							minlength:"用户名最少3个字符",
							//remote:"用户名重复"
						},
						adminPassword:{
							required:"密码不能为空",
							minlength:"密码最少6个字符",
						}
					}
						
				};
				
				adminAddValidator = $("#admin_add_form").validate(adminAddValidateOptions);
				
			}
			
			/**用户搜索*/
			function adminSearch(){
				var fields = $("#admin_search_form").serializeArray();
				var url = baseUrl + "?";
				$.each( fields, function(i, field){
				  	url += (field.name + "=" + field.value + "&")
				});
				url = url.substring(0, url.length-1);
				$("#admin_list").jqGrid('setGridParam',{url:url,page:1}).trigger("reloadGrid");
			}
			
			/**打开添加用户对话框*/
			function addAdminDialog() {
				$("#admin_add_form").dialog({
				      modal: true,
				      show:{
				          effect: "fade",
				          duration: 500
				      },
				      buttons:{
				    	  "确认": function() {
				    		  //addAdmin && addAdmin.call($(this));
				    		  addAdmin();
				    	  }
				    	  
				      },
				      close:function() {
				    	  $("#admin_add_form").dialog("destroy");
				    	  adminAddValidator.resetForm();
				      }
				 });
			}
			
			/**添加用户*/
			function addAdmin() {
				$("#admin_add_form").ajaxSubmit({
	    			type:"post",
	    			url:"${path}admin/save",
	    			beforeSubmit:showAddAdminRequest,
	    			success:showAddAdminResponse
	    		});
			}
			
			/**添加用户前，校验*/
			function showAddAdminRequest() {
				return $("#admin_add_form").valid();
			}
			
			/**添加用户之后*/
			function showAddAdminResponse(responseText,statusText) {
				//调用close方法是已经调用过destroy
				$("#admin_add_form").dialog("close");
				if("success" == statusText) {
					if($.parseJSON(responseText)["success"]) {
						$("#admin_list").trigger("reloadGrid");
						$.simpleTip("添加用户成功");
					} else {
						$.simpleAlter("添加用户失败,请确认用户名是否重复以及是否拥有相关权限");
					}
					
				} else {
					$.simpleAlter("添加用户失败");
				}
				adminAddValidator.resetForm();
			}
			
			/**打开删除用户对话框*/
			function delAdminDialog(fdId) {
				var args = {"adminName":fdId};
				$.simpleConfirm("确认删除id为:" + fdId +"的用户吗?", 
						null, null, delAdmin, args);
			}
			
			/**删除用户*/
			function delAdmin(args) {
				$.ajax({
	        		type:"post",
	        		url:"${path}admin/delete",
	        		data:args,
	        		dataType:"json",
	        		success:function(msg) {
	        			if(msg["success"]) {
	        				$.simpleTip("删除成功");
	        				$("#admin_list").trigger("reloadGrid");
	        			} else {
	        				$.simpleAlter("删除id为"+args["fdId"]+"的失败");
	        			}
	        		},
	        		error:function() {
	        			$.simpleAlter("删除id为"+args["fdId"]+"的失败");
	        		}
	        	});
			}
			
		</script>
    
    </body>

</html>